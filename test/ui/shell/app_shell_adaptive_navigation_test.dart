import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  testWidgets('landscape shell uses icon-only rail for all tabs', (
    tester,
  ) async {
    final selected = <int>[];

    await tester.binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Row(
            children: [
              AppShellAdaptiveNavigation(
                selectedIndex: AppShellTab.search.index,
                onDestinationSelected: selected.add,
              ),
              const Expanded(child: Placeholder()),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(AppShellBottomNavigation), findsNothing);
    expect(find.byType(NavigationRail), findsNothing);
    expect(
      find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
      findsOneWidget,
    );
    expect(find.byType(DisclaimerRibbon), findsNothing);

    final railBox = tester.getRect(
      find.byKey(const ValueKey('app-shell-navigation-rail-box')),
    );
    expect(railBox.width, 52);

    for (final tab in AppShellTab.values.indexed) {
      expect(
        find.byTooltip(
          tab.$2.label(
            tester.element(
              find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
            ),
          ),
        ),
        findsOneWidget,
      );
      expect(find.byIcon(tab.$2.icon), findsOneWidget);
    }

    await tester.tap(find.byTooltip('ブックマーク'));
    expect(selected, [AppShellTab.bookmarks.index]);
  });

  testWidgets('portrait shell keeps bottom navigation and disclaimer order', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppShellAdaptiveNavigation(
          selectedIndex: AppShellTab.history.index,
          onDestinationSelected: (_) {},
        ),
      ),
    );

    expect(find.byType(AppShellBottomNavigation), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(DisclaimerRibbon), findsOneWidget);
  });

  testWidgets('compact landscape rail keeps icons inside iPhone safe area', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(844, 390),
            padding: EdgeInsets.only(left: 47, right: 47),
          ),
          child: Scaffold(
            body: AppShellAdaptiveNavigation(
              selectedIndex: AppShellTab.search.index,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      ),
    );

    final railBox = tester.getRect(
      find.byKey(const ValueKey('app-shell-navigation-rail-box')),
    );
    final searchIcon = tester.getRect(find.byIcon(Icons.search));

    expect(railBox.left, 0);
    expect(railBox.width, 52);
    expect(searchIcon.left, greaterThanOrEqualTo(railBox.left));
    expect(searchIcon.right, lessThanOrEqualTo(railBox.right));
  });

  testWidgets('iPad landscape shell uses 72px icon-only rail', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1194, 834));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: AppShellAdaptiveNavigation(
            selectedIndex: AppShellTab.search.index,
            onDestinationSelected: (_) {},
          ),
        ),
      ),
    );

    final railBox = tester.getRect(
      find.byKey(const ValueKey('app-shell-navigation-rail-box')),
    );
    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));

    expect(railBox.width, 72);
    expect(rail.minWidth, 72);
    expect(rail.labelType, NavigationRailLabelType.none);
  });

  for (final tab in AppShellTab.values) {
    testWidgets('landscape shell marks ${tab.name} as active', (tester) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: AppShellAdaptiveNavigation(
              selectedIndex: tab.index,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(
        find.byKey(const ValueKey('app-shell-compact-navigation-rail')),
        findsOneWidget,
      );
      final selectedIconMaterial = tester.widget<Material>(
        find
            .ancestor(
              of: find.byIcon(tab.icon),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(
        selectedIconMaterial.color,
        AppTheme.light().colorScheme.primaryContainer,
      );
      expect(find.byType(NavigationBar), findsNothing);
    });
  }
}
