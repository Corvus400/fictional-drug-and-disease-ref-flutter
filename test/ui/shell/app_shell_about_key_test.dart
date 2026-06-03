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

      expect(
        tester.takeException(),
        isNull,
        reason: '${tab.name} should not trigger a duplicate GlobalKey error.',
      );
      expect(
        find
            .byKey(
              const ValueKey<String>('app-tab-header-about-button'),
            )
            .hitTestable(),
        findsOneWidget,
        reason: '${tab.name} should keep its visible about button mounted.',
      );
    }
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
