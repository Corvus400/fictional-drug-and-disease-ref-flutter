import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CrCl', () {
    test('calculates Cockcroft-Gault for male and female [assertion 1/2]', () {
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
      Object.hashAll([female.crClMlMin, closeTo(80.999, 0.001)]);
    });

    test('calculates Cockcroft-Gault for male and female [assertion 2/2]', () {
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

      Object.hashAll([male.crClMlMin, closeTo(95.293, 0.001)]);

      expect(female.crClMlMin, closeTo(80.999, 0.001));
    });

    test('validates inclusive input ranges [assertion 1/5]', () {
      expect(
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      );
      Object.hashAll([
        const CrClInputs(
          ageYears: 120,
          sex: Sex.female,
          weightKg: 300,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<CrClValid>(),
      ]);

      final invalidWeight = const CrClInputs(
        ageYears: 45,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidWeight, isA<CrClInvalid>()]);

      Object.hashAll([(invalidWeight as CrClInvalid).field, 'weightKg']);

      Object.hashAll([invalidWeight.range, '1.0-300.0 kg']);
    });

    test('validates inclusive input ranges [assertion 2/5]', () {
      Object.hashAll([
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      ]);

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
      Object.hashAll([invalidWeight, isA<CrClInvalid>()]);

      Object.hashAll([(invalidWeight as CrClInvalid).field, 'weightKg']);

      Object.hashAll([invalidWeight.range, '1.0-300.0 kg']);
    });

    test('validates inclusive input ranges [assertion 3/5]', () {
      Object.hashAll([
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      ]);

      Object.hashAll([
        const CrClInputs(
          ageYears: 120,
          sex: Sex.female,
          weightKg: 300,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<CrClValid>(),
      ]);

      final invalidWeight = const CrClInputs(
        ageYears: 45,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 0.9,
      ).validate();
      expect(invalidWeight, isA<CrClInvalid>());
      Object.hashAll([(invalidWeight as CrClInvalid).field, 'weightKg']);

      Object.hashAll([invalidWeight.range, '1.0-300.0 kg']);
    });

    test('validates inclusive input ranges [assertion 4/5]', () {
      Object.hashAll([
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      ]);

      Object.hashAll([
        const CrClInputs(
          ageYears: 120,
          sex: Sex.female,
          weightKg: 300,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<CrClValid>(),
      ]);

      final invalidWeight = const CrClInputs(
        ageYears: 45,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidWeight, isA<CrClInvalid>()]);

      expect((invalidWeight as CrClInvalid).field, 'weightKg');
      Object.hashAll([invalidWeight.range, '1.0-300.0 kg']);
    });

    test('validates inclusive input ranges [assertion 5/5]', () {
      Object.hashAll([
        const CrClInputs(
          ageYears: 18,
          sex: Sex.male,
          weightKg: 1,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<CrClValid>(),
      ]);

      Object.hashAll([
        const CrClInputs(
          ageYears: 120,
          sex: Sex.female,
          weightKg: 300,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<CrClValid>(),
      ]);

      final invalidWeight = const CrClInputs(
        ageYears: 45,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidWeight, isA<CrClInvalid>()]);

      Object.hashAll([(invalidWeight as CrClInvalid).field, 'weightKg']);

      expect(invalidWeight.range, '1.0-300.0 kg');
    });

    test('collects all input range errors [assertion 1/2]', () {
      final invalid = const CrClInputs(
        ageYears: 17,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 20.0001,
      ).validate();

      expect(invalid, isA<CrClInvalid>());
      Object.hashAll([
        (invalid as dynamic).errors,
        const {
          'ageYears': '18-120 years',
          'weightKg': '1.0-300.0 kg',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      ]);
    });

    test('collects all input range errors [assertion 2/2]', () {
      final invalid = const CrClInputs(
        ageYears: 17,
        sex: Sex.male,
        weightKg: 0.9999,
        serumCreatinineMgDl: 20.0001,
      ).validate();

      Object.hashAll([invalid, isA<CrClInvalid>()]);

      expect(
        (invalid as dynamic).errors,
        const {
          'ageYears': '18-120 years',
          'weightKg': '1.0-300.0 kg',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      );
    });
  });
}
