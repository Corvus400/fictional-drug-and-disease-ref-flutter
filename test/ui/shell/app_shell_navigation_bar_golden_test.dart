import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';
import '../_common/navigation_bar_golden_helpers.dart';

void main() {
  runNavigationBarStateMatrixGolden(
    fileNamePrefix: 'app_shell_navigation_bar',
    description: 'App shell NavigationBar states',
  );

  runGoldenMatrix(
    fileNamePrefix: 'app_shell_navigation_rail',
    description: 'App shell NavigationRail landscape states',
    sizes: const ['iphone_landscape', 'ipad_landscape'],
    customSizes: const {
      'iphone_landscape': Size(844, 390),
      'ipad_landscape': Size(1194, 834),
    },
    builder: (theme, size, scaler) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Row(
          children: [
            AppShellAdaptiveNavigation(
              selectedIndex: AppShellTab.search.index,
              onDestinationSelected: (_) {},
            ),
            Expanded(
              child: ColoredBox(
                color: theme.colorScheme.surfaceContainerLowest,
                child: Center(
                  child: Text(
                    'App shell',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
