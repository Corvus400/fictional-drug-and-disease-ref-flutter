import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('detail UI dimensions are sourced from DetailConstants', () {
    final violations = <String>[];
    for (final file in _targetDartFiles()) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index += 1) {
        final line = lines[index];
        if (_containsInlineDimension(line)) {
          violations.add('${file.path}:${index + 1}: ${line.trim()}');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Move detail UI dimensions to DetailConstants:\n'
          '${violations.join('\n')}',
    );
  });

  test('detail UI colors are sourced from theme tokens', () {
    final violations = <String>[];
    for (final file in _targetDartFiles()) {
      final lines = file.readAsLinesSync();
      for (var index = 0; index < lines.length; index += 1) {
        final line = lines[index];
        if (_containsHardcodedColor(line)) {
          violations.add('${file.path}:${index + 1}: ${line.trim()}');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Move detail UI colors to ThemeExtension/AppPalette tokens:\n'
          '${violations.join('\n')}',
    );
  });

  test('hardcoded color detector covers constructor and Colors shortcuts', () {
    expect(_containsHardcodedColor('color: Color(0xFF1F5BB5),'), isTrue);
    expect(
      _containsHardcodedColor('color: const Color.fromARGB(255, 1, 2, 3),'),
      isTrue,
    );
    expect(
      _containsHardcodedColor('backgroundColor: Color.fromRGBO(1, 2, 3, 1),'),
      isTrue,
    );
    expect(_containsHardcodedColor('color: Colors.red,'), isTrue);
    expect(_containsHardcodedColor('color: Colors.transparent,'), isFalse);
    expect(_containsHardcodedColor('color: colors.primary,'), isFalse);
    expect(
      _containsHardcodedColor('color: AppPalette.light.primary,'),
      isFalse,
    );
  });
}

Iterable<File> _targetDartFiles() sync* {
  const targetDirs = [
    'lib/ui/detail',
    'lib/ui/drug',
    'lib/ui/disease',
  ];
  for (final path in targetDirs) {
    yield* Directory(path)
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where(
          (file) => !file.path.endsWith('detail_constants.dart'),
        );
  }
}

bool _containsInlineDimension(String line) {
  return _inlineDimensionPatterns.any((pattern) => pattern.hasMatch(line));
}

bool _containsHardcodedColor(String line) {
  return _hardcodedColorPatterns.any((pattern) => pattern.hasMatch(line));
}

final _inlineDimensionPatterns = [
  RegExp(r'\bSizedBox\s*\([^)]*\b(?:height|width):\s*[0-9]'),
  RegExp(r'\bEdgeInsets\.(?:all|only|symmetric)\s*\([^)]*[0-9]'),
  RegExp(r'\bDuration\s*\([^)]*milliseconds:\s*[0-9]'),
  RegExp(r'\b(?:height|width|size|minHeight):\s*[0-9]'),
  RegExp(r'\b(?:spacing|runSpacing):\s*[0-9]'),
  RegExp(r'\bBorder\.all\s*\([^)]*width:\s*[0-9]'),
  RegExp(r'\bBorderRadius\.circular\s*\(\s*[0-9]'),
  RegExp(r'\bTextStyle\s*\([^)]*height:\s*[0-9]'),
];

final _hardcodedColorPatterns = [
  RegExp(r'\bColor\s*\(\s*0x[0-9A-Fa-f]{6,8}\s*\)'),
  RegExp(r'\bColor\.fromARGB\s*\('),
  RegExp(r'\bColor\.fromRGBO\s*\('),
  RegExp(r'\bColors\.(?!transparent\b)[A-Za-z]'),
];
