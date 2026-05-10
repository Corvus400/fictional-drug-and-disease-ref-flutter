import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcInputFieldSpecs', () {
    test('derive placeholders and range errors from the same field specs', () {
      expect(CalcInputFieldSpecs.heightCm.placeholderText, '50.0〜250.0');
      expect(CalcInputFieldSpecs.heightCm.rangeText, '50.0-250.0 cm');
      expect(CalcInputFieldSpecs.weightKg.placeholderText, '1.0〜300.0');
      expect(CalcInputFieldSpecs.weightKg.rangeText, '1.0-300.0 kg');
      expect(CalcInputFieldSpecs.ageYears.placeholderText, '18〜120');
      expect(CalcInputFieldSpecs.ageYears.rangeText, '18-120 years');
      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
        '0.10〜20.00',
      );
      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
        '0.10-20.00 mg/dL',
      );
    });

    test('accepts only each field editing grammar', () {
      expect(CalcInputFieldSpecs.ageYears.allowsEditing('120'), isTrue);
      expect(CalcInputFieldSpecs.ageYears.allowsEditing('1.5'), isFalse);
      expect(CalcInputFieldSpecs.ageYears.allowsEditing('-1'), isFalse);

      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.5'), isTrue);
      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.'), isTrue);
      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.55'), isFalse);
      expect(CalcInputFieldSpecs.heightCm.allowsEditing('.5'), isFalse);

      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      );
      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      );
      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      );
    });

    test('treats trailing decimal point as incomplete text', () {
      expect(CalcInputFieldSpecs.heightCm.isCompleteText('170'), isTrue);
      expect(CalcInputFieldSpecs.heightCm.isCompleteText('170.'), isFalse);
      expect(CalcInputFieldSpecs.ageYears.isCompleteText('18'), isTrue);
    });
  });
}
