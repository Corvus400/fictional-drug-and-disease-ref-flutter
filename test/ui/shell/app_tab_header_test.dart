import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/about_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('uses the same localized labels as the bottom navigation', (
    tester,
  ) async {
    final selectedTabs = <String>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            appBar: const AppTabHeader(tab: AppShellTab.history),
            bottomNavigationBar: AppShellBottomNavigation(
              selectedIndex: AppShellTab.history.index,
              onDestinationSelected: (index) {
                selectedTabs.add(AppShellTab.values[index].label(context));
              },
            ),
          ),
        ),
      ),
    );

    for (final tab in AppShellTab.values) {
      expect(
        find.text(tab.label(tester.element(find.byType(Scaffold)))),
        findsWidgets,
      );
    }

    await tester.tap(find.text('計算ツール').last);
    expect(selectedTabs, ['計算ツール']);
  });

  testWidgets('renders AA-compliant light and dark title colors', (
    tester,
  ) async {
    for (final themeMode in [ThemeMode.light, ThemeMode.dark]) {
      final theme = switch (themeMode) {
        ThemeMode.light => AppTheme.light(),
        ThemeMode.dark => AppTheme.dark(),
        ThemeMode.system => throw StateError('system mode is not tested here'),
      };
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Theme(
            data: theme,
            child: const Scaffold(
              appBar: AppTabHeader(tab: AppShellTab.search),
            ),
          ),
        ),
      );
      await tester.pump();

      final palette = theme.extension<AppPalette>()!;
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      final title = tester.widget<Text>(
        find.byKey(const ValueKey<String>('app-tab-header-title')),
      );

      expect(appBar.backgroundColor, palette.surface);
      expect(title.style?.color, palette.ink);
      expect(
        _contrastRatio(palette.ink, palette.surface),
        greaterThanOrEqualTo(4.5),
      );
    }
  });

  testWidgets('keeps the 200 percent title visible without clipping', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(2),
          ),
          child: child!,
        ),
        home: const Scaffold(
          appBar: AppTabHeader(tab: AppShellTab.bookmarks),
        ),
      ),
    );

    expect(tester.takeException(), isNull);

    final titleRect = tester.getRect(
      find.byKey(const ValueKey<String>('app-tab-header-title')),
    );
    final appBarRect = tester.getRect(find.byType(AppBar));

    expect(titleRect.top, greaterThanOrEqualTo(appBarRect.top));
    expect(titleRect.bottom, lessThanOrEqualTo(appBarRect.bottom));
  });

  testWidgets('uses the common bold title typography', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          appBar: AppTabHeader(tab: AppShellTab.calc),
        ),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    final title = tester.widget<Text>(
      find.byKey(const ValueKey<String>('app-tab-header-title')),
    );

    expect(appBar.automaticallyImplyLeading, isFalse);
    expect(appBar.centerTitle, isFalse);
    expect(appBar.titleSpacing, 16);
    expect(title.textAlign, TextAlign.left);
    expect(title.maxLines, 1);
    expect(title.style?.fontSize, 20);
    expect(title.style?.fontWeight, FontWeight.w700);
    expect(title.style?.fontVariations, const [FontVariation('wght', 700)]);
  });

  testWidgets('renders info icon after custom actions', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          appBar: AppTabHeader(
            tab: AppShellTab.search,
            actions: [
              IconButton(
                key: ValueKey<String>('custom-action'),
                icon: Icon(Icons.refresh),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.info_outline), findsOneWidget);
    expect(find.byTooltip('アプリについて'), findsOneWidget);

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.actions, hasLength(2));
    expect(appBar.actions!.first.key, const ValueKey<String>('custom-action'));
    expect(
      appBar.actions!.last,
      isA<IconButton>().having(
        (button) => (button.icon as Icon).icon,
        'icon',
        Icons.info_outline,
      ),
    );
  });

  testWidgets('pushes /about when the info icon is tapped', (tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.search,
      routes: [
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => const Scaffold(
            appBar: AppTabHeader(tab: AppShellTab.search),
          ),
        ),
        GoRoute(
          path: AppRoutes.about,
          builder: (context, state) => const AboutView(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          packageInfoProvider.overrideWith(
            (ref) async => const AppPackageInfo(
              version: '1.0.0',
              buildNumber: '1',
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();

    expect(find.byType(AboutView), findsOneWidget);
    expect(find.text('アプリについて'), findsOneWidget);
  });
}

double _contrastRatio(Color foreground, Color background) {
  final foregroundLuminance = foreground.computeLuminance();
  final backgroundLuminance = background.computeLuminance();
  final lighter = foregroundLuminance > backgroundLuminance
      ? foregroundLuminance
      : backgroundLuminance;
  final darker = foregroundLuminance > backgroundLuminance
      ? backgroundLuminance
      : foregroundLuminance;
  return (lighter + 0.05) / (darker + 0.05);
}
