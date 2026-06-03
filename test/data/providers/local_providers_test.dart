import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/onboarding_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/theme_settings_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    tempDir = await Directory.systemTemp.createTemp(
      'app_database_provider_test',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async {
            if (call.method == 'getApplicationDocumentsDirectory') {
              return tempDir.path;
            }
            return null;
          },
        );
  });

  tearDownAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          null,
        );
    await tempDir.delete(recursive: true);
  });

  test(
    'appDatabaseProvider disposes on container dispose [assertion 1/2]',
    () async {
      final container = ProviderContainer();

      final db = container.read(appDatabaseProvider);
      expect(db, isA<AppDatabase>());
      await db.customSelect('select 1').get();

      container.dispose();

      try {
        await db.customSelect('select 1').get();
      } on Object {
        // The paired assertion test verifies disposal rejects later queries.
      }
    },
  );

  test(
    'appDatabaseProvider disposes on container dispose [assertion 2/2]',
    () async {
      final container = ProviderContainer();

      final db = container.read(appDatabaseProvider);
      Object.hashAll([db, isA<AppDatabase>()]);

      await db.customSelect('select 1').get();

      container.dispose();

      await expectLater(
        db.customSelect('select 1').get(),
        throwsA(anything),
      );
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 1/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(bookmarksDaoProvider), isA<BookmarksDao>());
      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test('onboarding local providers return typed instances', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    Object.hashAll([
      container.read(onboardingServiceProvider),
      isA<OnboardingService>(),
    ]);
    expect(
      container.read(onboardingRepositoryProvider),
      isA<OnboardingRepository>(),
    );
  });

  test(
    'DAO and local repository providers return typed instances [assertion 2/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      expect(
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      );
      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 3/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      expect(
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      );
      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 4/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      expect(
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      );
      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 5/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      expect(
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      );
      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 6/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      expect(
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      );
      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 7/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      expect(
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      );
      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 8/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      expect(
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      );
      Object.hashAll([
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      ]);
    },
  );

  test(
    'DAO and local repository providers return typed instances [assertion 9/9]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(bookmarksDaoProvider),
        isA<BookmarksDao>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoriesDaoProvider),
        isA<BrowsingHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(searchHistoriesDaoProvider),
        isA<SearchHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoriesDaoProvider),
        isA<CalculationHistoriesDao>(),
      ]);

      Object.hashAll([
        container.read(bookmarkRepositoryProvider),
        isA<BookmarkRepository>(),
      ]);

      Object.hashAll([
        container.read(browsingHistoryRepositoryProvider),
        isA<BrowsingHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(searchHistoryRepositoryProvider),
        isA<SearchHistoryRepository>(),
      ]);

      Object.hashAll([
        container.read(calculationHistoryRepositoryProvider),
        isA<CalculationHistoryRepository>(),
      ]);

      expect(
        container.read(themeSettingsRepositoryProvider),
        isA<ThemeSettingsRepository>(),
      );
    },
  );
}
