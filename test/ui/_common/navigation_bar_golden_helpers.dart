import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';

/// Registers a golden matrix for the shell bottom navigation.
void runNavigationBarGolden({
  required String fileNamePrefix,
  required String description,
  required int selectedIndex,
  required String bodyLabel,
}) {
  runGoldenMatrix(
    fileNamePrefix: fileNamePrefix,
    description: description,
    builder: (theme, size, scaler) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: _NavigationBody(label: bodyLabel),
        bottomNavigationBar: AppShellBottomNavigation(
          selectedIndex: selectedIndex,
          onDestinationSelected: (_) {},
        ),
      ),
    ),
  );
}

/// Registers a golden matrix with every selected destination visible at once.
void runNavigationBarStateMatrixGolden({
  required String fileNamePrefix,
  required String description,
}) {
  runGoldenMatrix(
    fileNamePrefix: fileNamePrefix,
    description: description,
    builder: (theme, size, scaler) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(
        body: _NavigationStateMatrixBody(),
      ),
    ),
  );
}

class _NavigationBody extends StatelessWidget {
  const _NavigationBody({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return ColoredBox(
      color: palette.background,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: palette.ink2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _NavigationStateMatrixBody extends StatelessWidget {
  const _NavigationStateMatrixBody();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return ColoredBox(
      color: palette.background,
      child: Column(
        children: [
          const Expanded(child: _NavigationBody(label: 'App shell')),
          for (var selectedIndex = 0; selectedIndex < 4; selectedIndex += 1)
            AppShellBottomNavigation(
              selectedIndex: selectedIndex,
              onDestinationSelected: (_) {},
            ),
        ],
      ),
    );
  }
}
