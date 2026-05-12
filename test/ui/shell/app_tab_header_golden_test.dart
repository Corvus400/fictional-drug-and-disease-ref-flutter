import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  for (final tab in AppShellTab.values) {
    runHistoryGoldenMatrix(
      fileNamePrefix: 'app_tab_header_${tab.name}',
      description: 'AppTabHeader ${tab.name}',
      builder: (theme, size, deviceName, textScaler, textScalerName) {
        final toolbarHeight = size.shortestSide >= 600 ? 64.0 : 56.0;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            appBar: AppTabHeader(tab: tab, toolbarHeight: toolbarHeight),
            body: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}
