import 'package:fictional_drug_and_disease_ref/application/usecases/delete_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('DeleteCalculationHistoryUsecase', () {
    late AppDatabase db;
    late CalculationHistoryRepository repository;
    late DeleteCalculationHistoryUsecase usecase;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      repository = CalculationHistoryRepository(db.calculationHistoriesDao);
      usecase = DeleteCalculationHistoryUsecase(
        calculationHistoryRepository: repository,
      );
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('deletes one row by id', () async {
      await repository.insert(
        id: 'calc_001',
        calcType: 'bmi',
        inputsJson: '{}',
        resultJson: '{}',
        calculatedAt: DateTime.utc(2026, 5, 10),
      );

      final result = await usecase.execute('calc_001');

      expect(result, isA<DeleteCalculationHistorySuccess>());
      final history = await repository.findByCalcType('bmi');
      expect((history as Ok).value, isEmpty);
    });
  });
}
