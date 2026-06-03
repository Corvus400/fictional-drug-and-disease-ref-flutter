import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'onboarding covers intro, spotlight completion, skip, and About replay',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EAppFreshOnboarding($);

      await $('メディマスタへようこそ').waitUntilVisible();
      await keyed($, 'onboarding-next').tap();
      await $('主要機能').waitUntilVisible();
      await keyed($, 'onboarding-next').tap();
      await $('実画面ガイド').waitUntilVisible();
      await keyed($, 'onboarding-start').tap();
      await $('検索フィールド').waitUntilVisible();
      await keyed($, 'onboarding-spotlight-action-search-field').tap();
      await $('主ナビゲーション').waitUntilVisible();
      await keyed($, 'onboarding-spotlight-action-navigation-tabs').tap();
      await $('アプリについて').waitUntilVisible();
      await keyed($, 'onboarding-spotlight-action-about-button').tap();
      await keyed($, 'search-field').waitUntilVisible();

      await pumpE2EAppFreshOnboarding($);
      await $('メディマスタへようこそ').waitUntilVisible();
      await keyed($, 'onboarding-skip').tap();
      await keyed($, 'search-field').waitUntilVisible();

      await pumpE2EApp($);
      await keyed($, 'app-tab-header-about-button').tap();
      await keyed($, 'about-onboarding-tile').waitUntilVisible();
      await keyed($, 'about-onboarding-tile').tap();
      await $('メディマスタへようこそ').waitUntilVisible();
      await keyed($, 'onboarding-skip').tap();
      await keyed($, 'search-field').waitUntilVisible();
    },
    timeout: e2eTimeout,
  );
}
