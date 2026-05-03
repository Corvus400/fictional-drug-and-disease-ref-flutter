import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          logger.i('TAB_CHANGE: $index');
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
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
    );
  }
}
