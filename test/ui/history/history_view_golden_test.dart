import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/bulk_delete_confirm_dialog.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../golden/golden_test_helpers.dart';
import '../../helpers/test_app_database.dart';

late AppDatabase _db;

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
    _db = createTestAppDatabase();
  });

  setUp(() async {
    await _seedNormalRows(_db);
  });

  tearDown(() async {
    await clearTestAppDatabase(_db);
  });

  tearDownAll(() async {
    await _db.close();
  });

  runHistoryGoldenMatrix(
    fileNamePrefix: 'history_empty',
    description: 'History empty state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugCardImageCacheManagerProvider.overrideWithValue(
            _fallbackImageCacheManager(),
          ),
          browsingHistoryStreamProvider.overrideWith(
            (ref) => Stream<List<BrowsingHistoryEntry>>.value(const []),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: const HistoryView(),
            bottomNavigationBar: AppShellBottomNavigation(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
    },
    whilePerforming: (tester) async {
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });
      return null;
    },
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'history_loading',
    description: 'History loading state',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugCardImageCacheManagerProvider.overrideWithValue(
            _fallbackImageCacheManager(),
          ),
          browsingHistoryStreamProvider.overrideWith(
            (ref) => const Stream<List<BrowsingHistoryEntry>>.empty(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: const HistoryView(),
            bottomNavigationBar: AppShellBottomNavigation(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
    },
    whilePerforming: (tester) async {
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });
      return null;
    },
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'history_normal',
    description: 'History normal rows',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      final now = _normalNow;
      final drugViewedAt = now.subtract(const Duration(minutes: 5));
      final diseaseViewedAt = now.subtract(const Duration(hours: 2));
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugCardImageCacheManagerProvider.overrideWithValue(
            _fallbackImageCacheManager(),
          ),
          browsingHistoryStreamProvider.overrideWith(
            (ref) => Stream<List<BrowsingHistoryEntry>>.value([
              BrowsingHistoryEntry(id: _drugSummary.id, viewedAt: drugViewedAt),
              BrowsingHistoryEntry(
                id: _diseaseSummary.id,
                viewedAt: diseaseViewedAt,
              ),
            ]),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HistoryView(currentTime: now),
            bottomNavigationBar: AppShellBottomNavigation(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
    },
    whilePerforming: (tester) async {
      for (var i = 0; i < 5; i += 1) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });
      return null;
    },
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'history_swipe_delete',
    description: 'History swipe delete reveal',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      final now = _normalNow;
      final drugViewedAt = now.subtract(const Duration(minutes: 5));
      final diseaseViewedAt = now.subtract(const Duration(hours: 2));
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugCardImageCacheManagerProvider.overrideWithValue(
            _fallbackImageCacheManager(),
          ),
          browsingHistoryStreamProvider.overrideWith(
            (ref) => Stream<List<BrowsingHistoryEntry>>.value([
              BrowsingHistoryEntry(id: _drugSummary.id, viewedAt: drugViewedAt),
              BrowsingHistoryEntry(
                id: _diseaseSummary.id,
                viewedAt: diseaseViewedAt,
              ),
            ]),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: HistoryView(
              currentTime: now,
              debugSwipeRevealRowId: _diseaseSummary.id,
            ),
            bottomNavigationBar: AppShellBottomNavigation(
              selectedIndex: 2,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
    },
    whilePerforming: (tester) async {
      for (var i = 0; i < 5; i += 1) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });
      return null;
    },
  );

  runHistoryGoldenMatrix(
    fileNamePrefix: 'history_bulk_delete_confirm',
    description: 'History bulk delete confirm',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      final now = _normalNow;
      final drugViewedAt = now.subtract(const Duration(minutes: 5));
      final diseaseViewedAt = now.subtract(const Duration(hours: 2));
      return ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(_db),
          drugCardImageCacheManagerProvider.overrideWithValue(
            _fallbackImageCacheManager(),
          ),
          browsingHistoryStreamProvider.overrideWith(
            (ref) => Stream<List<BrowsingHistoryEntry>>.value([
              BrowsingHistoryEntry(id: _drugSummary.id, viewedAt: drugViewedAt),
              BrowsingHistoryEntry(
                id: _diseaseSummary.id,
                viewedAt: diseaseViewedAt,
              ),
            ]),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              final palette = theme.extension<AppPalette>()!;
              return Scaffold(
                body: Stack(
                  children: [
                    HistoryView(currentTime: now),
                    Positioned.fill(child: ColoredBox(color: palette.scrim)),
                    const Center(
                      child: BulkDeleteConfirmDialogCard(count: 2),
                    ),
                  ],
                ),
                bottomNavigationBar: AppShellBottomNavigation(
                  selectedIndex: 2,
                  onDestinationSelected: (_) {},
                ),
              );
            },
          ),
        ),
      );
    },
    whilePerforming: (tester) async {
      for (var i = 0; i < 5; i += 1) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });
      return null;
    },
  );
}

Future<void> _seedNormalRows(AppDatabase db) async {
  final now = _normalNow;
  await _seedDrug(
    db,
    _drugSummary,
    now.subtract(const Duration(minutes: 5)),
  );
  await _seedDisease(
    db,
    _diseaseSummary,
    now.subtract(const Duration(hours: 2)),
  );
}

Future<void> _seedDrug(
  AppDatabase db,
  DrugSummary summary,
  DateTime viewedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: DateTime(2026, 5, 12),
  );
  await BrowsingHistoryRepository(
    db.browsingHistoriesDao,
  ).upsert(summary.id, viewedAt: viewedAt);
}

Future<void> _seedDisease(
  AppDatabase db,
  DiseaseSummary summary,
  DateTime viewedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: DateTime(2026, 5, 12),
  );
  await BrowsingHistoryRepository(
    db.browsingHistoriesDao,
  ).upsert(summary.id, viewedAt: viewedAt);
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('history goldens render the fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

final _normalNow = DateTime(2026, 5, 12, 12);

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'アムロジン錠5mg',
  genericName: 'アムロジピンベシル酸塩',
  therapeuticCategoryName: '持続性Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジンジョウ',
  atcCode: 'C08CA01',
  revisedAt: '2026-05-10',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '本態性高血圧症',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'ホンタイセイコウケツアツショウ',
  revisedAt: '2026-05-10',
);
