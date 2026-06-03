import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('does not throw duplicate GlobalKey errors while cycling tabs', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = _buildHeaderOnlyShellRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final tabExceptions = <String, Object?>{};
    for (final tab in [
      AppShellTab.bookmarks,
      AppShellTab.history,
      AppShellTab.calc,
      AppShellTab.search,
      AppShellTab.bookmarks,
      AppShellTab.history,
      AppShellTab.calc,
      AppShellTab.search,
    ]) {
      await tester.tap(
        find.byKey(ValueKey<String>('app-shell-tab-${tab.name}')).last,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      final exception = tester.takeException();
      if (exception != null) {
        tabExceptions[tab.name] = exception;
      }
    }

    expect(
      tabExceptions,
      isEmpty,
      reason:
          'Cycling shell tabs should not duplicate about-button GlobalKeys.',
    );
  });

  testWidgets('keeps the about button visible while cycling shell tabs', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final router = _buildHeaderOnlyShellRouter();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final missingAboutTabs = <AppShellTab>[];
    for (final tab in [
      AppShellTab.bookmarks,
      AppShellTab.history,
      AppShellTab.calc,
      AppShellTab.search,
      AppShellTab.bookmarks,
      AppShellTab.history,
      AppShellTab.calc,
      AppShellTab.search,
    ]) {
      await tester.tap(
        find.byKey(ValueKey<String>('app-shell-tab-${tab.name}')).last,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      tester.takeException();

      final visibleAboutCount = find
          .byKey(
            const ValueKey<String>('app-tab-header-about-button'),
          )
          .hitTestable()
          .evaluate()
          .length;
      if (visibleAboutCount != 1) {
        missingAboutTabs.add(tab);
      }
    }

    expect(
      missingAboutTabs,
      isEmpty,
      reason: 'Each active shell tab should keep one visible about button.',
    );
  });
}

GoRouter _buildHeaderOnlyShellRouter() {
  return GoRouter(
    initialLocation: AppRoutes.search,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          _branch(AppRoutes.search, AppShellTab.search),
          _branch(AppRoutes.bookmarks, AppShellTab.bookmarks),
          _branch(AppRoutes.history, AppShellTab.history),
          _branch(AppRoutes.calc, AppShellTab.calc),
        ],
      ),
    ],
  );
}

StatefulShellBranch _branch(String path, AppShellTab tab) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        builder: (context, state) => _HeaderOnlyShellTab(tab: tab),
      ),
    ],
  );
}

class _HeaderOnlyShellTab extends StatelessWidget {
  const _HeaderOnlyShellTab({required this.tab});

  final AppShellTab tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTabHeader(
        tab: tab,
        includeOnboardingTargetKey: tab == AppShellTab.search,
      ),
      body: const SizedBox.expand(),
    );
  }
}
