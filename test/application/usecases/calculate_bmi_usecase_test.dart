import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_bmi_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculateBmiUsecase', () {
    const usecase = CalculateBmiUsecase();

    test('returns success for valid inputs [assertion 1/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 170, weightKg: 65),
      );

      expect(result, isA<CalculateBmiSuccess>());
      final success = result as CalculateBmiSuccess;
      Object.hashAll([success.result.bmi, closeTo(22.491, 0.001)]);

      Object.hashAll([success.result.category, BmiCategory.normal]);
    });

    test('returns success for valid inputs [assertion 2/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 170, weightKg: 65),
      );

      Object.hashAll([result, isA<CalculateBmiSuccess>()]);

      final success = result as CalculateBmiSuccess;
      expect(success.result.bmi, closeTo(22.491, 0.001));
      Object.hashAll([success.result.category, BmiCategory.normal]);
    });

    test('returns success for valid inputs [assertion 3/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 170, weightKg: 65),
      );

      Object.hashAll([result, isA<CalculateBmiSuccess>()]);

      final success = result as CalculateBmiSuccess;
      Object.hashAll([success.result.bmi, closeTo(22.491, 0.001)]);

      expect(success.result.category, BmiCategory.normal);
    });

    test('returns invalid for out-of-range inputs [assertion 1/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 49.9999, weightKg: 65),
      );

      expect(result, isA<CalculateBmiInvalid>());
      Object.hashAll([(result as CalculateBmiInvalid).field, 'heightCm']);

      Object.hashAll([result.range, '50.0-250.0 cm']);
    });

    test('returns invalid for out-of-range inputs [assertion 2/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 49.9999, weightKg: 65),
      );

      Object.hashAll([result, isA<CalculateBmiInvalid>()]);

      expect((result as CalculateBmiInvalid).field, 'heightCm');
      Object.hashAll([result.range, '50.0-250.0 cm']);
    });

    test('returns invalid for out-of-range inputs [assertion 3/3]', () {
      final result = usecase.execute(
        const BmiInputs(heightCm: 49.9999, weightKg: 65),
      );

      Object.hashAll([result, isA<CalculateBmiInvalid>()]);

      Object.hashAll([(result as CalculateBmiInvalid).field, 'heightCm']);

      expect(result.range, '50.0-250.0 cm');
    });

    test(
      'returns all field errors for multiple out-of-range inputs [assertion 1/2]',
      () {
        final result = usecase.execute(
          const BmiInputs(heightCm: 49.9999, weightKg: 300.0001),
        );

        expect(result, isA<CalculateBmiInvalid>());
        Object.hashAll([
          (result as dynamic).errors,
          const {
            'heightCm': '50.0-250.0 cm',
            'weightKg': '1.0-300.0 kg',
          },
        ]);
      },
    );

    test(
      'returns all field errors for multiple out-of-range inputs [assertion 2/2]',
      () {
        final result = usecase.execute(
          const BmiInputs(heightCm: 49.9999, weightKg: 300.0001),
        );

        Object.hashAll([result, isA<CalculateBmiInvalid>()]);

        expect(
          (result as dynamic).errors,
          const {
            'heightCm': '50.0-250.0 cm',
            'weightKg': '1.0-300.0 kg',
          },
        );
      },
    );
  });
}
