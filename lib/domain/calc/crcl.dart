import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter/foundation.dart';

/// Cockcroft-Gault CrCl input values.
@immutable
final class CrClInputs {
  /// Creates CrCl input values.
  const CrClInputs({
    required this.ageYears,
    required this.sex,
    required this.weightKg,
    required this.serumCreatinineMgDl,
  });

  /// Age in years.
  final int ageYears;

  /// Sex coefficient source.
  final Sex sex;

  /// Weight in kilograms.
  final double weightKg;

  /// Serum creatinine in mg/dL.
  final double serumCreatinineMgDl;

  /// Returns a copy with changed fields.
  CrClInputs copyWith({
    int? ageYears,
    Sex? sex,
    double? weightKg,
    double? serumCreatinineMgDl,
  }) {
    return CrClInputs(
      ageYears: ageYears ?? this.ageYears,
      sex: sex ?? this.sex,
      weightKg: weightKg ?? this.weightKg,
      serumCreatinineMgDl: serumCreatinineMgDl ?? this.serumCreatinineMgDl,
    );
  }

  /// Validates canonical CrCl input ranges.
  CrClValidation validate() {
    final errors = <String, String>{};
    if (CalcInputFieldSpecs.ageYears.isOutOfRange(ageYears)) {
      errors[CalcInputFieldSpecs.ageYears.fieldName] =
          CalcInputFieldSpecs.ageYears.rangeText;
    }
    if (CalcInputFieldSpecs.weightKg.isOutOfRange(weightKg)) {
      errors[CalcInputFieldSpecs.weightKg.fieldName] =
          CalcInputFieldSpecs.weightKg.rangeText;
    }
    if (CalcInputFieldSpecs.serumCreatinineMgDl.isOutOfRange(
      serumCreatinineMgDl,
    )) {
      errors[CalcInputFieldSpecs.serumCreatinineMgDl.fieldName] =
          CalcInputFieldSpecs.serumCreatinineMgDl.rangeText;
    }
    if (errors.isNotEmpty) {
      return CrClInvalid(errors: errors);
    }
    return const CrClValid();
  }

  @override
  bool operator ==(Object other) {
    return other is CrClInputs &&
        other.ageYears == ageYears &&
        other.sex == sex &&
        other.weightKg == weightKg &&
        other.serumCreatinineMgDl == serumCreatinineMgDl;
  }

  @override
  int get hashCode => Object.hash(
    ageYears,
    sex,
    weightKg,
    serumCreatinineMgDl,
  );
}

/// CrCl calculation result.
@immutable
final class CrClResult {
  /// Creates a CrCl result.
  const CrClResult({required this.crClMlMin});

  /// Creatinine clearance in mL/min.
  final double crClMlMin;

  /// Returns a copy with changed fields.
  CrClResult copyWith({double? crClMlMin}) {
    return CrClResult(crClMlMin: crClMlMin ?? this.crClMlMin);
  }

  @override
  bool operator ==(Object other) {
    return other is CrClResult && other.crClMlMin == crClMlMin;
  }

  @override
  int get hashCode => crClMlMin.hashCode;
}

/// CrCl validation result.
sealed class CrClValidation {
  const CrClValidation();
}

/// Valid CrCl inputs.
final class CrClValid extends CrClValidation {
  /// Creates a valid result.
  const CrClValid();
}

/// Invalid CrCl input.
final class CrClInvalid extends CrClValidation {
  /// Creates an invalid result.
  const CrClInvalid({required this.errors});

  /// Field-level accepted range labels.
  final Map<String, String> errors;

  /// Invalid field name.
  String get field => errors.keys.first;

  /// Accepted range label.
  String get range => errors[field]!;
}

/// Pure Cockcroft-Gault calculator.
abstract final class CrCl {
  /// Calculates Cockcroft-Gault creatinine clearance.
  static CrClResult calculate(CrClInputs inputs) {
    final sexCoefficient = inputs.sex == Sex.female ? 0.85 : 1.0;
    final value =
        (140 - inputs.ageYears) *
        inputs.weightKg /
        (72 * inputs.serumCreatinineMgDl) *
        sexCoefficient;
    return CrClResult(crClMlMin: value);
  }
}
