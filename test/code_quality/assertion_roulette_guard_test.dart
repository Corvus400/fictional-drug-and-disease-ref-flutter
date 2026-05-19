import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test bodies contain at most one assertion', () {
    final violations = <String>[];

    for (final path in _testDartFiles()) {
      violations.addAll(_assertionRouletteViolations(path));
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Split assertion roulette tests so each test observes one outcome. '
          'Assertions hidden behind same-file helpers still belong to the '
          'calling test:\n'
          '${violations.join('\n')}',
    );
  });
}

Iterable<String> _testDartFiles() sync* {
  for (final root in ['test', 'integration_test']) {
    final directory = Directory(root);
    if (!directory.existsSync()) {
      continue;
    }

    for (final entity in directory.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      if (entity.path ==
          'test/code_quality/assertion_roulette_guard_test.dart') {
        continue;
      }
      yield entity.path;
    }
  }
}

List<String> _assertionRouletteViolations(String path) {
  final source = File(path).readAsStringSync();
  final parsed = parseString(
    content: source,
    path: path,
    throwIfDiagnostics: false,
  );
  final functionVisitor = _FunctionIndexVisitor();
  parsed.unit.accept(functionVisitor);

  final testVisitor = _TestInvocationVisitor(parsed.lineInfo);
  parsed.unit.accept(testVisitor);

  final violations = <String>[];
  for (final invocation in testVisitor.invocations) {
    final counter = _AssertionCounter(functionVisitor.functions);
    invocation.body.accept(counter);

    if (counter.count > 1) {
      final helperSuffix = counter.helpers.isEmpty
          ? ''
          : ' via helpers: ${counter.helpers.toList()..sort()}';
      violations.add(
        '$path:${invocation.line}: ${invocation.name} contains '
        '${counter.count} assertions$helperSuffix',
      );
    }
  }
  return violations;
}

class _FunctionIndexVisitor extends RecursiveAstVisitor<void> {
  final functions = <String, FunctionBody>{};

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    functions[node.name.lexeme] = node.functionExpression.body;
    super.visitFunctionDeclaration(node);
  }
}

class _TestInvocationVisitor extends RecursiveAstVisitor<void> {
  _TestInvocationVisitor(this._lineInfo);

  final LineInfo _lineInfo;
  final invocations = <_TestInvocation>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (_isTestCall(node)) {
      final body = _callbackBody(node);
      if (body != null) {
        invocations.add(
          _TestInvocation(
            line: _lineInfo.getLocation(node.offset).lineNumber,
            name: _testName(node),
            body: body,
          ),
        );
      }
    }
    super.visitMethodInvocation(node);
  }
}

class _AssertionCounter extends RecursiveAstVisitor<void> {
  _AssertionCounter(this._functions);

  final Map<String, FunctionBody> _functions;
  final _stack = <String>{};
  final helpers = <String>{};
  int count = 0;

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    // Local helper declarations are counted when the helper is called.
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final name = node.methodName.name;
    if (_assertionNames.contains(name)) {
      count++;
      return;
    }

    final helper = _functions[name];
    if (node.target == null && helper != null && !_stack.contains(name)) {
      helpers.add(name);
      _stack.add(name);
      helper.accept(this);
      _stack.remove(name);
      return;
    }

    super.visitMethodInvocation(node);
  }
}

class _TestInvocation {
  const _TestInvocation({
    required this.line,
    required this.name,
    required this.body,
  });

  final int line;
  final String name;
  final FunctionBody body;
}

const _assertionNames = {'expect', 'expectLater', 'fail'};
const _testNames = {'test', 'testWidgets', 'goldenTest'};

bool _isTestCall(MethodInvocation node) {
  return node.target == null && _testNames.contains(node.methodName.name);
}

FunctionBody? _callbackBody(MethodInvocation node) {
  for (final argument in node.argumentList.arguments) {
    if (argument is FunctionExpression) {
      return argument.body;
    }
  }
  return null;
}

String _testName(MethodInvocation node) {
  final arguments = node.argumentList.arguments;
  if (arguments.isEmpty) {
    return '(unnamed test)';
  }

  final firstArgument = arguments.first;
  if (firstArgument is StringLiteral) {
    return firstArgument.stringValue ?? firstArgument.toSource();
  }
  return firstArgument.toSource();
}
