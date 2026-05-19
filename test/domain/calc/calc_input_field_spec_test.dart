import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcInputFieldSpecs', () {
    test(
      'derive placeholders and range errors from the same field specs [assertion 1/8]',
      () {
        expect(CalcInputFieldSpecs.heightCm.placeholderText, '50.0〜250.0');
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 2/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        expect(CalcInputFieldSpecs.heightCm.rangeText, '50.0-250.0 cm');
        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 3/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        expect(CalcInputFieldSpecs.weightKg.placeholderText, '1.0〜300.0');
        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 4/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        expect(CalcInputFieldSpecs.weightKg.rangeText, '1.0-300.0 kg');
        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 5/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        expect(CalcInputFieldSpecs.ageYears.placeholderText, '18〜120');
        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 6/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        expect(CalcInputFieldSpecs.ageYears.rangeText, '18-120 years');
        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 7/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        expect(
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        );
        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        ]);
      },
    );

    test(
      'derive placeholders and range errors from the same field specs [assertion 8/8]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.placeholderText,
          '50.0〜250.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.rangeText,
          '50.0-250.0 cm',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.placeholderText,
          '1.0〜300.0',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.weightKg.rangeText,
          '1.0-300.0 kg',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.placeholderText,
          '18〜120',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.rangeText,
          '18-120 years',
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.serumCreatinineMgDl.placeholderText,
          '0.10〜20.00',
        ]);

        expect(
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText,
          '0.10-20.00 mg/dL',
        );
      },
    );

    test('accepts only each field editing grammar [assertion 1/10]', () {
      expect(CalcInputFieldSpecs.ageYears.allowsEditing('120'), isTrue);
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 2/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      expect(CalcInputFieldSpecs.ageYears.allowsEditing('1.5'), isFalse);
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 3/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      expect(CalcInputFieldSpecs.ageYears.allowsEditing('-1'), isFalse);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 4/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.5'), isTrue);
      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 5/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.'), isTrue);
      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 6/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      expect(CalcInputFieldSpecs.heightCm.allowsEditing('170.55'), isFalse);
      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 7/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      expect(CalcInputFieldSpecs.heightCm.allowsEditing('.5'), isFalse);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 8/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      );
      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 9/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      );
      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      ]);
    });

    test('accepts only each field editing grammar [assertion 10/10]', () {
      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('120'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('1.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.ageYears.allowsEditing('-1'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.5'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('170.55'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.heightCm.allowsEditing('.5'),
        isFalse,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.23'),
        isTrue,
      ]);

      Object.hashAll([
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('1.234'),
        isFalse,
      ]);

      expect(
        CalcInputFieldSpecs.serumCreatinineMgDl.allowsEditing('%@#'),
        isFalse,
      );
    });

    test(
      'treats trailing decimal point as incomplete text [assertion 1/3]',
      () {
        expect(CalcInputFieldSpecs.heightCm.isCompleteText('170'), isTrue);
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.isCompleteText('170.'),
          isFalse,
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.ageYears.isCompleteText('18'),
          isTrue,
        ]);
      },
    );

    test(
      'treats trailing decimal point as incomplete text [assertion 2/3]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.isCompleteText('170'),
          isTrue,
        ]);

        expect(CalcInputFieldSpecs.heightCm.isCompleteText('170.'), isFalse);
        Object.hashAll([
          CalcInputFieldSpecs.ageYears.isCompleteText('18'),
          isTrue,
        ]);
      },
    );

    test(
      'treats trailing decimal point as incomplete text [assertion 3/3]',
      () {
        Object.hashAll([
          CalcInputFieldSpecs.heightCm.isCompleteText('170'),
          isTrue,
        ]);

        Object.hashAll([
          CalcInputFieldSpecs.heightCm.isCompleteText('170.'),
          isFalse,
        ]);

        expect(CalcInputFieldSpecs.ageYears.isCompleteText('18'), isTrue);
      },
    );
  });
}
