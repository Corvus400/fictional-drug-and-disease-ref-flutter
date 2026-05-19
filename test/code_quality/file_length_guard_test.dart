import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non-generated Dart files stay within 1000 lines', () {
    final violations = <String>[];

    for (final root in ['lib', 'test']) {
      for (final file
          in Directory(root)
              .listSync(recursive: true)
              .whereType<File>()
              .where((file) => file.path.endsWith('.dart'))) {
        if (_isExcluded(file.path)) {
          continue;
        }

        final lineCount = file.readAsLinesSync().length;
        if (lineCount > 1000) {
          violations.add('${file.path}: $lineCount lines');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Split files by responsibility before they exceed 1000 lines:\n'
          '${violations.join('\n')}',
    );
  });
}

bool _isExcluded(String path) {
  return path.endsWith('.g.dart') ||
      path.endsWith('.freezed.dart') ||
      path == 'lib/l10n/app_localizations.dart' ||
      path == 'lib/l10n/app_localizations_ja.dart';
}
