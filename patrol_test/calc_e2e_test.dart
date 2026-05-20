import 'package:patrol/patrol.dart';

import 'e2e_common.dart';

void main() {
  patrolTest(
    'calc covers BMI, eGFR, CrCl, validation, history, and iOS toolbar',
    platformAutomatorConfig: platformAutomatorConfig,
    ($) async {
      await pumpE2EApp($);

      await openCalcTab($);
      await keyed($, 'calc-input-heightCm').waitUntilVisible();
      await enterCalcInput($, 'calc-input-heightCm', '170');
      await enterCalcInput($, 'calc-input-weightKg', '65');
      await $('普通体重').waitUntilVisible();

      await selectCalcTool($, 'eGFR');
      await enterCalcInput($, 'calc-input-ageYears', '45');
      await enterCalcInput($, 'calc-input-serumCreatinineMgDl', '0.9');
      await $('G2 軽度低下').waitUntilVisible();

      await selectCalcTool($, 'CrCl');
      await enterCalcInput($, 'calc-input-ageYears', '45');
      await enterCalcInput($, 'calc-input-weightKg', '65');
      await enterCalcInput($, 'calc-input-serumCreatinineMgDl', '0.9');
      await keyed($, 'calc-result-value').waitUntilVisible();

      await selectCalcTool($, 'BMI');
      await enterCalcInput($, 'calc-input-heightCm', '20');
      await $('50.0-250.0 cm').waitUntilVisible();

      if (showsIOSPhoneInputToolbar($)) {
        await keyed($, 'calc-input-heightCm').tap();
        await $('完了').waitUntilVisible();
      }
    },
    timeout: e2eTimeout,
  );
}
