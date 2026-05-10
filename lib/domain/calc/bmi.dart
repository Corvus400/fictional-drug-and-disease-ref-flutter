import 'dart:math' as math;

import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';

import 'package:flutter/foundation.dart';

/// BMI input values.
@immutable
final class BmiInputs {
  /// Creates BMI input values.
  const BmiInputs({required this.heightCm, required this.weightKg});

  /// Height in centimeters.
  final double heightCm;

  /// Weight in kilograms.
  final double weightKg;

  /// Returns a copy with changed fields.
  BmiInputs copyWith({double? heightCm, double? weightKg}) {
    return BmiInputs(
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
    );
  }

  /// Validates canonical BMI input ranges.
  BmiValidation validate() {
    final errors = <String, String>{};
    if (CalcInputFieldSpecs.heightCm.isOutOfRange(heightCm)) {
      errors[CalcInputFieldSpecs.heightCm.fieldName] =
          CalcInputFieldSpecs.heightCm.rangeText;
    }
    if (CalcInputFieldSpecs.weightKg.isOutOfRange(weightKg)) {
      errors[CalcInputFieldSpecs.weightKg.fieldName] =
          CalcInputFieldSpecs.weightKg.rangeText;
    }
    if (errors.isNotEmpty) {
      return BmiInvalid(errors: errors);
    }
    return const BmiValid();
  }

  @override
  bool operator ==(Object other) {
    return other is BmiInputs &&
        other.heightCm == heightCm &&
        other.weightKg == weightKg;
  }

  @override
  int get hashCode => Object.hash(heightCm, weightKg);
}

/// BMI category.
enum BmiCategory {
  /// BMI < 18.5.
  underweight('underweight'),

  /// 18.5 <= BMI < 25.
  normal('normal'),

  /// 25 <= BMI < 30.
  overweight('overweight'),

  /// 30 <= BMI < 35.
  obese1('obese_1'),

  /// 35 <= BMI < 40.
  obese2('obese_2'),

  /// 40 <= BMI < 45.
  obese3('obese_3'),

  /// BMI >= 45.
  obese4('obese_4')
  ;

  const BmiCategory(this.storageKey);

  /// Value stored in calculation history JSON.
  final String storageKey;

  /// Categorizes a BMI value.
  static BmiCategory categorize(double bmi) {
    if (bmi < 18.5) {
      return underweight;
    }
    if (bmi < 25) {
      return normal;
    }
    if (bmi < 30) {
      return overweight;
    }
    if (bmi < 35) {
      return obese1;
    }
    if (bmi < 40) {
      return obese2;
    }
    if (bmi < 45) {
      return obese3;
    }
    return obese4;
  }

  /// Parses a storage key.
  static BmiCategory parse(String value) {
    for (final category in values) {
      if (category.storageKey == value) {
        return category;
      }
    }
    throw FormatException('Unknown BMI category: $value');
  }
}

/// BMI calculation result.
@immutable
final class BmiResult {
  /// Creates a BMI result.
  const BmiResult({required this.bmi, required this.category});

  /// BMI value.
  final double bmi;

  /// BMI category.
  final BmiCategory category;

  /// Returns a copy with changed fields.
  BmiResult copyWith({double? bmi, BmiCategory? category}) {
    return BmiResult(
      bmi: bmi ?? this.bmi,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BmiResult && other.bmi == bmi && other.category == category;
  }

  @override
  int get hashCode => Object.hash(bmi, category);
}

/// BMI validation result.
sealed class BmiValidation {
  const BmiValidation();
}

/// Valid BMI inputs.
final class BmiValid extends BmiValidation {
  /// Creates a valid result.
  const BmiValid();
}

/// Invalid BMI input.
final class BmiInvalid extends BmiValidation {
  /// Creates an invalid result.
  const BmiInvalid({required this.errors});

  /// Field-level accepted range labels.
  final Map<String, String> errors;

  /// Invalid field name.
  String get field => errors.keys.first;

  /// Accepted range label.
  String get range => errors[field]!;
}

/// Pure BMI calculator.
abstract final class Bmi {
  /// Calculates BMI and category.
  static BmiResult calculate(BmiInputs inputs) {
    final heightM = inputs.heightCm / 100;
    final value = inputs.weightKg / math.pow(heightM, 2);
    return BmiResult(
      bmi: value,
      category: BmiCategory.categorize(value),
    );
  }
}
