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
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/history_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
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

    testWidgets('renders the app bar title as a leading 17dp bold heading', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(2048, 2732);
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

      final appBarTitle = find.descendant(
        of: find.byType(AppBar),
        matching: find.text('閲覧履歴'),
      );
      final titleText = tester.widget<Text>(appBarTitle);
      final titleRect = tester.getRect(appBarTitle);

      expect(appBarTitle, findsOneWidget);
      expect(titleText.textAlign, TextAlign.left);
      expect(titleText.style?.fontSize, 17);
      expect(titleText.style?.fontWeight, FontWeight.w700);
      expect(titleRect.left, moreOrLessEquals(16));
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
      expect(
        find.byKey(const ValueKey('history-bulk-delete-fab')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('history-bulk-delete-count-badge')),
        findsOneWidget,
      );
      final fabRect = tester.getRect(
        find.byKey(const ValueKey('history-bulk-delete-fab')),
      );
      final badgeRect = tester.getRect(
        find.byKey(const ValueKey('history-bulk-delete-count-badge')),
      );
      expect(badgeRect.height, 20);
      expect(badgeRect.width, greaterThanOrEqualTo(20));
      expect(badgeRect.top, moreOrLessEquals(fabRect.top - 2));
      expect(badgeRect.right, moreOrLessEquals(fabRect.right + 2));

      await tester.tap(find.byKey(const ValueKey('history-bulk-delete-fab')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('history-bulk-delete-confirm-dialog')),
        findsOneWidget,
      );
      expect(
        find.text('すべての閲覧履歴 (2件) を削除しますか？'),
        findsOneWidget,
      );
      expect(find.text('この操作は取り消せません'), findsOneWidget);
      expect(find.text('キャンセル'), findsOneWidget);
      expect(find.text('すべて削除'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('history-bulk-delete-confirm-cancel')),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('history-bulk-delete-confirm-dialog')),
        findsNothing,
      );

      await tester.tap(find.byKey(const ValueKey('history-bulk-delete-fab')));
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey('history-bulk-delete-confirm-delete')),
      );
      await tester.pumpAndSettle();

      expect(find.text('閲覧履歴がありません'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('history-bulk-delete-fab')),
        findsNothing,
      );
    });

    testWidgets('renders swipe delete reveal as a 72dp destructive action', (
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
          debugSwipeRevealRowId: _diseaseSummary.id,
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

      expect(find.byType(Dismissible), findsNothing);
      expect(find.text('削除'), findsWidgets);

      final actionFinder = find.byKey(
        ValueKey('history-row-swipe-action-${_diseaseSummary.id}'),
      );
      final actionRect = tester.getRect(actionFinder);
      final rowRect = tester.getRect(
        find.byKey(ValueKey('disease-card-${_diseaseSummary.id}')),
      );
      final actionBox = tester.widget<DecoratedBox>(actionFinder);
      final decoration = actionBox.decoration as BoxDecoration;
      final rowCard = tester.widget<Card>(
        find.byKey(ValueKey('disease-card-${_diseaseSummary.id}')),
      );
      final rowShape = rowCard.shape! as RoundedRectangleBorder;
      final actionClip = tester.widget<ClipRRect>(
        find.byKey(
          ValueKey('history-row-swipe-action-clip-${_diseaseSummary.id}'),
        ),
      );
      final actionMaterial = tester.widget<Material>(
        find.byKey(
          ValueKey('history-row-swipe-action-material-${_diseaseSummary.id}'),
        ),
      );

      expect(actionRect.width, 72);
      expect(rowRect.right, moreOrLessEquals(actionRect.left));
      expect(actionRect.top, moreOrLessEquals(rowRect.top + 8));
      expect(actionRect.height, moreOrLessEquals(rowRect.height - 8));
      expect(actionClip.clipBehavior, Clip.antiAlias);
      expect(
        actionClip.borderRadius,
        const BorderRadius.only(
          topRight: Radius.circular(SearchConstants.searchCardRadius),
          bottomRight: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(actionMaterial.clipBehavior, Clip.antiAlias);
      expect(
        actionMaterial.borderRadius,
        const BorderRadius.only(
          topRight: Radius.circular(SearchConstants.searchCardRadius),
          bottomRight: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(
        rowShape.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(SearchConstants.searchCardRadius),
          bottomLeft: Radius.circular(SearchConstants.searchCardRadius),
        ),
      );
      expect(decoration.color, const Color(0xFFD62A2A));
    });

    testWidgets('disables row tap while swipe delete is revealed', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 2;
      tester.view.physicalSize = const Size(780, 1688);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final now = DateTime(2026, 5, 12, 12);
      final diseaseViewedAt = now.subtract(const Duration(hours: 2));
      await _seedDisease(db, _diseaseSummary, diseaseViewedAt);

      await tester.pumpWidget(
        _App(
          db: db,
          historyStream: Stream.value([
            BrowsingHistoryEntry(
              id: _diseaseSummary.id,
              viewedAt: diseaseViewedAt,
            ),
          ]),
          currentTime: now,
          debugSwipeRevealRowId: _diseaseSummary.id,
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

      await tester.tap(
        find.byKey(ValueKey('disease-card-${_diseaseSummary.id}')),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('reveals delete action by dragging like calculation history', (
      tester,
    ) async {
      String? deletedId;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 320,
                child: SwipeDeleteHistoryRow(
                  row: HistoryDiseaseRow(
                    id: _diseaseSummary.id,
                    viewedAt: DateTime(2026, 5, 12, 10),
                    summary: _diseaseSummary,
                  ),
                  now: DateTime(2026, 5, 12, 12),
                  drugImageCacheManager: _fallbackImageCacheManager(),
                  onDelete: (id) async {
                    deletedId = id;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Dismissible), findsNothing);
      expect(
        tester
            .getSize(
              find.byKey(
                ValueKey('history-row-swipe-reveal-${_diseaseSummary.id}'),
              ),
            )
            .width,
        0,
      );

      await tester.drag(
        find.byType(SwipeDeleteHistoryRow),
        const Offset(-140, 0),
      );
      await tester.pumpAndSettle();

      final actionFinder = find.byKey(
        ValueKey('history-row-swipe-action-${_diseaseSummary.id}'),
      );
      expect(tester.getSize(actionFinder).width, 72);
      expect(
        tester
            .getSize(
              find.byKey(
                ValueKey('history-row-swipe-reveal-${_diseaseSummary.id}'),
              ),
            )
            .width,
        72,
      );

      await tester.tap(actionFinder);
      await tester.pump();

      expect(deletedId, _diseaseSummary.id);
    });

    testWidgets(
      'keeps other revealed delete actions visible after deleting one row',
      (
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

        await tester.drag(
          find.byKey(ValueKey('history-row-${_drugSummary.id}')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();
        await tester.drag(
          find.byKey(ValueKey('history-row-${_diseaseSummary.id}')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();

        expect(_historyRevealWidthAt(tester, _drugSummary.id), 72);
        expect(_historyRevealWidthAt(tester, _diseaseSummary.id), 72);

        await tester.tap(
          find.byKey(ValueKey('history-row-swipe-action-${_drugSummary.id}')),
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(ValueKey('history-row-${_drugSummary.id}')),
          findsNothing,
        );
        expect(
          find.byKey(ValueKey('history-row-${_diseaseSummary.id}')),
          findsOneWidget,
        );
        expect(_historyRevealWidthAt(tester, _diseaseSummary.id), 72);
      },
    );

    testWidgets('renders unresolved rows with a screen-level retry FAB', (
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
      final diseaseViewedAt = now.subtract(const Duration(minutes: 17));

      await tester.pumpWidget(
        _App(
          db: db,
          historyStream: Stream.value([
            BrowsingHistoryEntry(id: 'drug_0080', viewedAt: drugViewedAt),
            BrowsingHistoryEntry(
              id: 'disease_0080',
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

      expect(find.text('名前取得失敗'), findsNWidgets(2));
      expect(find.text('5分前'), findsOneWidget);
      expect(find.text('17分前'), findsOneWidget);
      expect(find.text(_drugSummary.brandName), findsNothing);
      expect(find.text(_diseaseSummary.name), findsNothing);
      expect(
        find.byKey(const ValueKey('history-row-retry-button')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey('history-bulk-delete-fab')),
        findsOneWidget,
      );

      final retryFab = find.byKey(const ValueKey('history-retry-fab'));
      expect(retryFab, findsOneWidget);
      expect(find.byTooltip('閲覧履歴の名前を再取得'), findsOneWidget);

      final retryRect = tester.getRect(retryFab);
      final bulkRect = tester.getRect(
        find.byKey(const ValueKey('history-bulk-delete-fab')),
      );
      final retryButton = tester.widget<FloatingActionButton>(retryFab);
      final retryShape = retryButton.shape! as RoundedRectangleBorder;

      expect(retryRect.size, const Size(56, 56));
      expect(retryRect.left, 16);
      expect(retryRect.bottom, moreOrLessEquals(bulkRect.bottom));
      expect(
        retryShape.borderRadius,
        BorderRadius.circular(18),
      );
      expect(
        retryButton.backgroundColor,
        AppTheme.light().extension<AppPalette>()!.filterFabBg,
      );
      expect(
        retryButton.foregroundColor,
        AppTheme.light().extension<AppPalette>()!.filterFabFg,
      );
    });
  });
}

class _App extends StatelessWidget {
  _App({
    required this.db,
    required this.historyStream,
    this.currentTime,
    this.debugSwipeRevealRowId,
  }) : cacheManager = _fallbackImageCacheManager();

  final AppDatabase? db;
  final Stream<List<BrowsingHistoryEntry>> historyStream;
  final DateTime? currentTime;
  final String? debugSwipeRevealRowId;
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
        home: HistoryView(
          currentTime: currentTime,
          debugSwipeRevealRowId: debugSwipeRevealRowId,
        ),
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

double _historyRevealWidthAt(WidgetTester tester, String id) {
  return tester
      .getSize(find.byKey(ValueKey('history-row-swipe-reveal-$id')))
      .width;
}

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
