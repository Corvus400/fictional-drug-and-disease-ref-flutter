import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Egfr', () {
    test('calculates Japanese coefficient eGFR and category', () {
      final result = Egfr.calculate(
        const EgfrInputs(
          ageYears: 45,
          sex: Sex.male,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result.eGfrMlMin173m2, closeTo(73.011, 0.001));
      expect(result.stage, CkdStage.g2);
    });

    test('applies female coefficient', () {
      final result = Egfr.calculate(
        const EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result.eGfrMlMin173m2, closeTo(53.955, 0.001));
      expect(result.stage, CkdStage.g3a);
    });

    test('categorizes CKD stage boundaries', () {
      expect(CkdStage.categorize(90), CkdStage.g1);
      expect(CkdStage.categorize(89.999), CkdStage.g2);
      expect(CkdStage.categorize(60), CkdStage.g2);
      expect(CkdStage.categorize(59.999), CkdStage.g3a);
      expect(CkdStage.categorize(45), CkdStage.g3a);
      expect(CkdStage.categorize(44.999), CkdStage.g3b);
      expect(CkdStage.categorize(30), CkdStage.g3b);
      expect(CkdStage.categorize(29.999), CkdStage.g4);
      expect(CkdStage.categorize(15), CkdStage.g4);
      expect(CkdStage.categorize(14.999), CkdStage.g5);
    });

    test('validates inclusive input ranges', () {
      expect(
        const EgfrInputs(
          ageYears: 18,
          sex: Sex.male,
          serumCreatinineMgDl: 0.10,
        ).validate(),
        isA<EgfrValid>(),
      );
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
      expect(invalidAge, isA<EgfrInvalid>());
      expect((invalidAge as EgfrInvalid).field, 'ageYears');
      expect(invalidAge.range, '18-120 years');

      final invalidCreatinine = const EgfrInputs(
        ageYears: 45,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();
      expect(invalidCreatinine, isA<EgfrInvalid>());
      expect((invalidCreatinine as EgfrInvalid).field, 'serumCreatinineMgDl');
      expect(invalidCreatinine.range, '0.10-20.00 mg/dL');
    });

    test('collects all input range errors', () {
      final invalid = const EgfrInputs(
        ageYears: 17,
        sex: Sex.male,
        serumCreatinineMgDl: 20.0001,
      ).validate();

      expect(invalid, isA<EgfrInvalid>());
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
