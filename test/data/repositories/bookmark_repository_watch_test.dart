import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('BookmarkRepository.watchAll', () {
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

    test('maps DAO stream rows to domain entries preserving order', () async {
      final stream = repository.watchAll();

      final expectation = expectLater(
        stream,
        emitsInOrder([
          isEmpty,
          [
            _bookmarkEntryMatcher(
              id: 'drug_older',
              snapshotJson: '{"id":"drug_older"}',
              bookmarkedAt: DateTime.utc(2026, 5, 9),
            ),
          ],
          [
            _bookmarkEntryMatcher(
              id: 'disease_newer',
              snapshotJson: '{"id":"disease_newer"}',
              bookmarkedAt: DateTime.utc(2026, 5, 10),
            ),
            _bookmarkEntryMatcher(
              id: 'drug_older',
              snapshotJson: '{"id":"drug_older"}',
              bookmarkedAt: DateTime.utc(2026, 5, 9),
            ),
          ],
          [
            _bookmarkEntryMatcher(
              id: 'disease_newer',
              snapshotJson: '{"id":"disease_newer"}',
              bookmarkedAt: DateTime.utc(2026, 5, 10),
            ),
          ],
        ]),
      );

      await pumpEventQueue();
      await repository.insert(
        id: 'drug_older',
        snapshotJson: '{"id":"drug_older"}',
        bookmarkedAt: DateTime.utc(2026, 5, 9),
      );
      await pumpEventQueue();
      await repository.insert(
        id: 'disease_newer',
        snapshotJson: '{"id":"disease_newer"}',
        bookmarkedAt: DateTime.utc(2026, 5, 10),
      );
      await pumpEventQueue();
      await repository.deleteById('drug_older');

      await expectation;
    });
  });
}

Matcher _bookmarkEntryMatcher({
  required String id,
  required String snapshotJson,
  required DateTime bookmarkedAt,
}) {
  return isA<BookmarkEntry>()
      .having((entry) => entry.id, 'id', id)
      .having((entry) => entry.snapshotJson, 'snapshotJson', snapshotJson)
      .having((entry) => entry.bookmarkedAt, 'bookmarkedAt', bookmarkedAt);
}
