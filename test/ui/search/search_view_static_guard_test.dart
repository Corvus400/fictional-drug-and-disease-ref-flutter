import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'SearchView does not contain fixed sample data or filter selections',
    () {
      final source = File('lib/ui/search/search_view.dart').readAsStringSync();
      const forbiddenFragments = [
        'アムロジン',
        'アムロジピンベシル酸塩',
        'C08CA01',
        'drug_skeleton',
        '2025/03/14',
        "regulatoryClass: ['",
        "dosageForm: ['",
        "'劇薬'",
        "'処方箋医薬品'",
        "'錠剤'",
      ];

      for (final fragment in forbiddenFragments) {
        expect(
          source,
          isNot(contains(fragment)),
          reason:
              'SearchView must render state/domain/l10n data, not $fragment',
        );
      }
    },
  );
}
