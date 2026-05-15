import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
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
    final shellUsesNavigationRail = _usesNavigationRail(
      BoxConstraints.tight(MediaQuery.sizeOf(context)),
    );
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final navigation = AppShellAdaptiveNavigation(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              logger.i('TAB_CHANGE: $index');
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          );
          if (!_usesNavigationRail(constraints)) {
            return navigationShell;
          }
          return Row(
            children: [
              navigation,
              Expanded(child: navigationShell),
            ],
          );
        },
      ),
      bottomNavigationBar: shellUsesNavigationRail
          ? const DisclaimerRibbon()
          : AppShellAdaptiveNavigation(
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

bool _usesNavigationRail(BoxConstraints constraints) {
  return constraints.maxWidth > constraints.maxHeight;
}

/// Adaptive app-shell navigation.
class AppShellAdaptiveNavigation extends StatelessWidget {
  /// Creates adaptive app-shell navigation.
  const AppShellAdaptiveNavigation({
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!_usesNavigationRail(constraints)) {
          return AppShellBottomNavigation(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
          );
        }

        final railWidth = constraints.maxHeight >= 600 ? 72.0 : 52.0;
        return SizedBox(
          key: const ValueKey('app-shell-navigation-rail-box'),
          width: railWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                right: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: SafeArea(
              right: false,
              bottom: false,
              child: NavigationRail(
                key: const ValueKey('app-shell-navigation-rail'),
                selectedIndex: selectedIndex,
                minWidth: railWidth,
                labelType: NavigationRailLabelType.none,
                onDestinationSelected: onDestinationSelected,
                destinations: [
                  for (final tab in AppShellTab.values)
                    NavigationRailDestination(
                      icon: Tooltip(
                        message: tab.label(context),
                        child: Icon(tab.icon),
                      ),
                      label: Text(tab.label(context)),
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DisclaimerRibbon(),
        NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final tab in AppShellTab.values)
              NavigationDestination(
                icon: Icon(tab.icon),
                label: tab.label(context),
              ),
          ],
        ),
      ],
    );
  }
}
