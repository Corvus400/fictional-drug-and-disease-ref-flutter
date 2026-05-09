import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('RecordCalculationHistoryUsecase', () {
    late AppDatabase db;
    late CalculationHistoryRepository repository;
    late RecordCalculationHistoryUsecase usecase;
    var tick = 0;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    setUp(() {
      tick = 0;
      repository = CalculationHistoryRepository(db.calculationHistoriesDao);
      usecase = RecordCalculationHistoryUsecase(
        calculationHistoryRepository: repository,
        clock: () => DateTime.utc(2026, 5, 10, 12, tick++),
      );
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    test('records typed inputs and result', () async {
      final result = await usecase.execute(
        CalcType.bmi,
        const BmiInputs(heightCm: 170, weightKg: 65),
        const BmiResult(bmi: 22.5, category: BmiCategory.normal),
      );

      expect(result, isA<RecordCalculationHistorySuccess>());
      final history = await repository.findByCalcType('bmi');
      final entries = (history as Ok<List<CalculationHistoryEntry>>).value;
      expect(entries, hasLength(1));
      expect(entries.single.inputsJson, '{"heightCm":170.0,"weightKg":65.0}');
      expect(entries.single.resultJson, '{"bmi":22.5,"category":"normal"}');
    });

    test('keeps newest 50 rows per calc type', () async {
      for (var index = 0; index < 51; index += 1) {
        await usecase.execute(
          CalcType.bmi,
          BmiInputs(heightCm: 170, weightKg: 60 + index.toDouble()),
          BmiResult(bmi: 20 + index.toDouble(), category: BmiCategory.normal),
        );
      }

      final history = await repository.findByCalcType('bmi');
      final entries = (history as Ok<List<CalculationHistoryEntry>>).value;
      expect(entries, hasLength(50));
      expect(entries.first.resultJson, '{"bmi":70.0,"category":"normal"}');
      expect(entries.last.resultJson, '{"bmi":21.0,"category":"normal"}');
    });
  });
}
