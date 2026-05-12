import 'package:fictional_drug_and_disease_ref/application/usecases/clear_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ClearBrowsingHistoryUsecase', () {
    late AppDatabase db;
    late BrowsingHistoryRepository repository;
    late ClearBrowsingHistoryUsecase usecase;
    var databaseBroken = false;

    setUp(() {
      db = createTestAppDatabase();
      repository = BrowsingHistoryRepository(db.browsingHistoriesDao);
      usecase = ClearBrowsingHistoryUsecase(repository: repository);
      databaseBroken = false;
    });

    tearDown(() async {
      if (!databaseBroken) {
        await clearTestAppDatabase(db);
      }
      await db.close();
    });

    test('execute deletes all rows', () async {
      await repository.upsert(
        'drug_001',
        viewedAt: DateTime.utc(2026, 5, 10, 12),
      );
      await repository.upsert(
        'disease_001',
        viewedAt: DateTime.utc(2026, 5, 10, 13),
      );

      final result = await usecase.execute();

      expect(result, isA<Ok<void>>());
      final remaining = await repository.findAll();
      expect(remaining, isA<Ok<List<BrowsingHistoryEntry>>>());
      expect((remaining as Ok<List<BrowsingHistoryEntry>>).value, isEmpty);
    });

    test('execute forwards repository errors', () async {
      await db.customStatement('DROP TABLE browsing_history');
      databaseBroken = true;

      final result = await usecase.execute();

      expect(result, isA<Err<void>>());
    });
  });
}
