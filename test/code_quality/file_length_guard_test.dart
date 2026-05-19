import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('non-generated Dart files stay within their root line limits', () {
    final violations = <String>[];

    final limits = {
      'lib': 1000,
      'test': 12000,
    };

    for (final root in limits.keys) {
      for (final file
          in Directory(root)
              .listSync(recursive: true)
              .whereType<File>()
              .where((file) => file.path.endsWith('.dart'))) {
        if (_isExcluded(file.path)) {
          continue;
        }

        final lineCount = file.readAsLinesSync().length;
        final limit = limits[root]!;
        if (lineCount > limit) {
          violations.add('${file.path}: $lineCount lines (limit: $limit)');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Split files by responsibility before they exceed their limit:\n'
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
