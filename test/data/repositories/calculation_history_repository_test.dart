import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculationHistoryRepository', () {
    late AppDatabase db;
    late CalculationHistoryRepository repository;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = CalculationHistoryRepository(db.calculationHistoriesDao);
    });

    tearDown(() async {
      await db.close();
    });

    test('insert creates row', () async {
      final calculatedAt = DateTime.utc(2026, 5, 4, 12);

      await repository.insert(
        id: 'calc_001',
        calcType: 'bmi',
        inputsJson: '{"heightCm":170,"weightKg":65}',
        resultJson: '{"bmi":22.5}',
        calculatedAt: calculatedAt,
      );

      final result = await repository.findByCalcType('bmi');

      expect(result, isA<Ok<List<CalculationHistoryEntry>>>());
      final entries = (result as Ok<List<CalculationHistoryEntry>>).value;
      expect(entries.single.id, 'calc_001');
      expect(entries.single.inputsJson, '{"heightCm":170,"weightKg":65}');
      expect(entries.single.resultJson, '{"bmi":22.5}');
      expect(entries.single.calculatedAt, calculatedAt);
    });

    test('invalid calcType returns check constraint error', () async {
      final result = await repository.insert(
        id: 'calc_001',
        calcType: 'unknown',
        inputsJson: '{}',
        resultJson: '{}',
        calculatedAt: DateTime.utc(2026, 5, 4),
      );

      expect(result, isA<Err<void>>());
      final error = (result as Err<void>).error;
      expect(error, isA<StorageException>());
      expect(
        (error as StorageException).kind,
        StorageErrorKind.checkConstraint,
      );
    });

    test(
      'findByCalcType orders by calculatedAt descending and limits',
      () async {
        await _insertCalculation(repository, 'calc_001', 'bmi');
        await _insertCalculation(repository, 'calc_002', 'egfr');
        await _insertCalculation(repository, 'calc_003', 'bmi');

        final result = await repository.findByCalcType('bmi', limit: 1);

        final entries = (result as Ok<List<CalculationHistoryEntry>>).value;
        expect(entries.map((entry) => entry.id), ['calc_003']);
      },
    );

    test('deleteById and deleteOldestByCalcType work', () async {
      await _insertCalculation(repository, 'calc_001', 'bmi');
      await _insertCalculation(repository, 'calc_002', 'bmi');
      await _insertCalculation(repository, 'calc_003', 'egfr');

      await repository.deleteById('calc_002');
      await repository.deleteOldestByCalcType('bmi');

      final bmi = await repository.findByCalcType('bmi');
      final egfr = await repository.findByCalcType('egfr');

      expect((bmi as Ok<List<CalculationHistoryEntry>>).value, isEmpty);
      expect(
        (egfr as Ok<List<CalculationHistoryEntry>>).value.map(
          (entry) => entry.id,
        ),
        ['calc_003'],
      );
    });
  });
}

Future<void> _insertCalculation(
  CalculationHistoryRepository repository,
  String id,
  String calcType,
) async {
  final day = int.parse(id.split('_').last);
  await repository.insert(
    id: id,
    calcType: calcType,
    inputsJson: '{"id":"$id"}',
    resultJson: '{"value":$day}',
    calculatedAt: DateTime.utc(2026, 5, day),
  );
}
