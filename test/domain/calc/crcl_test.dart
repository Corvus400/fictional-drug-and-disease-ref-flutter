import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CrCl', () {
    test('calculates Cockcroft-Gault for male and female', () {
      final male = CrCl.calculate(
        const CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        ),
      );
      final female = CrCl.calculate(
        const CrClInputs(
          ageYears: 45,
          sex: Sex.female,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(male.crClMlMin, closeTo(95.293, 0.001));
      expect(female.crClMlMin, closeTo(80.999, 0.001));
    });

    test('validates inclusive input ranges', () {
      expect(
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      );
      expect(
        const CrClInputs(
          ageYears: 120,
          sex: Sex.female,
          weightKg: 300,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<CrClValid>(),
      );

      final invalidWeight = const CrClInputs(
        ageYears: 45,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 0.9,
      ).validate();
      expect(invalidWeight, isA<CrClInvalid>());
      expect((invalidWeight as CrClInvalid).field, 'weightKg');
      expect(invalidWeight.range, '1.0-300.0 kg');
    });
  });
}
