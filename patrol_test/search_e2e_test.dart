import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'search covers drug, disease, empty, filter, sort, and load-more',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EApp($);
      verifyRequestedOrientation($.tester.element(find.byType(MaterialApp)));

      await keyed($, 'search-field').waitUntilVisible();
      await searchFor($, e2eDrugName);
      await keyed($, 'drug-card-$e2eDrugId').waitUntilVisible();

      final usesUtilityPane = find
          .byKey(const ValueKey<String>('search-utility-history-section'))
          .evaluate()
          .isNotEmpty;
      if (usesUtilityPane) {
        await keyed($, 'search-utility-history-section').waitUntilVisible();
      } else {
        await $('疾患').tap();
        await $('医薬品').tap();
        await keyed($, 'search-history-inline').waitUntilVisible();
      }

      await keyed($, 'search-query-clear-button').tap();
      await searchFor($, 'ト');
      final resultsList = find.byKey(
        const PageStorageKey<String>('drugSearchResults'),
      );
      await keyed($, 'drug-card-drug_0080').waitUntilVisible();
      await $.tester.drag(resultsList, const Offset(0, -2600));
      await $.pump(const Duration(seconds: 1));
      await $.tester.drag(resultsList, const Offset(0, -800));
      await $.pumpAndSettle();
      await ensureKeyVisible($, 'drug-card-drug_0100');

      if (usesUtilityPane) {
        await scrollSearchUtilityPaneTo($, 'search-utility-filter-section');
        await tapKey($, 'search-utility-filter-reset');
        await tapKey($, 'search-utility-filter-apply');
        await scrollSearchUtilityPaneTo($, 'search-utility-sort-section');
        await tapKey($, 'search-utility-sort-brand_name_kana');
      } else {
        await tapKey($, 'search-filter-fab');
        await keyed($, 'search-round6-filter-sheet').waitUntilVisible();
        await tapKey($, 'filter-sheet-reset-button');
        await tapKey($, 'filterApplyCta');
        await tapKey($, 'search-sort-toolbar-button');
        await keyed($, 'search-sort-sheet').waitUntilVisible();
        await keyed($, 'search-sort-row-drug-revised').tap();
      }
      await keyed($, 'search-query-clear-button').tap();

      await $('疾患').tap();
      await searchFor($, e2eDiseaseName);
      await keyed($, 'disease-card-$e2eDiseaseId').waitUntilVisible();

      await keyed($, 'search-field').enterText('存在しない検索語');
      await $.tester.testTextInput.receiveAction(TextInputAction.search);
      await $.pumpAndSettle();
      await $('該当する結果がありません').waitUntilVisible();

      await keyed($, 'search-field').tap();
      await $(Scrollable).waitUntilVisible();
    },
    timeout: e2eTimeout,
  );
}
