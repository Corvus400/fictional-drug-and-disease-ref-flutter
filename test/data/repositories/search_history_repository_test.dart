import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/search_history/search_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchHistoryRepository', () {
    late AppDatabase db;
    late SearchHistoryRepository repository;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = SearchHistoryRepository(db.searchHistoriesDao);
    });

    tearDown(() async {
      await db.close();
    });

    test('insertWithDedup creates row', () async {
      final searchedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.insertWithDedup(
        id: 'search_001',
        target: 'drug',
        queryJson: '{"keyword":"a"}',
        searchedAt: searchedAt,
        totalCount: 10,
      );

      final result = await repository.findByTarget('drug');

      expect(result, isA<Ok<List<SearchHistoryEntry>>>());
      final entries = (result as Ok<List<SearchHistoryEntry>>).value;
      expect(entries.single.id, 'search_001');
      expect(entries.single.queryJson, '{"keyword":"a"}');
      expect(entries.single.searchedAt, searchedAt);
      expect(entries.single.totalCount, 10);
    });

    test('same target and query replaces old row', () async {
      await repository.insertWithDedup(
        id: 'search_001',
        target: 'drug',
        queryJson: '{"keyword":"a"}',
        searchedAt: DateTime.utc(2026, 5, 4),
        totalCount: 10,
      );

      await repository.insertWithDedup(
        id: 'search_002',
        target: 'drug',
        queryJson: '{"keyword":"a"}',
        searchedAt: DateTime.utc(2026, 5, 5),
        totalCount: 20,
      );

      final result = await repository.findByTarget('drug');

      final entries = (result as Ok<List<SearchHistoryEntry>>).value;
      expect(entries, hasLength(1));
      expect(entries.single.id, 'search_002');
      expect(entries.single.totalCount, 20);
    });

    test(
      'different query remains and findByTarget orders and limits',
      () async {
        await _insertSearch(
          repository,
          'search_001',
          'drug',
          '{"keyword":"a"}',
        );
        await _insertSearch(
          repository,
          'search_002',
          'drug',
          '{"keyword":"b"}',
        );
        await _insertSearch(
          repository,
          'search_003',
          'disease',
          '{"keyword":"c"}',
        );

        final result = await repository.findByTarget('drug', limit: 1);

        final entries = (result as Ok<List<SearchHistoryEntry>>).value;
        expect(entries.map((entry) => entry.id), ['search_002']);
      },
    );

    test('invalid target returns check constraint error', () async {
      final result = await repository.insertWithDedup(
        id: 'search_001',
        target: 'unknown',
        queryJson: '{}',
        searchedAt: DateTime.utc(2026, 5, 4),
        totalCount: 0,
      );

      expect(result, isA<Err<void>>());
      final error = (result as Err<void>).error;
      expect(error, isA<StorageException>());
      expect(
        (error as StorageException).kind,
        StorageErrorKind.checkConstraint,
      );
    });

    test('deleteById removes row', () async {
      await _insertSearch(repository, 'search_001', 'drug', '{"keyword":"a"}');

      await repository.deleteById('search_001');

      final result = await repository.findByTarget('drug');
      expect((result as Ok<List<SearchHistoryEntry>>).value, isEmpty);
    });
  });
}

Future<void> _insertSearch(
  SearchHistoryRepository repository,
  String id,
  String target,
  String queryJson,
) async {
  final day = int.parse(id.split('_').last);
  await repository.insertWithDedup(
    id: id,
    target: target,
    queryJson: queryJson,
    searchedAt: DateTime.utc(2026, 5, day),
    totalCount: day,
  );
}
