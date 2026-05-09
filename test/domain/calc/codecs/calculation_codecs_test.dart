import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculation codecs', () {
    const inputsCodec = CalculationInputsCodec();
    const resultCodec = CalculationResultCodec();

    test('roundtrips BMI inputs and result using schema keys', () {
      const inputs = BmiInputs(heightCm: 170, weightKg: 65);
      const result = BmiResult(bmi: 22.5, category: BmiCategory.normal);

      expect(inputsCodec.encode(inputs), '{"heightCm":170.0,"weightKg":65.0}');
      expect(
        inputsCodec.decode(CalcType.bmi, inputsCodec.encode(inputs)),
        inputs,
      );
      expect(resultCodec.encode(result), '{"bmi":22.5,"category":"normal"}');
      expect(
        resultCodec.decode(CalcType.bmi, resultCodec.encode(result)),
        result,
      );
    });

    test('roundtrips eGFR inputs and result using schema keys', () {
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
      expect(
        inputsCodec.decode(CalcType.egfr, inputsCodec.encode(inputs)),
        inputs,
      );
      expect(
        resultCodec.encode(result),
        '{"eGfrMlMin173m2":53.9,"ckdStage":"G3a"}',
      );
      expect(
        resultCodec.decode(CalcType.egfr, resultCodec.encode(result)),
        result,
      );
    });

    test('roundtrips CrCl inputs and result using schema keys', () {
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
      expect(
        inputsCodec.decode(CalcType.crcl, inputsCodec.encode(inputs)),
        inputs,
      );
      expect(resultCodec.encode(result), '{"crClMlMin":95.3}');
      expect(
        resultCodec.decode(CalcType.crcl, resultCodec.encode(result)),
        result,
      );
    });

    test('throws FormatException for invalid payloads', () {
      expect(
        () => inputsCodec.decode(CalcType.bmi, '{"heightCm":"bad"}'),
        throwsFormatException,
      );
      expect(
        () => resultCodec.decode(CalcType.egfr, '{"ckdStage":"G9"}'),
        throwsFormatException,
      );
    });
  });
}
