import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  testWidgets('loaded state shows tabs search count and rows', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries));
    await _pumpBookmarks(tester);

    expect(find.byKey(const ValueKey('bookmarks-tabbar')), findsOneWidget);
    expect(find.byKey(const ValueKey('bookmarks-search-box')), findsOneWidget);
    expect(find.text('2件'), findsOneWidget);
    expect(find.text('Amlodipine'), findsOneWidget);
    expect(find.text('高血圧症'), findsOneWidget);
    expect(find.text('保存 2026/05/10'), findsOneWidget);
  });

  testWidgets('empty stream shows empty UI with search CTA', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: const []));
    await _pumpBookmarks(tester);

    expect(find.text('0件'), findsOneWidget);
    expect(find.text('ブックマークがありません'), findsOneWidget);
    expect(
      find.text('医薬品・疾患の詳細画面でブックマークを追加すると、ここに一覧表示されます。'),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('bookmarks-empty-cta')), findsOneWidget);
    expect(
      tester
          .getSize(
            find.descendant(
              of: find.byKey(const ValueKey('bookmarks-empty-art')),
              matching: find.byType(CustomPaint),
            ),
          )
          .shortestSide,
      56,
    );
  });

  testWidgets('loading state shows five skeleton rows and unknown count', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(stream: const Stream.empty()));
    await tester.pump();

    expect(find.text('-'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('bookmarks-skeleton-row')),
      findsNWidgets(5),
    );
    expect(find.text('読み込み中'), findsNothing);
  });

  testWidgets('search box filters rows case-insensitively', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries));
    await _pumpBookmarks(tester);

    await tester.enterText(
      find.byKey(const ValueKey('bookmarks-search-box')),
      'AMLO',
    );
    await tester.pump();

    expect(find.text('1件'), findsOneWidget);
    expect(find.text('Amlodipine'), findsOneWidget);
    expect(find.text('高血圧症'), findsNothing);
  });

  testWidgets('search miss shows search zero UI', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries));
    await _pumpBookmarks(tester);

    await tester.enterText(
      find.byKey(const ValueKey('bookmarks-search-box')),
      'マッチしないキーワード',
    );
    await tester.pump();

    expect(find.text('0件'), findsOneWidget);
    expect(find.text('一致するブックマークがありません'), findsOneWidget);
    expect(
      find.text('キーワードを短くするか、タブを「すべて」に戻してください。'),
      findsOneWidget,
    );
    expect(find.text('Amlodipine'), findsNothing);
    expect(find.text('高血圧症'), findsNothing);
    expect(
      tester
          .getSize(
            find.descendant(
              of: find.byKey(const ValueKey('bookmarks-empty-art')),
              matching: find.byType(CustomPaint),
            ),
          )
          .shortestSide,
      56,
    );
  });

  testWidgets('pane rail tabs and separator extend to both horizontal edges', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1024, 768));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries));
    await _pumpBookmarks(tester);

    final dividerRect = tester.getRect(find.byType(VerticalDivider));
    final searchPanelRect = tester.getRect(
      find.byKey(const ValueKey('bookmarks-search-panel')),
    );
    final selectedTabRect = tester.getRect(
      find.ancestor(of: find.text('すべて'), matching: find.byType(InkWell)).first,
    );

    expect(searchPanelRect.left, 0);
    expect(searchPanelRect.right, moreOrLessEquals(dividerRect.left));
    expect(selectedTabRect.left, 0);
    expect(selectedTabRect.right, moreOrLessEquals(dividerRect.left));
  });

  testWidgets('error state keeps chrome and retries the stream', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    var streamBuilds = 0;

    await tester.pumpWidget(
      _App(
        streamFactory: () {
          streamBuilds += 1;
          return streamBuilds == 1
              ? Stream<List<BookmarkEntry>>.value(_brokenBookmarkEntries)
              : Stream<List<BookmarkEntry>>.value(_bookmarkEntries);
        },
      ),
    );
    await _pumpBookmarks(tester);

    expect(find.byKey(const ValueKey('bookmarks-tabbar')), findsOneWidget);
    expect(find.byKey(const ValueKey('bookmarks-search-box')), findsOneWidget);
    expect(find.text('2件'), findsOneWidget);
    expect(find.text('ブックマークを読み込めません'), findsOneWidget);
    expect(
      find.text('端末内の保存データを読み取れませんでした。時間をおいて再度お試しください。'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('bookmarks-error-retry')));
    await _pumpBookmarks(tester);

    expect(streamBuilds, 2);
    expect(find.text('Amlodipine'), findsOneWidget);
  });

  testWidgets('row taps navigate to detail routes', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_App(entries: _bookmarkEntries, useRouter: true));
    await _pumpBookmarks(tester);

    await tester.tap(find.text('Amlodipine'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('drug detail: drug_001'), findsOneWidget);

    await tester.pumpWidget(_App(entries: _bookmarkEntries, useRouter: true));
    await _pumpBookmarks(tester);
    await tester.tap(find.text('高血圧症'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('disease detail: disease_001'), findsOneWidget);
  });

  testWidgets(
    'does not scroll rows to top from the primary scroll controller',
    (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_App(entries: _manyBookmarkEntries()));
      await _pumpBookmarks(tester);

      final listFinder = find.byType(ListView).last;
      final scrollableFinder = find.descendant(
        of: listFinder,
        matching: find.byType(Scrollable),
      );
      await tester.drag(listFinder, const Offset(0, -900));
      await tester.pumpAndSettle();

      final beforePrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(beforePrimaryScrollToTop, greaterThan(0));

      final primaryController = PrimaryScrollController.maybeOf(
        tester.element(listFinder),
      );
      if (primaryController != null && primaryController.hasClients) {
        primaryController.jumpTo(0);
        await tester.pump();
      }

      final afterPrimaryScrollToTop = tester
          .state<ScrollableState>(scrollableFinder)
          .position
          .pixels;
      expect(afterPrimaryScrollToTop, closeTo(beforePrimaryScrollToTop, 1));
    },
  );

  group('delete reveal regression', () {
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

    testWidgets(
      'keeps other revealed delete actions visible after deleting one row',
      (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(const Size(390, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        for (final entry in _bookmarkEntries) {
          await _seedBookmark(db, entry);
        }

        await tester.pumpWidget(_App(entries: _bookmarkEntries, db: db));
        await _pumpBookmarks(tester);

        await tester.drag(
          find.byKey(ValueKey('bookmarks-row-${_drugSummary.id}')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();
        await tester.drag(
          find.byKey(ValueKey('bookmarks-row-${_diseaseSummary.id}')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();

        expect(_bookmarksRevealWidthAt(tester, _drugSummary.id), 72);
        expect(_bookmarksRevealWidthAt(tester, _diseaseSummary.id), 72);

        await tester.tap(
          find.byKey(
            ValueKey('bookmarks-row-swipe-action-${_drugSummary.id}'),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(ValueKey('bookmarks-row-${_drugSummary.id}')),
          findsNothing,
        );
        expect(
          find.byKey(ValueKey('bookmarks-row-${_diseaseSummary.id}')),
          findsOneWidget,
        );
        expect(_bookmarksRevealWidthAt(tester, _diseaseSummary.id), 72);
      },
    );
  });
}

Future<void> _pumpBookmarks(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
}

class _App extends StatelessWidget {
  _App({
    List<BookmarkEntry>? entries,
    Stream<List<BookmarkEntry>>? stream,
    Stream<List<BookmarkEntry>> Function()? streamFactory,
    this.db,
    this.useRouter = false,
  }) : streamFactory =
           streamFactory ??
           (() => stream ?? Stream.value(entries ?? _bookmarkEntries)),
       cacheManager = _fallbackImageCacheManager();

  final Stream<List<BookmarkEntry>> Function() streamFactory;
  final AppDatabase? db;
  final bool useRouter;
  final BaseCacheManager cacheManager;

  @override
  Widget build(BuildContext context) {
    final child = useRouter
        ? MaterialApp.router(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: GoRouter(
              initialLocation: AppRoutes.bookmarks,
              routes: [
                GoRoute(
                  path: AppRoutes.bookmarks,
                  builder: (context, state) => const BookmarksView(),
                ),
                GoRoute(
                  path: AppRoutes.drugDetail(':id'),
                  builder: (context, state) => Scaffold(
                    body: Text('drug detail: ${state.pathParameters['id']}'),
                  ),
                ),
                GoRoute(
                  path: AppRoutes.diseaseDetail(':id'),
                  builder: (context, state) => Scaffold(
                    body: Text('disease detail: ${state.pathParameters['id']}'),
                  ),
                ),
              ],
            ),
          )
        : MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const BookmarksView(),
          );

    return ProviderScope(
      overrides: [
        if (db != null) appDatabaseProvider.overrideWithValue(db!),
        bookmarksStreamProvider.overrideWith((ref) => streamFactory()),
        drugCardImageCacheManagerProvider.overrideWithValue(cacheManager),
      ],
      child: child,
    );
  }
}

_MockBaseCacheManager _fallbackImageCacheManager() {
  final cacheManager = _MockBaseCacheManager();
  when(
    () => cacheManager.getSingleFile(
      any(),
      key: any(named: 'key'),
      headers: any(named: 'headers'),
    ),
  ).thenThrow(StateError('bookmarks tests render the fallback image'));
  return cacheManager;
}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

Future<void> _seedBookmark(AppDatabase db, BookmarkEntry entry) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: entry.id,
    snapshotJson: entry.snapshotJson,
    bookmarkedAt: entry.bookmarkedAt,
  );
}

double _bookmarksRevealWidthAt(WidgetTester tester, String id) {
  return tester
      .getSize(find.byKey(ValueKey('bookmarks-row-swipe-reveal-$id')))
      .width;
}

List<BookmarkEntry> _manyBookmarkEntries() {
  return List<BookmarkEntry>.generate(24, (index) {
    final summary = _drugSummaryFor(index);
    return BookmarkEntry(
      id: summary.id,
      snapshotJson: const DrugBookmarkSnapshotCodec().encode(summary),
      bookmarkedAt: DateTime.utc(2026, 5, 10).subtract(
        Duration(minutes: index),
      ),
    );
  });
}

DrugSummary _drugSummaryFor(int index) {
  return DrugSummary(
    id: 'drug_scroll_$index',
    brandName: 'Amlodipine $index',
    genericName: 'amlodipine besilate',
    therapeuticCategoryName: 'Ca拮抗薬',
    regulatoryClass: const ['prescription_required'],
    dosageForm: 'tablet',
    brandNameKana: 'アムロジピン',
    atcCode: 'C08CA01',
    revisedAt: '2026-01-01',
    imageUrl: '/v1/images/drugs/drug_scroll_$index',
  );
}

final _bookmarkEntries = [
  BookmarkEntry(
    id: _drugSummary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(_drugSummary),
    bookmarkedAt: DateTime.utc(2026, 5, 10),
  ),
  BookmarkEntry(
    id: _diseaseSummary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(_diseaseSummary),
    bookmarkedAt: DateTime.utc(2026, 5, 9),
  ),
];

final List<BookmarkEntry> _brokenBookmarkEntries = [
  BookmarkEntry(
    id: 'drug_broken',
    snapshotJson: '{"id":"drug_broken"}',
    bookmarkedAt: DateTime.utc(2026, 5, 10),
  ),
  _bookmarkEntries.last,
];

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'Amlodipine',
  genericName: 'amlodipine besilate',
  therapeuticCategoryName: 'Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジピン',
  atcCode: 'C08CA01',
  revisedAt: '2026-01-01',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '高血圧症',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'コウケツアツショウ',
  revisedAt: '2026-01-01',
);
