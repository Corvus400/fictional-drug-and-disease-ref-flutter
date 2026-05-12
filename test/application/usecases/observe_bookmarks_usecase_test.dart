import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmarks_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ObserveBookmarksUsecase', () {
    late AppDatabase db;
    late BookmarkRepository repository;
    late ObserveBookmarksUsecase usecase;

    setUp(() {
      db = createTestAppDatabase();
      repository = BookmarkRepository(db.bookmarksDao);
      usecase = ObserveBookmarksUsecase(repository: repository);
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
      await db.close();
    });

    test('execute emits repository watchAll values', () async {
      final expectation = expectLater(
        usecase.execute().map((entries) => entries.map((entry) => entry.id)),
        emitsInOrder(<Object>[
          isEmpty,
          ['drug_001'],
        ]),
      );
      await Future<void>.delayed(Duration.zero);

      await repository.insert(
        id: 'drug_001',
        snapshotJson: '{"id":"drug_001"}',
        bookmarkedAt: DateTime.utc(2026, 5, 10, 12),
      );

      await expectation;
    });
  });
}
