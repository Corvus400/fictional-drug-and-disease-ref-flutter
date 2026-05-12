import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  ApiConfig.initialize(
    const FlavorConfig(
      flavor: Flavor.dev,
      apiBaseUrl: 'https://api.example.test',
    ),
  );

  group('HistoryView empty state', () {
    late AppDatabase db;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    testWidgets('renders the design-specified empty state', (tester) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        _App(db: db, historyStream: Stream.value(const [])),
      );
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });

      expect(find.text('閲覧履歴'), findsWidgets);
      expect(find.text('すべて'), findsOneWidget);
      expect(find.text('医薬品'), findsOneWidget);
      expect(find.text('疾患'), findsOneWidget);
      expect(find.text('閲覧履歴がありません'), findsOneWidget);
      expect(
        find.text('検索して薬品・疾患を閲覧すると、ここに履歴が表示されます'),
        findsOneWidget,
      );
      expect(find.text('検索画面へ'), findsOneWidget);

      final artRect = tester.getRect(
        find.byKey(const ValueKey('history-empty-art')),
      );
      expect(artRect.size, const Size(120, 120));
      final ctaRect = tester.getRect(
        find.byKey(const ValueKey('history-empty-cta')),
      );
      expect(ctaRect.height, greaterThanOrEqualTo(44));
      final tabBarRect = tester.getRect(
        find.byKey(const ValueKey('history-tabbar')),
      );
      expect(tabBarRect.height, greaterThanOrEqualTo(44));
      expect(find.text('閲覧履歴画面（プレースホルダー）'), findsNothing);
    });

    testWidgets('renders five loading skeleton rows', (tester) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        _App(
          db: null,
          historyStream: const Stream<List<BrowsingHistoryEntry>>.empty(),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });

      final rows = find.byKey(const ValueKey('history-loading-skeleton-row'));
      expect(rows, findsNWidgets(5));
      expect(find.text('閲覧履歴がありません'), findsNothing);
      expect(find.text('検索画面へ'), findsNothing);

      for (final element in rows.evaluate()) {
        final rect = tester.getRect(find.byWidget(element.widget));
        expect(rect.height, 80);
      }
    });

    testWidgets('renders resolved drug and disease history rows', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final now = DateTime(2026, 5, 12, 12);
      final drugViewedAt = now.subtract(const Duration(minutes: 5));
      final diseaseViewedAt = now.subtract(const Duration(hours: 2));
      await _seedDrug(db, _drugSummary, drugViewedAt);
      await _seedDisease(db, _diseaseSummary, diseaseViewedAt);

      await tester.pumpWidget(
        _App(
          db: db,
          historyStream: Stream.value([
            BrowsingHistoryEntry(id: _drugSummary.id, viewedAt: drugViewedAt),
            BrowsingHistoryEntry(
              id: _diseaseSummary.id,
              viewedAt: diseaseViewedAt,
            ),
          ]),
          currentTime: now,
        ),
      );
      for (var i = 0; i < 5; i += 1) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      addTearDown(() async {
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 1));
      });

      expect(find.text(_drugSummary.brandName), findsOneWidget);
      expect(find.text(_drugSummary.genericName), findsOneWidget);
      expect(find.text(_diseaseSummary.name), findsOneWidget);
      expect(find.text(_diseaseSummary.nameKana), findsOneWidget);
      expect(find.text('5分前'), findsOneWidget);
      expect(find.text('2時間前'), findsOneWidget);
      expect(
        find.byKey(ValueKey('history-row-time-${_drugSummary.id}')),
        findsOneWidget,
      );
      expect(
        find.byKey(ValueKey('history-row-time-${_diseaseSummary.id}')),
        findsOneWidget,
      );
      expect(find.text('閲覧履歴がありません'), findsNothing);
      expect(
        find.byKey(const ValueKey('history-loading-skeleton-row')),
        findsNothing,
      );
    });
  });
}

class _App extends StatelessWidget {
  _App({
    required this.db,
    required this.historyStream,
    this.currentTime,
  }) : cacheManager = _fallbackImageCacheManager();

  final AppDatabase? db;
  final Stream<List<BrowsingHistoryEntry>> historyStream;
  final DateTime? currentTime;
  final BaseCacheManager cacheManager;
  final DrugApiClient drugApiClient = _MockDrugApiClient();
  final DiseaseApiClient diseaseApiClient = _MockDiseaseApiClient();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        if (db != null) appDatabaseProvider.overrideWithValue(db!),
        drugApiClientProvider.overrideWithValue(drugApiClient),
        diseaseApiClientProvider.overrideWithValue(diseaseApiClient),
        browsingHistoryStreamProvider.overrideWith(
          (ref) => historyStream,
        ),
        drugCardImageCacheManagerProvider.overrideWithValue(cacheManager),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HistoryView(currentTime: currentTime),
      ),
    );
  }
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
  ).thenThrow(StateError('history tests render the fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

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
