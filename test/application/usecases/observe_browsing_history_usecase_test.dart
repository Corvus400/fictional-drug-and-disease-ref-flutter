import 'package:fictional_drug_and_disease_ref/application/usecases/observe_browsing_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/browsing_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ObserveBrowsingHistoryUsecase', () {
    late AppDatabase db;
    late BrowsingHistoryRepository repository;
    late ObserveBrowsingHistoryUsecase usecase;

    setUp(() {
      db = createTestAppDatabase();
      repository = BrowsingHistoryRepository(db.browsingHistoriesDao);
      usecase = ObserveBrowsingHistoryUsecase(repository: repository);
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

      await repository.upsert(
        'drug_001',
        viewedAt: DateTime.utc(2026, 5, 10, 12),
      );

      await expectation;
    });
  });
}
