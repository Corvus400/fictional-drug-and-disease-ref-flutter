import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('BookmarkRepository', () {
    late AppDatabase db;
    late BookmarkRepository repository;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      repository = BookmarkRepository(db.bookmarksDao);
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('insert then findById returns entry', () async {
      final bookmarkedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: bookmarkedAt,
      );

      final result = await repository.findById('drug_001');

      expect(result, isA<Ok<BookmarkEntry?>>());
      final entry = (result as Ok<BookmarkEntry?>).value;
      expect(entry, isNotNull);
      expect(entry?.id, 'drug_001');
      expect(entry?.snapshotJson, '{"id":"drug_001"}');
      expect(entry?.bookmarkedAt, bookmarkedAt);
    });

    test('duplicate insert returns unique constraint error', () async {
      final bookmarkedAt = DateTime.utc(2026, 5, 4, 12);
      await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: bookmarkedAt,
      );

      final result = await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: bookmarkedAt,
      );

      expect(result, isA<Err<void>>());
      final error = (result as Err<void>).error;
      expect(error, isA<StorageException>());
      expect(
        (error as StorageException).kind,
        StorageErrorKind.uniqueConstraint,
      );
    });

    test('updateSnapshot updates only snapshotJson', () async {
      final bookmarkedAt = DateTime.utc(2026, 5, 4, 12);
      await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: bookmarkedAt,
      );

      await repository.updateSnapshot('drug_001', '{"id":"drug_001","v":2}');

      final result = await repository.findById('drug_001');
      final entry = (result as Ok<BookmarkEntry?>).value;
      expect(entry?.snapshotJson, '{"id":"drug_001","v":2}');
      expect(entry?.bookmarkedAt, bookmarkedAt);
    });

    test('deleteById removes row', () async {
      await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: DateTime.utc(2026, 5, 4, 12),
      );

      await repository.deleteById('drug_001');

      final result = await repository.findById('drug_001');
      expect((result as Ok<BookmarkEntry?>).value, isNull);
    });

    test('findAll orders by bookmarkedAt descending', () async {
      await _insertBookmark(repository, 'drug_001', DateTime.utc(2026, 5, 4));
      await _insertBookmark(repository, 'drug_002', DateTime.utc(2026, 5, 5));

      final result = await repository.findAll();

      expect(result, isA<Ok<List<BookmarkEntry>>>());
      final entries = (result as Ok<List<BookmarkEntry>>).value;
      expect(entries.map((entry) => entry.id), ['drug_002', 'drug_001']);
    });

    test('findAll filters by id prefix', () async {
      await _insertBookmark(repository, 'drug_001', DateTime.utc(2026, 5, 4));
      await _insertBookmark(
        repository,
        'disease_001',
        DateTime.utc(2026, 5, 5),
      );

      final result = await repository.findAll(idPrefix: 'drug_');

      final entries = (result as Ok<List<BookmarkEntry>>).value;
      expect(entries.map((entry) => entry.id), ['drug_001']);
    });

    test('existsById returns whether row exists', () async {
      await _insertBookmark(repository, 'drug_001', DateTime.utc(2026, 5, 4));

      final existing = await repository.existsById('drug_001');
      final missing = await repository.existsById('drug_002');

      expect((existing as Ok<bool>).value, isTrue);
      expect((missing as Ok<bool>).value, isFalse);
    });

    test('watchExists emits on insert and delete', () async {
      final stream = repository.watchExists('drug_001');

      final expectation = expectLater(
        stream,
        emitsInOrder([false, true, false]),
      );

      await pumpEventQueue();
      await _insertBookmark(repository, 'drug_001', DateTime.utc(2026, 5, 4));
      await pumpEventQueue();
      await repository.deleteById('drug_001');
      await expectation;
    });
  });
}

Future<void> _insertBookmark(
  BookmarkRepository repository,
  String id,
  DateTime bookmarkedAt,
) async {
  await repository.insert(
    id: id,
    snapshotJson: '{"id":"$id"}',
    bookmarkedAt: bookmarkedAt,
  );
}
