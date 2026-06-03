import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test bodies contain at most one real assertion', () {
    final violations = <String>[];

    for (final path in _testDartFiles()) {
      violations
        ..addAll(_assertionRouletteViolations(path))
        ..addAll(_pseudoAssertionViolations(path))
        ..addAll(_packedAssertionViolations(path));
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Split assertion roulette tests so each test observes one outcome. '
          'Assertions hidden behind same-file helpers still belong to the '
          'calling test. Object.hashAll is not an assertion:\n'
          '${violations.join('\n')}',
    );
  });

  test('rejects boolean condition list packs', () {
    final violations = _packedAssertionViolationsForSource(
      path: 'sample_test.dart',
      source: '''
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('packed booleans', () {
    expect([1 == 1, 2 == 2], everyElement(isTrue));
  });
}
''',
    );

    expect(violations.single.reason, contains('Boolean condition lists'));
  });

  test('rejects boolean condition map packs', () {
    final violations = _packedAssertionViolationsForSource(
      path: 'sample_test.dart',
      source: '''
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('packed booleans', () {
    expect({'left': 1 == 1, 'right': true}, {'left': true, 'right': true});
  });
}
''',
    );

    expect(violations.single.reason, contains('Boolean condition maps'));
  });
}

Iterable<String> _testDartFiles() sync* {
  for (final root in ['test', 'patrol_test']) {
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

List<String> _pseudoAssertionViolations(String path) {
  if (!_rejectPseudoAssertions(path)) {
    return const [];
  }

  final source = File(path).readAsStringSync();
  final parsed = parseString(
    content: source,
    path: path,
    throwIfDiagnostics: false,
  );
  final visitor = _PseudoAssertionVisitor(parsed.lineInfo);
  parsed.unit.accept(visitor);
  return [
    for (final line in visitor.lines)
      _pseudoAssertionMessage(path: path, line: line),
  ];
}

List<String> _packedAssertionViolations(String path) {
  final source = File(path).readAsStringSync();
  return [
    for (final violation in _packedAssertionViolationsForSource(
      path: path,
      source: source,
    ))
      '$path:${violation.line}: ${violation.reason}',
  ];
}

List<_PackedAssertionViolation> _packedAssertionViolationsForSource({
  required String path,
  required String source,
}) {
  final parsed = parseString(
    content: source,
    path: path,
    throwIfDiagnostics: false,
  );
  final visitor = _PackedAssertionVisitor(parsed.lineInfo);
  parsed.unit.accept(visitor);
  return visitor.violations;
}

String _pseudoAssertionMessage({required String path, required int line}) {
  return '$path:$line: Object.hashAll is not an assertion; use expect or split '
      'the test';
}

bool _rejectPseudoAssertions(String path) {
  return path.startsWith('test/application/onboarding/') ||
      path.startsWith('test/ui/onboarding/') ||
      path == 'patrol_test/onboarding_e2e_test.dart';
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

class _PseudoAssertionVisitor extends RecursiveAstVisitor<void> {
  _PseudoAssertionVisitor(this._lineInfo);

  final LineInfo _lineInfo;
  final lines = <int>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.target is SimpleIdentifier &&
        (node.target! as SimpleIdentifier).name == 'Object' &&
        node.methodName.name == 'hashAll') {
      lines.add(_lineInfo.getLocation(node.offset).lineNumber);
    }
    super.visitMethodInvocation(node);
  }
}

class _PackedAssertionVisitor extends RecursiveAstVisitor<void> {
  _PackedAssertionVisitor(this._lineInfo);

  final LineInfo _lineInfo;
  final violations = <_PackedAssertionViolation>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.methodName.name == 'expect' && node.target == null) {
      final arguments = node.argumentList.arguments;
      if (arguments.length >= 2) {
        final actual = arguments[0];
        final matcher = arguments[1];
        if (_isBooleanListPack(actual, matcher)) {
          _addViolation(
            node,
            'Boolean condition lists hide assertion roulette; split the test '
            'or assert one named aggregate failure value.',
          );
        } else if (_isBooleanMapPack(actual, matcher)) {
          _addViolation(
            node,
            'Boolean condition maps hide assertion roulette; split the test '
            'or assert one named aggregate failure value.',
          );
        }
      }
    }
    super.visitMethodInvocation(node);
  }

  void _addViolation(MethodInvocation node, String reason) {
    violations.add(
      _PackedAssertionViolation(
        line: _lineInfo.getLocation(node.offset).lineNumber,
        reason: reason,
      ),
    );
  }
}

class _PackedAssertionViolation {
  const _PackedAssertionViolation({required this.line, required this.reason});

  final int line;
  final String reason;
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
const _testNames = {'test', 'testWidgets', 'goldenTest', 'patrolTest'};

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

bool _isBooleanListPack(Expression actual, Expression matcher) {
  return actual is ListLiteral &&
      actual.elements.any(_isBooleanLikeNode) &&
      (_matcherSourceContains(matcher, 'everyElement(isTrue)') ||
          _matcherSourceContains(matcher, 'everyElement(isFalse)') ||
          matcher is ListLiteral);
}

bool _isBooleanMapPack(Expression actual, Expression matcher) {
  if (actual is! SetOrMapLiteral || matcher is! SetOrMapLiteral) {
    return false;
  }

  return actual.elements.any((element) {
    return element is MapLiteralEntry && _isBooleanLikeNode(element.value);
  });
}

bool _matcherSourceContains(Expression matcher, String pattern) {
  return matcher.toSource().replaceAll(RegExp(r'\s+'), '').contains(pattern);
}

bool _isBooleanLikeNode(AstNode node) {
  if (node is BooleanLiteral) {
    return true;
  }
  if (node is BinaryExpression) {
    return _booleanOperators.contains(node.operator.lexeme);
  }
  if (node is PrefixExpression) {
    return node.operator.lexeme == '!';
  }
  if (node is MethodInvocation) {
    return _booleanMethodNames.contains(node.methodName.name);
  }
  if (node is PropertyAccess) {
    return _booleanPropertyNames.contains(node.propertyName.name);
  }
  if (node is PrefixedIdentifier) {
    return _booleanPropertyNames.contains(node.identifier.name);
  }
  if (node is ListLiteral) {
    return node.elements.any(_isBooleanLikeNode);
  }
  if (node is SetOrMapLiteral) {
    return node.elements.any((element) {
      return element is MapLiteralEntry && _isBooleanLikeNode(element.value);
    });
  }
  return false;
}

const _booleanOperators = {
  '==',
  '!=',
  '<',
  '<=',
  '>',
  '>=',
  '&&',
  '||',
};
const _booleanMethodNames = {
  'any',
  'contains',
  'endsWith',
  'every',
  'isAfter',
  'isBefore',
  'isEmpty',
  'isNotEmpty',
  'startsWith',
};
const _booleanPropertyNames = {'isEmpty', 'isNotEmpty', 'isFinite', 'isNaN'};
