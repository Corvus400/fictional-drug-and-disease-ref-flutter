import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'shell covers navigation, adaptive chrome, disclaimer, and licenses',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EApp($);
      expect(find.textContaining('架空データ'), findsWidgets);

      await $('検索').waitUntilVisible();
      await openBookmarksTab($);
      await keyed($, 'bookmarks-search-panel').waitUntilVisible();
      await openHistoryTab($);
      await keyed($, 'history-empty-cta').waitUntilVisible();
      await openCalcTab($);
      await keyed($, 'calc-input-heightCm').waitUntilVisible();

      await keyed($, 'app-tab-header-about-button').tap();
      await $('アプリについて').waitUntilVisible();
      await keyed($, 'about-licenses-tile').tap();
    },
    timeout: e2eTimeout,
  );
}
