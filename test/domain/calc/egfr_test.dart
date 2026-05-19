import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Egfr', () {
    test(
      'calculates Japanese coefficient eGFR and category [assertion 1/2]',
      () {
        final result = Egfr.calculate(
          const EgfrInputs(
            ageYears: 45,
            sex: Sex.male,
            serumCreatinineMgDl: 0.9,
          ),
        );

        expect(result.eGfrMlMin173m2, closeTo(73.011, 0.001));
        Object.hashAll([result.stage, CkdStage.g2]);
      },
    );

    test(
      'calculates Japanese coefficient eGFR and category [assertion 2/2]',
      () {
        final result = Egfr.calculate(
          const EgfrInputs(
            ageYears: 45,
            sex: Sex.male,
            serumCreatinineMgDl: 0.9,
          ),
        );

        Object.hashAll([result.eGfrMlMin173m2, closeTo(73.011, 0.001)]);

        expect(result.stage, CkdStage.g2);
      },
    );

    test('applies female coefficient [assertion 1/2]', () {
      final result = Egfr.calculate(
        const EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result.eGfrMlMin173m2, closeTo(53.955, 0.001));
      Object.hashAll([result.stage, CkdStage.g3a]);
    });

    test('applies female coefficient [assertion 2/2]', () {
      final result = Egfr.calculate(
        const EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        ),
      );

      Object.hashAll([result.eGfrMlMin173m2, closeTo(53.955, 0.001)]);

      expect(result.stage, CkdStage.g3a);
    });

    test('categorizes CKD stage boundaries [assertion 1/10]', () {
      expect(CkdStage.categorize(90), CkdStage.g1);
      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 2/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      expect(CkdStage.categorize(89.999), CkdStage.g2);
      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 3/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      expect(CkdStage.categorize(60), CkdStage.g2);
      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 4/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      expect(CkdStage.categorize(59.999), CkdStage.g3a);
      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 5/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      expect(CkdStage.categorize(45), CkdStage.g3a);
      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 6/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      expect(CkdStage.categorize(44.999), CkdStage.g3b);
      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 7/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      expect(CkdStage.categorize(30), CkdStage.g3b);
      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 8/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      expect(CkdStage.categorize(29.999), CkdStage.g4);
      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 9/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      expect(CkdStage.categorize(15), CkdStage.g4);
      Object.hashAll([CkdStage.categorize(14.999), CkdStage.g5]);
    });

    test('categorizes CKD stage boundaries [assertion 10/10]', () {
      Object.hashAll([CkdStage.categorize(90), CkdStage.g1]);

      Object.hashAll([CkdStage.categorize(89.999), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(60), CkdStage.g2]);

      Object.hashAll([CkdStage.categorize(59.999), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(45), CkdStage.g3a]);

      Object.hashAll([CkdStage.categorize(44.999), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(30), CkdStage.g3b]);

      Object.hashAll([CkdStage.categorize(29.999), CkdStage.g4]);

      Object.hashAll([CkdStage.categorize(15), CkdStage.g4]);

      expect(CkdStage.categorize(14.999), CkdStage.g5);
    });

    test('validates inclusive input ranges [assertion 1/8]', () {
      expect(
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      );
      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 2/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      expect(
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      );

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 3/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      expect(invalidAge, isA<EgfrInvalid>());
      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 4/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      expect((invalidAge as EgfrInvalid).field, 'ageYears');
      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 5/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      expect(invalidAge.range, '18-120 years');

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 6/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      expect(invalidCreatinine, isA<EgfrInvalid>());
      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 7/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      expect((invalidCreatinine as EgfrInvalid).field, 'serumCreatinineMgDl');
      Object.hashAll([invalidCreatinine.range, '0.10-20.00 mg/dL']);
    });

    test('validates inclusive input ranges [assertion 8/8]', () {
      Object.hashAll([
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      Object.hashAll([
        const EgfrInputs(
          ageYears: 120,
          sex: Sex.female,
          serumCreatinineMgDl: 20,
        ).validate(),
        isA<EgfrValid>(),
      ]);

      final invalidAge = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 0.9,
      ).validate();
      Object.hashAll([invalidAge, isA<EgfrInvalid>()]);

      Object.hashAll([(invalidAge as EgfrInvalid).field, 'ageYears']);

      Object.hashAll([invalidAge.range, '18-120 years']);

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      Object.hashAll([invalidCreatinine, isA<EgfrInvalid>()]);

      Object.hashAll([
        (invalidCreatinine as EgfrInvalid).field,
        'serumCreatinineMgDl',
      ]);

      expect(invalidCreatinine.range, '0.10-20.00 mg/dL');
    });

    test('collects all input range errors [assertion 1/2]', () {
      final invalid = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();

      expect(invalid, isA<EgfrInvalid>());
      Object.hashAll([
        (invalid as dynamic).errors,
        const {
          'ageYears': '18-120 years',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      ]);
    });

    test('collects all input range errors [assertion 2/2]', () {
      final invalid = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();

      Object.hashAll([invalid, isA<EgfrInvalid>()]);

      expect(
        (invalid as dynamic).errors,
        const {
          'ageYears': '18-120 years',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      );
    });
  });
}
