import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_egfr_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculateEgfrUsecase', () {
    const usecase = CalculateEgfrUsecase();

    test('returns success for valid inputs', () {
      final result = usecase.execute(
        const EgfrInputs(
          ageYears: 45,
          sex: Sex.male,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result, isA<CalculateEgfrSuccess>());
      final success = result as CalculateEgfrSuccess;
      expect(success.result.eGfrMlMin173m2, closeTo(73.011, 0.001));
      expect(success.result.stage, CkdStage.g2);
    });

    test('returns invalid for out-of-range inputs', () {
      final result = usecase.execute(
        const EgfrInputs(
          ageYears: 17,
          sex: Sex.male,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result, isA<CalculateEgfrInvalid>());
      expect((result as CalculateEgfrInvalid).field, 'ageYears');
      expect(result.range, '18-120 years');
    });

    test('returns all field errors for multiple out-of-range inputs', () {
      final result = usecase.execute(
        const EgfrInputs(
          ageYears: 17,
          sex: Sex.male,
          serumCreatinineMgDl: 20.0001,
        ),
      );

      expect(result, isA<CalculateEgfrInvalid>());
      expect(
        (result as dynamic).errors,
        const {
          'ageYears': '18-120 years',
          'serumCreatinineMgDl': '0.10-20.00 mg/dL',
        },
      );
    });
  });
}
