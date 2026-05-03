import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/theme_settings_repository.dart';
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

  test('appDatabaseProvider disposes on container dispose', () async {
    final container = ProviderContainer();

    final db = container.read(appDatabaseProvider);
    expect(db, isA<AppDatabase>());
    await db.customSelect('select 1').get();

    container.dispose();

    await expectLater(
      db.customSelect('select 1').get(),
      throwsA(anything),
    );
  });

  test('DAO and local repository providers return typed instances', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(bookmarksDaoProvider), isA<BookmarksDao>());
    expect(
      container.read(browsingHistoriesDaoProvider),
      isA<BrowsingHistoriesDao>(),
    );
    expect(
      container.read(searchHistoriesDaoProvider),
      isA<SearchHistoriesDao>(),
    );
    expect(
      container.read(calculationHistoriesDaoProvider),
      isA<CalculationHistoriesDao>(),
    );
    expect(
      container.read(bookmarkRepositoryProvider),
      isA<BookmarkRepository>(),
    );
    expect(
      container.read(browsingHistoryRepositoryProvider),
      isA<BrowsingHistoryRepository>(),
    );
    expect(
      container.read(searchHistoryRepositoryProvider),
      isA<SearchHistoryRepository>(),
    );
    expect(
      container.read(calculationHistoryRepositoryProvider),
      isA<CalculationHistoryRepository>(),
    );
    expect(
      container.read(themeSettingsRepositoryProvider),
      isA<ThemeSettingsRepository>(),
    );
  });
}
