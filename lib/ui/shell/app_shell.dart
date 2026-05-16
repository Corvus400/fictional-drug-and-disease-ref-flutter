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
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, _) {
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
          if (!shellUsesNavigationRail) {
            return AppShellNavigationScope(child: navigationShell);
          }
          return Row(
            children: [
              navigation,
              Expanded(child: AppShellNavigationScope(child: navigationShell)),
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

/// Marks a subtree as already wrapped by the top-level app shell navigation.
class AppShellNavigationScope extends InheritedWidget {
  /// Creates an app-shell navigation marker.
  const AppShellNavigationScope({required super.child, super.key});

  /// Returns whether the current subtree is inside [AppShell].
  static bool isInShell(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<AppShellNavigationScope>() !=
        null;
  }

  @override
  bool updateShouldNotify(AppShellNavigationScope oldWidget) => false;
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
              left: false,
              right: false,
              bottom: false,
              child: railWidth < 56
                  ? _CompactAppShellRail(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: onDestinationSelected,
                    )
                  : NavigationRail(
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

class _CompactAppShellRail extends StatelessWidget {
  const _CompactAppShellRail({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey('app-shell-compact-navigation-rail'),
      children: [
        const SizedBox(height: 8),
        for (final (index, tab) in AppShellTab.values.indexed)
          Tooltip(
            message: tab.label(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                width: 48,
                height: 36,
                child: Material(
                  color: index == selectedIndex
                      ? colorScheme.primaryContainer
                      : Colors.transparent,
                  shape: const StadiumBorder(),
                  child: InkWell(
                    customBorder: const StadiumBorder(),
                    onTap: () => onDestinationSelected(index),
                    child: Icon(
                      tab.icon,
                      size: 24,
                      color: index == selectedIndex
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
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
