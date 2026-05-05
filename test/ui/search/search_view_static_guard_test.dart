import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'SearchView does not contain fixed sample data or filter selections',
    () {
      final sources = [
        File('lib/ui/search/search_view.dart').readAsStringSync(),
        File('lib/ui/search/widgets/search_top_chrome.dart').readAsStringSync(),
        File(
          'lib/ui/search/widgets/search_phase_section.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/widgets/search_result_toolbar.dart',
        ).readAsStringSync(),
        File('lib/ui/search/widgets/drug_result_card.dart').readAsStringSync(),
        File(
          'lib/ui/search/widgets/disease_result_card.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/widgets/search_history_dropdown.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/widgets/filter/drug_filter_sheet.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/widgets/filter/disease_filter_sheet.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/widgets/filter/round6_filter_sheet_scaffold.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/format/regulatory_badge_colors.dart',
        ).readAsStringSync(),
        File(
          'lib/ui/search/format/search_label_formatters.dart',
        ).readAsStringSync(),
        File('lib/ui/search/format/search_sort_sheet.dart').readAsStringSync(),
      ];
      final source = sources.join('\n');
      const forbiddenFragments = [
        'アムロジン',
        'アムロジピンベシル酸塩',
        'C08CA01',
        'drug_skeleton',
        '2025/03/14',
        "regulatoryClass: ['",
        "dosageForm: ['",
        "'毒薬'",
        "'劇薬'",
        "'処方箋医薬品'",
        "'錠剤'",
        "'ATC: ",
        "'改訂 ",
        "'Rx'",
        "'Dx'",
        "'絞り込み +",
        "'size': 'S'",
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
