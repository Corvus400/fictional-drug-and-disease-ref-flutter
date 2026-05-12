import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app_database.dart';

void main() {
  group('BookmarksDao.watchAll', () {
    late AppDatabase db;
    late BookmarksDao dao;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      dao = db.bookmarksDao;
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test(
      'emits rows by bookmarkedAt descending and updates after delete',
      () async {
        final stream = dao.watchAll();

        final expectation = expectLater(
          stream.map((rows) => rows.map((row) => row.id).toList()),
          emitsInOrder([
            <String>[],
            ['drug_older'],
            ['disease_newer', 'drug_older'],
            ['disease_newer'],
          ]),
        );

        await pumpEventQueue();
        await dao.insertBookmark(
          BookmarksTableCompanion.insert(
            id: 'drug_older',
            snapshot: '{"id":"drug_older"}',
            bookmarkedAt: DateTime.utc(2026, 5, 9),
          ),
        );
        await pumpEventQueue();
        await dao.insertBookmark(
          BookmarksTableCompanion.insert(
            id: 'disease_newer',
            snapshot: '{"id":"disease_newer"}',
            bookmarkedAt: DateTime.utc(2026, 5, 10),
          ),
        );
        await pumpEventQueue();
        await dao.deleteById('drug_older');

        await expectation;
      },
    );
  });
}
