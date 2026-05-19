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

    test('returns newest rows limited to 50 [assertion 1/5]', () async {
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
      Object.hashAll([entries, isA<List<CalculationHistoryEntry>>()]);

      Object.hashAll([entries, hasLength(50)]);

      Object.hashAll([entries.first.id, 'calc_50']);

      Object.hashAll([entries.last.id, 'calc_1']);
    });

    test('returns newest rows limited to 50 [assertion 2/5]', () async {
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

      Object.hashAll([result, isA<ListCalculationHistorySuccess>()]);

      final entries = (result as ListCalculationHistorySuccess).entries;
      expect(entries, isA<List<CalculationHistoryEntry>>());
      Object.hashAll([entries, hasLength(50)]);

      Object.hashAll([entries.first.id, 'calc_50']);

      Object.hashAll([entries.last.id, 'calc_1']);
    });

    test('returns newest rows limited to 50 [assertion 3/5]', () async {
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

      Object.hashAll([result, isA<ListCalculationHistorySuccess>()]);

      final entries = (result as ListCalculationHistorySuccess).entries;
      Object.hashAll([entries, isA<List<CalculationHistoryEntry>>()]);

      expect(entries, hasLength(50));
      Object.hashAll([entries.first.id, 'calc_50']);

      Object.hashAll([entries.last.id, 'calc_1']);
    });

    test('returns newest rows limited to 50 [assertion 4/5]', () async {
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

      Object.hashAll([result, isA<ListCalculationHistorySuccess>()]);

      final entries = (result as ListCalculationHistorySuccess).entries;
      Object.hashAll([entries, isA<List<CalculationHistoryEntry>>()]);

      Object.hashAll([entries, hasLength(50)]);

      expect(entries.first.id, 'calc_50');
      Object.hashAll([entries.last.id, 'calc_1']);
    });

    test('returns newest rows limited to 50 [assertion 5/5]', () async {
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

      Object.hashAll([result, isA<ListCalculationHistorySuccess>()]);

      final entries = (result as ListCalculationHistorySuccess).entries;
      Object.hashAll([entries, isA<List<CalculationHistoryEntry>>()]);

      Object.hashAll([entries, hasLength(50)]);

      Object.hashAll([entries.first.id, 'calc_50']);

      expect(entries.last.id, 'calc_1');
    });
  });
}
