import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bmi', () {
    test('calculates known value and category', () {
      final result = Bmi.calculate(
        const BmiInputs(heightCm: 170, weightKg: 65),
      );

      expect(result.bmi, closeTo(22.491, 0.001));
      expect(result.category, BmiCategory.normal);
    });

    test('categorizes seven class boundaries', () {
      expect(BmiCategory.categorize(18.49), BmiCategory.underweight);
      expect(BmiCategory.categorize(18.5), BmiCategory.normal);
      expect(BmiCategory.categorize(25), BmiCategory.overweight);
      expect(BmiCategory.categorize(30), BmiCategory.obese1);
      expect(BmiCategory.categorize(35), BmiCategory.obese2);
      expect(BmiCategory.categorize(40), BmiCategory.obese3);
      expect(BmiCategory.categorize(45), BmiCategory.obese4);
    });

    test('validates inclusive input ranges', () {
      expect(
        const BmiInputs(heightCm: 50, weightKg: 1).validate(),
        isA<BmiValid>(),
      );
      expect(
        const BmiInputs(heightCm: 250, weightKg: 300).validate(),
        isA<BmiValid>(),
      );

      final invalidHeight = const BmiInputs(
        heightCm: 49.9999,
        weightKg: 65,
      ).validate();
      expect(invalidHeight, isA<BmiInvalid>());
      expect((invalidHeight as BmiInvalid).field, 'heightCm');
      expect(invalidHeight.range, '50.0-250.0 cm');

      final invalidWeight = const BmiInputs(
        heightCm: 170,
        weightKg: 300.0001,
      ).validate();
      expect(invalidWeight, isA<BmiInvalid>());
      expect((invalidWeight as BmiInvalid).field, 'weightKg');
      expect(invalidWeight.range, '1.0-300.0 kg');
    });

    test('collects all input range errors', () {
      final invalid = const BmiInputs(
        heightCm: 49.9999,
        weightKg: 300.0001,
      ).validate();

      expect(invalid, isA<BmiInvalid>());
      expect(
        (invalid as dynamic).errors,
        const {
          'heightCm': '50.0-250.0 cm',
          'weightKg': '1.0-300.0 kg',
        },
      );
    });

    test('supports value equality and copyWith', () {
      const inputs = BmiInputs(heightCm: 170, weightKg: 65);

      expect(inputs, const BmiInputs(heightCm: 170, weightKg: 65));
      expect(
        inputs.copyWith(weightKg: 70),
        const BmiInputs(heightCm: 170, weightKg: 70),
      );
    });
  });
}
