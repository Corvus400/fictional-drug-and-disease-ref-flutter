import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'detail covers tabs, preview, bookmarks, and related links',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EApp($);

      await searchFor($, e2eDrugName);
      await keyed($, 'drug-card-$e2eDrugId').tap();
      await $('医薬品詳細').waitUntilVisible();
      await keyed(
        $,
        'drug-detail-hero-image-preview-trigger-$e2eDrugId',
      ).tap();
      await keyed(
        $,
        'drug-detail-hero-image-preview-$e2eDrugId',
      ).waitUntilVisible();
      await keyed($, 'drug-detail-hero-image-preview-close-$e2eDrugId').tap();
      await $.pumpAndSettle();
      await tapKey($, 'drug-detail-tab-dose');
      await ensureKeyVisible($, 'drug-detail-dose-inner-tabs');
      await keyed($, 'drug-detail-dose-inner-tabs').waitUntilVisible();
      await tapKey($, 'drug-detail-tab-caution');
      await ensureKeyVisible($, 'drug-detail-interaction-inner-tabs');
      await keyed($, 'drug-detail-interaction-inner-tabs').waitUntilVisible();
      await tapKey($, 'drug-detail-tab-adverseEffects');
      await ensureKeyVisible($, 'drug-detail-frequency-row');
      await keyed($, 'drug-detail-frequency-row').waitUntilVisible();
      await tapKey($, 'drug-detail-tab-related');
      await keyed($, 'detail-carousel-card').tap();
      await $('疾患詳細').waitUntilVisible();
      await tapKey($, 'disease-detail-tab-treatment');
      await tapKey($, 'disease-detail-tab-related');
    },
    timeout: e2eTimeout,
  );
}
