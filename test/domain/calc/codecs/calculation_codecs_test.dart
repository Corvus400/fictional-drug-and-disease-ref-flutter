import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

const _expectedCrClInputsJson =
    '{"ageYears":45,"sex":"male","weightKg":65.0,'
    '"serumCreatinineMgDl":0.9}';

void main() {
  group('Calculation codecs', () {
    const inputsCodec = CalculationInputsCodec();
    const resultCodec = CalculationResultCodec();

    test(
      'roundtrips BMI inputs and result using schema keys [assertion 1/4]',
      () {
        const inputs = BmiInputs(heightCm: 170, weightKg: 65);
        const result = BmiResult(bmi: 22.5, category: BmiCategory.normal);

        expect(
          inputsCodec.encode(inputs),
          '{"heightCm":170.0,"weightKg":65.0}',
        );
        Object.hashAll([
          inputsCodec.decode(CalcType.bmi, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([
          resultCodec.encode(result),
          '{"bmi":22.5,"category":"normal"}',
        ]);

        Object.hashAll([
          resultCodec.decode(CalcType.bmi, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips BMI inputs and result using schema keys [assertion 2/4]',
      () {
        const inputs = BmiInputs(heightCm: 170, weightKg: 65);
        const result = BmiResult(bmi: 22.5, category: BmiCategory.normal);

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"heightCm":170.0,"weightKg":65.0}',
        ]);

        expect(
          inputsCodec.decode(CalcType.bmi, inputsCodec.encode(inputs)),
          inputs,
        );
        Object.hashAll([
          resultCodec.encode(result),
          '{"bmi":22.5,"category":"normal"}',
        ]);

        Object.hashAll([
          resultCodec.decode(CalcType.bmi, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips BMI inputs and result using schema keys [assertion 3/4]',
      () {
        const inputs = BmiInputs(heightCm: 170, weightKg: 65);
        const result = BmiResult(bmi: 22.5, category: BmiCategory.normal);

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"heightCm":170.0,"weightKg":65.0}',
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.bmi, inputsCodec.encode(inputs)),
          inputs,
        ]);

        expect(resultCodec.encode(result), '{"bmi":22.5,"category":"normal"}');
        Object.hashAll([
          resultCodec.decode(CalcType.bmi, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips BMI inputs and result using schema keys [assertion 4/4]',
      () {
        const inputs = BmiInputs(heightCm: 170, weightKg: 65);
        const result = BmiResult(bmi: 22.5, category: BmiCategory.normal);

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"heightCm":170.0,"weightKg":65.0}',
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.bmi, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([
          resultCodec.encode(result),
          '{"bmi":22.5,"category":"normal"}',
        ]);

        expect(
          resultCodec.decode(CalcType.bmi, resultCodec.encode(result)),
          result,
        );
      },
    );

    test(
      'roundtrips eGFR inputs and result using schema keys [assertion 1/4]',
      () {
        const inputs = EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        );
        const result = EgfrResult(
          eGfrMlMin173m2: 53.9,
          stage: CkdStage.g3a,
        );

        expect(
          inputsCodec.encode(inputs),
          '{"ageYears":45,"sex":"female","serumCreatinineMgDl":0.9}',
        );
        Object.hashAll([
          inputsCodec.decode(CalcType.egfr, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([
          resultCodec.encode(result),
          '{"eGfrMlMin173m2":53.9,"ckdStage":"G3a"}',
        ]);

        Object.hashAll([
          resultCodec.decode(CalcType.egfr, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips eGFR inputs and result using schema keys [assertion 2/4]',
      () {
        const inputs = EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        );
        const result = EgfrResult(
          eGfrMlMin173m2: 53.9,
          stage: CkdStage.g3a,
        );

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"ageYears":45,"sex":"female","serumCreatinineMgDl":0.9}',
        ]);

        expect(
          inputsCodec.decode(CalcType.egfr, inputsCodec.encode(inputs)),
          inputs,
        );
        Object.hashAll([
          resultCodec.encode(result),
          '{"eGfrMlMin173m2":53.9,"ckdStage":"G3a"}',
        ]);

        Object.hashAll([
          resultCodec.decode(CalcType.egfr, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips eGFR inputs and result using schema keys [assertion 3/4]',
      () {
        const inputs = EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        );
        const result = EgfrResult(
          eGfrMlMin173m2: 53.9,
          stage: CkdStage.g3a,
        );

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"ageYears":45,"sex":"female","serumCreatinineMgDl":0.9}',
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.egfr, inputsCodec.encode(inputs)),
          inputs,
        ]);

        expect(
          resultCodec.encode(result),
          '{"eGfrMlMin173m2":53.9,"ckdStage":"G3a"}',
        );
        Object.hashAll([
          resultCodec.decode(CalcType.egfr, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips eGFR inputs and result using schema keys [assertion 4/4]',
      () {
        const inputs = EgfrInputs(
          ageYears: 45,
          sex: Sex.female,
          serumCreatinineMgDl: 0.9,
        );
        const result = EgfrResult(
          eGfrMlMin173m2: 53.9,
          stage: CkdStage.g3a,
        );

        Object.hashAll([
          inputsCodec.encode(inputs),
          '{"ageYears":45,"sex":"female","serumCreatinineMgDl":0.9}',
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.egfr, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([
          resultCodec.encode(result),
          '{"eGfrMlMin173m2":53.9,"ckdStage":"G3a"}',
        ]);

        expect(
          resultCodec.decode(CalcType.egfr, resultCodec.encode(result)),
          result,
        );
      },
    );

    test(
      'roundtrips CrCl inputs and result using schema keys [assertion 1/4]',
      () {
        const inputs = CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        );
        const result = CrClResult(crClMlMin: 95.3);

        expect(
          inputsCodec.encode(inputs),
          '{"ageYears":45,"sex":"male","weightKg":65.0,'
          '"serumCreatinineMgDl":0.9}',
        );
        Object.hashAll([
          inputsCodec.decode(CalcType.crcl, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([resultCodec.encode(result), '{"crClMlMin":95.3}']);

        Object.hashAll([
          resultCodec.decode(CalcType.crcl, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips CrCl inputs and result using schema keys [assertion 2/4]',
      () {
        const inputs = CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        );
        const result = CrClResult(crClMlMin: 95.3);

        Object.hashAll([
          inputsCodec.encode(inputs),
          _expectedCrClInputsJson,
        ]);

        expect(
          inputsCodec.decode(CalcType.crcl, inputsCodec.encode(inputs)),
          inputs,
        );
        Object.hashAll([resultCodec.encode(result), '{"crClMlMin":95.3}']);

        Object.hashAll([
          resultCodec.decode(CalcType.crcl, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips CrCl inputs and result using schema keys [assertion 3/4]',
      () {
        const inputs = CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        );
        const result = CrClResult(crClMlMin: 95.3);

        Object.hashAll([
          inputsCodec.encode(inputs),
          _expectedCrClInputsJson,
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.crcl, inputsCodec.encode(inputs)),
          inputs,
        ]);

        expect(resultCodec.encode(result), '{"crClMlMin":95.3}');
        Object.hashAll([
          resultCodec.decode(CalcType.crcl, resultCodec.encode(result)),
          result,
        ]);
      },
    );

    test(
      'roundtrips CrCl inputs and result using schema keys [assertion 4/4]',
      () {
        const inputs = CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        );
        const result = CrClResult(crClMlMin: 95.3);

        Object.hashAll([
          inputsCodec.encode(inputs),
          _expectedCrClInputsJson,
        ]);

        Object.hashAll([
          inputsCodec.decode(CalcType.crcl, inputsCodec.encode(inputs)),
          inputs,
        ]);

        Object.hashAll([resultCodec.encode(result), '{"crClMlMin":95.3}']);

        expect(
          resultCodec.decode(CalcType.crcl, resultCodec.encode(result)),
          result,
        );
      },
    );

    test('throws FormatException for invalid payloads [assertion 1/2]', () {
      expect(
        () => inputsCodec.decode(CalcType.bmi, '{"heightCm":"bad"}'),
        throwsFormatException,
      );
      Object.hashAll([
        () => resultCodec.decode(CalcType.egfr, '{"ckdStage":"G9"}'),
        throwsFormatException,
      ]);
    });

    test('throws FormatException for invalid payloads [assertion 2/2]', () {
      Object.hashAll([
        () => inputsCodec.decode(CalcType.bmi, '{"heightCm":"bad"}'),
        throwsFormatException,
      ]);

      expect(
        () => resultCodec.decode(CalcType.egfr, '{"ckdStage":"G9"}'),
        throwsFormatException,
      );
    });
  });
}
