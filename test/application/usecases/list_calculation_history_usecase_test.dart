import 'package:fictional_drug_and_disease_ref/application/usecases/list_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ListCalculationHistoryUsecase', () {
    late AppDatabase db;
    late CalculationHistoryRepository repository;
    late ListCalculationHistoryUsecase usecase;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      repository = CalculationHistoryRepository(db.calculationHistoriesDao);
      usecase = ListCalculationHistoryUsecase(
        calculationHistoryRepository: repository,
      );
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('returns empty result when no rows exist', () async {
      final result = await usecase.execute(CalcType.bmi);

      expect(result, isA<ListCalculationHistoryEmpty>());
    });

    test('returns newest rows limited to 50', () async {
      for (var index = 0; index < 51; index += 1) {
        await repository.insert(
          id: 'calc_$index',
          calcType: 'bmi',
          inputsJson: '{"index":$index}',
          resultJson: '{"value":$index}',
          calculatedAt: DateTime.utc(2026, 5, 10, 12, index),
        );
      }

      final result = await usecase.execute(CalcType.bmi);

      expect(result, isA<ListCalculationHistorySuccess>());
      final entries = (result as ListCalculationHistorySuccess).entries;
      expect(entries, isA<List<CalculationHistoryEntry>>());
      expect(entries, hasLength(50));
      expect(entries.first.id, 'calc_50');
      expect(entries.last.id, 'calc_1');
    });
  });
}
