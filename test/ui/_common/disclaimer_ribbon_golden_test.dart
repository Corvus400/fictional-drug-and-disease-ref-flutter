import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  _ribbonGolden('phone');
  _ribbonGolden('tablet');
}

void _ribbonGolden(String sizeName) {
  runGoldenMatrix(
    fileNamePrefix: 'disclaimer_ribbon_$sizeName',
    description: 'DisclaimerRibbon $sizeName',
    sizes: [sizeName],
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: DisclaimerRibbon(),
        ),
      ),
    ),
  );
}
