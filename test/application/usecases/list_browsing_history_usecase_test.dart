import 'package:fictional_drug_and_disease_ref/application/usecases/list_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ListBrowsingHistoryUsecase', () {
    late AppDatabase db;
    late BrowsingHistoryRepository repository;
    late ListBrowsingHistoryUsecase usecase;
    var databaseBroken = false;

    setUp(() {
      db = createTestAppDatabase();
      repository = BrowsingHistoryRepository(db.browsingHistoriesDao);
      usecase = ListBrowsingHistoryUsecase(repository: repository);
      databaseBroken = false;
    });

    tearDown(() async {
      if (!databaseBroken) {
        await clearTestAppDatabase(db);
      }
      await db.close();
    });

    test('execute returns repository entries newest first', () async {
      await repository.upsert(
        'drug_older',
        viewedAt: DateTime.utc(2026, 5, 10, 12),
      );
      await repository.upsert(
        'disease_newer',
        viewedAt: DateTime.utc(2026, 5, 10, 13),
      );

      final result = await usecase.execute();

      expect(result, isA<Ok<List<BrowsingHistoryEntry>>>());
      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      expect(entries.map((entry) => entry.id), ['disease_newer', 'drug_older']);
    });

    test('execute forwards repository errors', () async {
      await db.customStatement('DROP TABLE browsing_history');
      databaseBroken = true;

      final result = await usecase.execute();

      expect(result, isA<Err<List<BrowsingHistoryEntry>>>());
    });

    test('execute applies idPrefix and limit to repository query', () async {
      await repository.upsert(
        'disease_latest',
        viewedAt: DateTime.utc(2026, 5, 10, 14),
      );
      await repository.upsert(
        'drug_latest',
        viewedAt: DateTime.utc(2026, 5, 10, 13),
      );
      await repository.upsert(
        'drug_older',
        viewedAt: DateTime.utc(2026, 5, 10, 12),
      );

      final result = await usecase.execute(idPrefix: 'drug_', limit: 1);

      expect(result, isA<Ok<List<BrowsingHistoryEntry>>>());
      final entries = (result as Ok<List<BrowsingHistoryEntry>>).value;
      expect(entries.map((entry) => entry.id), ['drug_latest']);
    });
  });
}
