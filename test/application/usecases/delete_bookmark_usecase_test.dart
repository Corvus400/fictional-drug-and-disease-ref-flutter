import 'package:fictional_drug_and_disease_ref/application/usecases/delete_bookmark_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('DeleteBookmarkUsecase', () {
    late AppDatabase db;
    late BookmarkRepository repository;
    late DeleteBookmarkUsecase usecase;
    var databaseBroken = false;

    setUp(() {
      db = createTestAppDatabase();
      repository = BookmarkRepository(db.bookmarksDao);
      usecase = DeleteBookmarkUsecase(repository: repository);
      databaseBroken = false;
    });

    tearDown(() async {
      if (!databaseBroken) {
        await clearTestAppDatabase(db);
      }
      await db.close();
    });

    test('execute deletes the requested row id', () async {
      await repository.insert(
        id: 'drug_delete_target',
        snapshotJson: '{"id":"drug_delete_target"}',
        bookmarkedAt: DateTime.utc(2026, 5, 10, 12),
      );
      await repository.insert(
        id: 'disease_keep',
        snapshotJson: '{"id":"disease_keep"}',
        bookmarkedAt: DateTime.utc(2026, 5, 10, 13),
      );

      final result = await usecase.execute('drug_delete_target');

      expect(result, isA<Ok<void>>());
      final remaining = await repository.findAll();
      expect(remaining, isA<Ok<List<BookmarkEntry>>>());
      expect(
        (remaining as Ok<List<BookmarkEntry>>).value.map((entry) => entry.id),
        [
          'disease_keep',
        ],
      );
    });

    test('execute forwards repository errors', () async {
      await db.customStatement('DROP TABLE bookmarks');
      databaseBroken = true;

      final result = await usecase.execute('drug_delete_target');

      expect(result, isA<Err<void>>());
    });
  });
}
