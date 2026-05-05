import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/theme_settings_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/theme_settings_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App database provider.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Bookmarks DAO provider.
final bookmarksDaoProvider = Provider<BookmarksDao>(
  (ref) => ref.watch(appDatabaseProvider).bookmarksDao,
);

/// Browsing histories DAO provider.
final browsingHistoriesDaoProvider = Provider<BrowsingHistoriesDao>(
  (ref) => ref.watch(appDatabaseProvider).browsingHistoriesDao,
);

/// Search histories DAO provider.
final searchHistoriesDaoProvider = Provider<SearchHistoriesDao>(
  (ref) => ref.watch(appDatabaseProvider).searchHistoriesDao,
);

/// Calculation histories DAO provider.
final calculationHistoriesDaoProvider = Provider<CalculationHistoriesDao>(
  (ref) => ref.watch(appDatabaseProvider).calculationHistoriesDao,
);

/// Theme settings service provider.
final themeSettingsServiceProvider = Provider<ThemeSettingsService>(
  (ref) => ThemeSettingsService(SharedPreferences.getInstance()),
);

/// Bookmark repository provider.
final bookmarkRepositoryProvider = Provider<BookmarkRepository>(
  (ref) => BookmarkRepository(ref.watch(bookmarksDaoProvider)),
);

/// Browsing history repository provider.
final browsingHistoryRepositoryProvider = Provider<BrowsingHistoryRepository>(
  (ref) => BrowsingHistoryRepository(ref.watch(browsingHistoriesDaoProvider)),
);

/// Search history repository provider.
final searchHistoryRepositoryProvider = Provider<SearchHistoryRepository>(
  (ref) => SearchHistoryRepository(ref.watch(searchHistoriesDaoProvider)),
);

/// Calculation history repository provider.
final calculationHistoryRepositoryProvider =
    Provider<CalculationHistoryRepository>(
      (ref) => CalculationHistoryRepository(
        ref.watch(calculationHistoriesDaoProvider),
      ),
    );

/// Theme settings repository provider.
final themeSettingsRepositoryProvider = Provider<ThemeSettingsRepository>(
  (ref) => ThemeSettingsRepository(ref.watch(themeSettingsServiceProvider)),
);

/// Current theme-mode setting provider.
final themeModeSettingProvider = FutureProvider<ThemeModeSetting>((ref) async {
  final result = await ref.watch(themeSettingsRepositoryProvider).read();
  return switch (result) {
    Ok<ThemeModeSetting>(:final value) => value,
    Err<ThemeModeSetting>() => ThemeModeSetting.system,
  };
});
