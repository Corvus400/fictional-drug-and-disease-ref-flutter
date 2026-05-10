import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Root shell with persistent bottom navigation.
class AppShell extends StatelessWidget {
  /// Creates an app shell.
  const AppShell({required this.navigationShell, super.key});

  /// Stateful shell managed by go_router.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppShellBottomNavigation(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          logger.i('TAB_CHANGE: $index');
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

/// Shared shell bottom chrome: disclaimer ribbon above app navigation.
class AppShellBottomNavigation extends StatelessWidget {
  /// Creates shell bottom navigation.
  const AppShellBottomNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  /// Current selected destination index.
  final int selectedIndex;

  /// Destination selection callback.
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DisclaimerRibbon(),
        NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: l10n.tabSearch,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bookmark_outline),
              label: l10n.tabBookmarks,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history),
              label: l10n.tabHistory,
            ),
            NavigationDestination(
              icon: const Icon(Icons.calculate_outlined),
              label: l10n.tabCalc,
            ),
          ],
        ),
      ],
    );
  }
}
