import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_bmi_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculateBmiUsecase', () {
    const usecase = CalculateBmiUsecase();

    test('returns success for valid inputs', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 170, weightKg: 65),
      );

      expect(result, isA<CalculateBmiSuccess>());
      final success = result as CalculateBmiSuccess;
      expect(success.result.bmi, closeTo(22.491, 0.001));
      expect(success.result.category, BmiCategory.normal);
    });

    test('returns invalid for out-of-range inputs', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 49.9999, weightKg: 65),
      );

      expect(result, isA<CalculateBmiInvalid>());
      expect((result as CalculateBmiInvalid).field, 'heightCm');
      expect(result.range, '50.0-250.0 cm');
    });
  });
}
