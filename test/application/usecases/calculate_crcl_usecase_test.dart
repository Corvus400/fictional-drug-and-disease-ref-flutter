import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_crcl_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculateCrClUsecase', () {
    const usecase = CalculateCrClUsecase();

    test('returns success for valid inputs', () {
      final result = usecase.execute(
        const CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 65,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result, isA<CalculateCrClSuccess>());
      final success = result as CalculateCrClSuccess;
      expect(success.result.crClMlMin, closeTo(95.293, 0.001));
    });

    test('returns invalid for out-of-range inputs', () {
      final result = usecase.execute(
        const CrClInputs(
          ageYears: 45,
          sex: Sex.male,
          weightKg: 0.9999,
          serumCreatinineMgDl: 0.9,
        ),
      );

      expect(result, isA<CalculateCrClInvalid>());
      expect((result as CalculateCrClInvalid).field, 'weightKg');
      expect(result.range, '1.0-300.0 kg');
    });
  });
}
