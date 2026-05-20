import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'bookmarks and history cover create, filter, search, and delete',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EApp($);

      await searchFor($, e2eDrugName);
      await keyed($, 'drug-card-$e2eDrugId').tap();
      await $('医薬品詳細').waitUntilVisible();
      await $('ブックマーク').tap();

      await openBookmarksTab($);
      await keyed($, 'bookmarks-result-count').waitUntilVisible();
      await $('医薬品').tap();
      await keyed($, 'bookmarks-search-box').enterText(e2eDrugName);
      await keyed($, 'bookmarks-result-count').waitUntilVisible();

      await openHistoryTab($);
      await keyed($, 'history-bulk-delete-fab').waitUntilVisible();
      await keyed($, 'history-bulk-delete-fab').tap();
      await keyed($, 'history-bulk-delete-confirm-dialog').waitUntilVisible();
      await $('キャンセル').tap();
    },
    timeout: e2eTimeout,
  );
}
