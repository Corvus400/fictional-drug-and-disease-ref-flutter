import 'dart:async';

import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/about_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/licenses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders app metadata and navigates to licenses', (tester) async {
    final router = buildRouter()..go(AppRoutes.about);

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

    expect(find.byType(AboutView), findsOneWidget);
    expect(find.text('アプリについて'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('バージョン 1.0.0'), findsOneWidget);
    expect(find.text('オープンソースライセンス'), findsOneWidget);
    expect(find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget);

    final versionTile = tester.widget<ListTile>(
      find.widgetWithText(ListTile, 'バージョン 1.0.0'),
    );
    expect(versionTile.onTap, isNull);

    await tester.tap(find.text('オープンソースライセンス'));
    await tester.pumpAndSettle();

    expect(find.byType(LicensesView), findsOneWidget);
  });

  testWidgets('shows loading fallback before package info resolves', (
    tester,
  ) async {
    final packageInfoCompleter = Completer<AppPackageInfo>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          packageInfoProvider.overrideWith(
            (ref) => packageInfoCompleter.future,
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AboutView(),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('バージョン --'), findsOneWidget);

    packageInfoCompleter.complete(
      const AppPackageInfo(version: '1.0.0', buildNumber: '1'),
    );
  });
}
