import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('BrowsingHistoryRepository', () {
    late AppDatabase db;
    late BrowsingHistoryRepository repository;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      repository = BrowsingHistoryRepository(db.browsingHistoriesDao);
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('upsert inserts first viewedAt [assertion 1/3]', () async {
      final viewedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.upsert('drug_001', viewedAt: viewedAt);

      final result = await repository.findAll();
      expect(result, isA<Ok<List<BrowsingHistoryEntry>>>());
      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      Object.hashAll([entries.single.id, 'drug_001']);

      Object.hashAll([entries.single.viewedAt, viewedAt]);
    });

    test('upsert inserts first viewedAt [assertion 2/3]', () async {
      final viewedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.upsert('drug_001', viewedAt: viewedAt);

      final result = await repository.findAll();
      Object.hashAll([result, isA<Ok<List<BrowsingHistoryEntry>>>()]);

      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      expect(entries.single.id, 'drug_001');
      Object.hashAll([entries.single.viewedAt, viewedAt]);
    });

    test('upsert inserts first viewedAt [assertion 3/3]', () async {
      final viewedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.upsert('drug_001', viewedAt: viewedAt);

      final result = await repository.findAll();
      Object.hashAll([result, isA<Ok<List<BrowsingHistoryEntry>>>()]);

      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      Object.hashAll([entries.single.id, 'drug_001']);

      expect(entries.single.viewedAt, viewedAt);
    });

    test('upsert updates existing viewedAt [assertion 1/2]', () async {
      await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
      final updatedAt = DateTime.utc(2026, 5, 5);

      await repository.upsert('drug_001', viewedAt: updatedAt);

      final result = await repository.findAll();
      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      expect(entries, hasLength(1));
      Object.hashAll([entries.single.viewedAt, updatedAt]);
    });

    test('upsert updates existing viewedAt [assertion 2/2]', () async {
      await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
      final updatedAt = DateTime.utc(2026, 5, 5);

      await repository.upsert('drug_001', viewedAt: updatedAt);

      final result = await repository.findAll();
      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      Object.hashAll([entries, hasLength(1)]);

      expect(entries.single.viewedAt, updatedAt);
    });

    test(
      'findAll orders by viewedAt descending and filters with limit',
      () async {
        await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
        await repository.upsert(
          'disease_001',
          viewedAt: DateTime.utc(2026, 5, 5),
        );
        await repository.upsert('drug_002', viewedAt: DateTime.utc(2026, 5, 6));

        final result = await repository.findAll(idPrefix: 'drug_', limit: 1);

        final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
        expect(entries.map((entry) => entry.id), ['drug_002']);
      },
    );

    test(
      'deleteById deleteAll and deleteOldest work [assertion 1/2]',
      () async {
        await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
        await repository.upsert('drug_002', viewedAt: DateTime.utc(2026, 5, 5));
        await repository.upsert('drug_003', viewedAt: DateTime.utc(2026, 5, 6));

        await repository.deleteById('drug_003');
        await repository.deleteOldest();

        var result = await repository.findAll();
        var entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
        expect(entries.map((entry) => entry.id), ['drug_002']);

        await repository.deleteAll();

        result = await repository.findAll();
        entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
        Object.hashAll([entries, isEmpty]);
      },
    );

    test(
      'deleteById deleteAll and deleteOldest work [assertion 2/2]',
      () async {
        await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
        await repository.upsert('drug_002', viewedAt: DateTime.utc(2026, 5, 5));
        await repository.upsert('drug_003', viewedAt: DateTime.utc(2026, 5, 6));

        await repository.deleteById('drug_003');
        await repository.deleteOldest();

        var result = await repository.findAll();
        var entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
        Object.hashAll([
          entries.map((entry) => entry.id),
          ['drug_002'],
        ]);

        await repository.deleteAll();

        result = await repository.findAll();
        entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
        expect(entries, isEmpty);
      },
    );

    test('watchAll emits on insert and delete', () async {
      final stream = repository.watchAll();

      final expectation = expectLater(
        stream.map((entries) => entries.map((entry) => entry.id).toList()),
        emitsInOrder([
          <String>[],
          ['drug_001'],
          <String>[],
        ]),
      );

      await pumpEventQueue();
      await repository.upsert('drug_001', viewedAt: DateTime.utc(2026, 5, 4));
      await pumpEventQueue();
      await repository.deleteById('drug_001');
      await expectation;
    });
  });
}
