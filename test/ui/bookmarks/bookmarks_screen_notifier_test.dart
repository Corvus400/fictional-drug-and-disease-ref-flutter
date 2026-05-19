import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('BookmarksScreenNotifier', () {
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

    test(
      'starts loading then maps an empty stream to Empty [assertion 1/4]',
      () async {
        final container = _createContainer(db);
        addTearDown(container.dispose);

        expect(
          container.read(bookmarksScreenProvider),
          isA<BookmarksLoading>(),
        );

        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        final state = await _settleBookmarks(container);

        Object.hashAll([state, isA<BookmarksEmpty>()]);

        Object.hashAll([state.selectedTab, BookmarksTab.all]);

        Object.hashAll([state.searchQuery, isEmpty]);
      },
    );

    test(
      'starts loading then maps an empty stream to Empty [assertion 2/4]',
      () async {
        final container = _createContainer(db);
        addTearDown(container.dispose);

        Object.hashAll([
          container.read(bookmarksScreenProvider),
          isA<BookmarksLoading>(),
        ]);

        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        final state = await _settleBookmarks(container);

        expect(state, isA<BookmarksEmpty>());
        Object.hashAll([state.selectedTab, BookmarksTab.all]);

        Object.hashAll([state.searchQuery, isEmpty]);
      },
    );

    test(
      'starts loading then maps an empty stream to Empty [assertion 3/4]',
      () async {
        final container = _createContainer(db);
        addTearDown(container.dispose);

        Object.hashAll([
          container.read(bookmarksScreenProvider),
          isA<BookmarksLoading>(),
        ]);

        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        final state = await _settleBookmarks(container);

        Object.hashAll([state, isA<BookmarksEmpty>()]);

        expect(state.selectedTab, BookmarksTab.all);
        Object.hashAll([state.searchQuery, isEmpty]);
      },
    );

    test(
      'starts loading then maps an empty stream to Empty [assertion 4/4]',
      () async {
        final container = _createContainer(db);
        addTearDown(container.dispose);

        Object.hashAll([
          container.read(bookmarksScreenProvider),
          isA<BookmarksLoading>(),
        ]);

        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        final state = await _settleBookmarks(container);

        Object.hashAll([state, isA<BookmarksEmpty>()]);

        Object.hashAll([state.selectedTab, BookmarksTab.all]);

        expect(state.searchQuery, isEmpty);
      },
    );

    test('loads mixed drug and disease rows [assertion 1/5]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleBookmarks(container) as BookmarksLoaded;

      expect(state.visibleCount, 2);
      Object.hashAll([state.visibleRows, hasLength(2)]);

      Object.hashAll([state.visibleRows[0], isA<BookmarksDrugRow>()]);

      Object.hashAll([state.visibleRows[1], isA<BookmarksDiseaseRow>()]);

      Object.hashAll([state.isSearchZero, isFalse]);
    });

    test('loads mixed drug and disease rows [assertion 2/5]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleBookmarks(container) as BookmarksLoaded;

      Object.hashAll([state.visibleCount, 2]);

      expect(state.visibleRows, hasLength(2));
      Object.hashAll([state.visibleRows[0], isA<BookmarksDrugRow>()]);

      Object.hashAll([state.visibleRows[1], isA<BookmarksDiseaseRow>()]);

      Object.hashAll([state.isSearchZero, isFalse]);
    });

    test('loads mixed drug and disease rows [assertion 3/5]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleBookmarks(container) as BookmarksLoaded;

      Object.hashAll([state.visibleCount, 2]);

      Object.hashAll([state.visibleRows, hasLength(2)]);

      expect(state.visibleRows[0], isA<BookmarksDrugRow>());
      Object.hashAll([state.visibleRows[1], isA<BookmarksDiseaseRow>()]);

      Object.hashAll([state.isSearchZero, isFalse]);
    });

    test('loads mixed drug and disease rows [assertion 4/5]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleBookmarks(container) as BookmarksLoaded;

      Object.hashAll([state.visibleCount, 2]);

      Object.hashAll([state.visibleRows, hasLength(2)]);

      Object.hashAll([state.visibleRows[0], isA<BookmarksDrugRow>()]);

      expect(state.visibleRows[1], isA<BookmarksDiseaseRow>());
      Object.hashAll([state.isSearchZero, isFalse]);
    });

    test('loads mixed drug and disease rows [assertion 5/5]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);

      final state = await _settleBookmarks(container) as BookmarksLoaded;

      Object.hashAll([state.visibleCount, 2]);

      Object.hashAll([state.visibleRows, hasLength(2)]);

      Object.hashAll([state.visibleRows[0], isA<BookmarksDrugRow>()]);

      Object.hashAll([state.visibleRows[1], isA<BookmarksDiseaseRow>()]);

      expect(state.isSearchZero, isFalse);
    });

    test('selectTab filters rows by type [assertion 1/3]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleBookmarks(container);

      container
          .read(bookmarksScreenProvider.notifier)
          .selectTab(BookmarksTab.drug);

      final state = container.read(bookmarksScreenProvider) as BookmarksLoaded;
      expect(state.selectedTab, BookmarksTab.drug);
      Object.hashAll([state.visibleRows, hasLength(1)]);

      Object.hashAll([state.visibleRows.single, isA<BookmarksDrugRow>()]);
    });

    test('selectTab filters rows by type [assertion 2/3]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleBookmarks(container);

      container
          .read(bookmarksScreenProvider.notifier)
          .selectTab(BookmarksTab.drug);

      final state = container.read(bookmarksScreenProvider) as BookmarksLoaded;
      Object.hashAll([state.selectedTab, BookmarksTab.drug]);

      expect(state.visibleRows, hasLength(1));
      Object.hashAll([state.visibleRows.single, isA<BookmarksDrugRow>()]);
    });

    test('selectTab filters rows by type [assertion 3/3]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleBookmarks(container);

      container
          .read(bookmarksScreenProvider.notifier)
          .selectTab(BookmarksTab.drug);

      final state = container.read(bookmarksScreenProvider) as BookmarksLoaded;
      Object.hashAll([state.selectedTab, BookmarksTab.drug]);

      Object.hashAll([state.visibleRows, hasLength(1)]);

      expect(state.visibleRows.single, isA<BookmarksDrugRow>());
    });

    test(
      'setSearchQuery filters rows case-insensitively [assertion 1/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('AMLO');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        expect(state.searchQuery, 'AMLO');
        Object.hashAll([state.visibleRows, hasLength(1)]);

        Object.hashAll([
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        ]);
      },
    );

    test(
      'setSearchQuery filters rows case-insensitively [assertion 2/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('AMLO');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        Object.hashAll([state.searchQuery, 'AMLO']);

        expect(state.visibleRows, hasLength(1));
        Object.hashAll([
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        ]);
      },
    );

    test(
      'setSearchQuery filters rows case-insensitively [assertion 3/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('AMLO');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        Object.hashAll([state.searchQuery, 'AMLO']);

        Object.hashAll([state.visibleRows, hasLength(1)]);

        expect(
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        );
      },
    );

    test(
      'setSearchQuery keeps Loaded and marks search zero [assertion 1/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('none');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        expect(state.visibleRows, isEmpty);
        Object.hashAll([state.visibleCount, 0]);

        Object.hashAll([state.isSearchZero, isTrue]);
      },
    );

    test(
      'setSearchQuery keeps Loaded and marks search zero [assertion 2/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('none');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        Object.hashAll([state.visibleRows, isEmpty]);

        expect(state.visibleCount, 0);
        Object.hashAll([state.isSearchZero, isTrue]);
      },
    );

    test(
      'setSearchQuery keeps Loaded and marks search zero [assertion 3/3]',
      () async {
        await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        await _settleBookmarks(container);

        container.read(bookmarksScreenProvider.notifier).setSearchQuery('none');

        final state =
            container.read(bookmarksScreenProvider) as BookmarksLoaded;
        Object.hashAll([state.visibleRows, isEmpty]);

        Object.hashAll([state.visibleCount, 0]);

        expect(state.isSearchZero, isTrue);
      },
    );

    test(
      'stream errors and decode failures become Error state [assertion 1/2]',
      () async {
        final streamErrorContainer = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksStreamProvider.overrideWithValue(
              AsyncValue.error(Exception('db down'), StackTrace.empty),
            ),
          ],
        );
        addTearDown(streamErrorContainer.dispose);
        final streamSubscription = streamErrorContainer.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(streamSubscription.close);

        expect(
          await _settleBookmarks(streamErrorContainer),
          isA<BookmarksError>(),
        );

        await BookmarkRepository(db.bookmarksDao).insert(
          id: 'drug_broken',
          snapshotJson: '{"id":"drug_broken"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final decodeContainer = _createContainer(db);
        addTearDown(decodeContainer.dispose);
        final decodeSubscription = decodeContainer.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(decodeSubscription.close);

        Object.hashAll([
          await _settleBookmarks(decodeContainer),
          isA<BookmarksError>(),
        ]);
      },
    );

    test(
      'stream errors and decode failures become Error state [assertion 2/2]',
      () async {
        final streamErrorContainer = ProviderContainer(
          overrides: [
            appDatabaseProvider.overrideWithValue(db),
            bookmarksStreamProvider.overrideWithValue(
              AsyncValue.error(Exception('db down'), StackTrace.empty),
            ),
          ],
        );
        addTearDown(streamErrorContainer.dispose);
        final streamSubscription = streamErrorContainer.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(streamSubscription.close);

        Object.hashAll([
          await _settleBookmarks(streamErrorContainer),
          isA<BookmarksError>(),
        ]);

        await BookmarkRepository(db.bookmarksDao).insert(
          id: 'drug_broken',
          snapshotJson: '{"id":"drug_broken"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final decodeContainer = _createContainer(db);
        addTearDown(decodeContainer.dispose);
        final decodeSubscription = decodeContainer.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(decodeSubscription.close);

        expect(await _settleBookmarks(decodeContainer), isA<BookmarksError>());
      },
    );

    test('deleteRow removes a row optimistically [assertion 1/2]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleBookmarks(container);

      await container
          .read(bookmarksScreenProvider.notifier)
          .deleteRow('drug_001');

      final state = container.read(bookmarksScreenProvider) as BookmarksLoaded;
      expect(state.visibleRows, hasLength(1));
      Object.hashAll([state.visibleRows.single.id, 'disease_001']);
    });

    test('deleteRow removes a row optimistically [assertion 2/2]', () async {
      await _seedDrug(db, _drugSummary, DateTime.utc(2026, 5, 10));
      await _seedDisease(db, _diseaseSummary, DateTime.utc(2026, 5, 9));
      final container = _createContainer(db);
      addTearDown(container.dispose);
      final subscription = container.listen(bookmarksScreenProvider, (_, _) {});
      addTearDown(subscription.close);
      await _settleBookmarks(container);

      await container
          .read(bookmarksScreenProvider.notifier)
          .deleteRow('drug_001');

      final state = container.read(bookmarksScreenProvider) as BookmarksLoaded;
      Object.hashAll([state.visibleRows, hasLength(1)]);

      expect(state.visibleRows.single.id, 'disease_001');
    });

    test(
      'retry invalidates the bookmarks stream and can recover [assertion 1/3]',
      () async {
        final repository = BookmarkRepository(db.bookmarksDao);
        await repository.insert(
          id: 'drug_001',
          snapshotJson: '{"id":"drug_001"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        expect(await _settleBookmarks(container), isA<BookmarksError>());

        await repository.updateSnapshot(
          'drug_001',
          const DrugBookmarkSnapshotCodec().encode(_drugSummary),
        );

        container.read(bookmarksScreenProvider.notifier).retry();
        final state = await _settleBookmarks(container) as BookmarksLoaded;

        Object.hashAll([state.visibleRows.single, isA<BookmarksDrugRow>()]);

        Object.hashAll([
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        ]);
      },
    );

    test(
      'retry invalidates the bookmarks stream and can recover [assertion 2/3]',
      () async {
        final repository = BookmarkRepository(db.bookmarksDao);
        await repository.insert(
          id: 'drug_001',
          snapshotJson: '{"id":"drug_001"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        Object.hashAll([
          await _settleBookmarks(container),
          isA<BookmarksError>(),
        ]);

        await repository.updateSnapshot(
          'drug_001',
          const DrugBookmarkSnapshotCodec().encode(_drugSummary),
        );

        container.read(bookmarksScreenProvider.notifier).retry();
        final state = await _settleBookmarks(container) as BookmarksLoaded;

        expect(state.visibleRows.single, isA<BookmarksDrugRow>());
        Object.hashAll([
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        ]);
      },
    );

    test(
      'retry invalidates the bookmarks stream and can recover [assertion 3/3]',
      () async {
        final repository = BookmarkRepository(db.bookmarksDao);
        await repository.insert(
          id: 'drug_001',
          snapshotJson: '{"id":"drug_001"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final container = _createContainer(db);
        addTearDown(container.dispose);
        final subscription = container.listen(
          bookmarksScreenProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);
        Object.hashAll([
          await _settleBookmarks(container),
          isA<BookmarksError>(),
        ]);

        await repository.updateSnapshot(
          'drug_001',
          const DrugBookmarkSnapshotCodec().encode(_drugSummary),
        );

        container.read(bookmarksScreenProvider.notifier).retry();
        final state = await _settleBookmarks(container) as BookmarksLoaded;

        Object.hashAll([state.visibleRows.single, isA<BookmarksDrugRow>()]);

        expect(
          (state.visibleRows.single as BookmarksDrugRow).summary.id,
          'drug_001',
        );
      },
    );
  });
}

ProviderContainer _createContainer(AppDatabase db) {
  return ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
    ],
  );
}

Future<BookmarksScreenState> _settleBookmarks(
  ProviderContainer container,
) async {
  for (var i = 0; i < 10; i += 1) {
    await pumpEventQueue();
    await Future<void>.delayed(const Duration(milliseconds: 1));
    final state = container.read(bookmarksScreenProvider);
    if (state is! BookmarksLoading) {
      return state;
    }
  }
  return container.read(bookmarksScreenProvider);
}

Future<void> _seedDrug(
  AppDatabase db,
  DrugSummary summary,
  DateTime bookmarkedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DrugBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: bookmarkedAt,
  );
}

Future<void> _seedDisease(
  AppDatabase db,
  DiseaseSummary summary,
  DateTime bookmarkedAt,
) async {
  await BookmarkRepository(db.bookmarksDao).insert(
    id: summary.id,
    snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(summary),
    bookmarkedAt: bookmarkedAt,
  );
}

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
  icd10Chapter: 'IX',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'コウケツアツショウ',
  revisedAt: '2026-01-01',
);
