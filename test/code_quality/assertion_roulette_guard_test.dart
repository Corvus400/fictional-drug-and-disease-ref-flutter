import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test bodies contain at most one assertion', () {
    final violations = <String>[];

    for (final path in _testDartFiles()) {
      final source = File(path).readAsStringSync();
      for (final body in _findTestBodies(source)) {
        final assertionCount = _assertionCount(body.body);
        if (assertionCount > 1) {
          violations.add(
            '$path:${body.line}: ${body.name} contains '
            '$assertionCount assertions',
          );
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Split assertion roulette tests so each test observes one outcome:\n'
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

List<_TestBody> _findTestBodies(String source) {
  final bodies = <_TestBody>[];
  final testCall = RegExp(r'\b(test|testWidgets|goldenTest)\s*\(');
  var searchStart = 0;

  while (true) {
    final match = testCall.firstMatch(source.substring(searchStart));
    if (match == null) {
      return bodies;
    }

    final callStart = searchStart + match.start;
    final name = _readFirstStringArgument(source, searchStart + match.end);
    final bodyStart = _findCallbackBodyStart(source, searchStart + match.end);
    if (bodyStart == -1) {
      searchStart = callStart + 1;
      continue;
    }

    final bodyEnd = _findMatchingBrace(source, bodyStart);
    if (bodyEnd == -1) {
      searchStart = bodyStart + 1;
      continue;
    }

    bodies.add(
      _TestBody(
        line: _lineNumber(source, callStart),
        name: name ?? '(unnamed test)',
        body: source.substring(bodyStart + 1, bodyEnd),
      ),
    );
    searchStart = bodyEnd + 1;
  }
}

String? _readFirstStringArgument(String source, int start) {
  var index = start;
  while (index < source.length && source.codeUnitAt(index) <= 32) {
    index++;
  }
  if (index >= source.length) {
    return null;
  }

  final quote = source[index];
  if (quote != "'" && quote != '"') {
    return null;
  }

  final buffer = StringBuffer();
  index++;
  while (index < source.length) {
    final character = source[index];
    if (character == r'\') {
      index += 2;
      continue;
    }
    if (character == quote) {
      return buffer.toString();
    }
    buffer.write(character);
    index++;
  }
  return null;
}

int _findCallbackBodyStart(String source, int start) {
  var parenDepth = 1;
  for (var index = start; index < source.length; index++) {
    final character = source[index];
    if (character == '(') {
      parenDepth++;
    } else if (character == ')') {
      parenDepth--;
      if (parenDepth == 0) {
        return -1;
      }
    } else if (character == '{' && parenDepth == 1) {
      return index;
    }
  }
  return -1;
}

int _findMatchingBrace(String source, int start) {
  var depth = 0;
  var inString = false;
  var stringQuote = '';

  for (var index = start; index < source.length; index++) {
    final character = source[index];
    if (inString) {
      if (character == r'\') {
        index++;
      } else if (character == stringQuote) {
        inString = false;
      }
      continue;
    }

    if (character == "'" || character == '"') {
      inString = true;
      stringQuote = character;
    } else if (character == '{') {
      depth++;
    } else if (character == '}') {
      depth--;
      if (depth == 0) {
        return index;
      }
    }
  }
  return -1;
}

int _assertionCount(String source) {
  return RegExp(
    r'\b(?:expect|expectLater|fail)\s*\(',
  ).allMatches(source).length;
}

int _lineNumber(String source, int offset) {
  return '\n'.allMatches(source.substring(0, offset)).length + 1;
}

class _TestBody {
  const _TestBody({
    required this.line,
    required this.name,
    required this.body,
  });

  final int line;
  final String name;
  final String body;
}
