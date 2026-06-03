import 'dart:async';

import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/onboarding_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/about_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/licenses_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'renders app metadata and navigates to licenses [assertion 1/8]',
    (tester) async {
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
      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 2/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      expect(find.text('アプリについて'), findsOneWidget);
      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 3/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      expect(find.byType(ListTile), findsNWidgets(3));
      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 4/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      expect(find.text('バージョン 1.0.0'), findsOneWidget);
      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 5/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      expect(find.text('オープンソースライセンス'), findsOneWidget);
      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 6/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      expect(find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 7/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      expect(versionTile.onTap, isNull);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      Object.hashAll([find.byType(LicensesView), findsOneWidget]);
    },
  );

  testWidgets(
    'renders app metadata and navigates to licenses [assertion 8/8]',
    (tester) async {
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

      Object.hashAll([find.byType(AboutView), findsOneWidget]);

      Object.hashAll([find.text('アプリについて'), findsOneWidget]);

      Object.hashAll([find.byType(ListTile), findsNWidgets(3)]);

      Object.hashAll([find.text('バージョン 1.0.0'), findsOneWidget]);

      Object.hashAll([find.text('オープンソースライセンス'), findsOneWidget]);

      Object.hashAll([find.text('使用しているオープンソースライブラリの一覧'), findsOneWidget]);

      final versionTile = tester.widget<ListTile>(
        find.widgetWithText(ListTile, 'バージョン 1.0.0'),
      );
      Object.hashAll([versionTile.onTap, isNull]);

      await tester.tap(find.text('オープンソースライセンス'));
      await tester.pumpAndSettle();

      expect(find.byType(LicensesView), findsOneWidget);
    },
  );

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

  testWidgets('replays onboarding from the About tutorial tile', (
    tester,
  ) async {
    final router = buildRouter()..go(AppRoutes.about);
    final onboardingService = _FakeOnboardingService(completed: true);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          packageInfoProvider.overrideWith(
            (ref) async =>
                const AppPackageInfo(version: '1.0.0', buildNumber: '1'),
          ),
          onboardingRepositoryProvider.overrideWith(
            (ref) => OnboardingRepository(onboardingService),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          builder: (context, child) => OnboardingGate(child: child!),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const ValueKey<String>('about-onboarding-tile')),
    );
    await tester.pumpAndSettle();

    Object.hashAll([find.byType(OnboardingCarouselView), findsOneWidget]);
    expect(
      find.byKey(const ValueKey<String>('onboarding-page-1')),
      findsOneWidget,
    );
  });
}

final class _FakeOnboardingService extends OnboardingService {
  _FakeOnboardingService({required bool completed})
    : _completed = completed,
      super(SharedPreferences.getInstance());

  bool _completed;

  @override
  Future<Result<bool>> read() async => Result.ok(_completed);

  @override
  Future<Result<void>> write({required bool completed}) async {
    _completed = completed;
    return const Result.ok(null);
  }
}
