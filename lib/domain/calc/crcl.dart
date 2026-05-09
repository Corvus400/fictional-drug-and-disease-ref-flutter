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
    if (ageYears < 18 || ageYears > 120) {
      return const CrClInvalid(field: 'ageYears', range: '18-120 years');
    }
    if (weightKg < 1 || weightKg > 300) {
      return const CrClInvalid(field: 'weightKg', range: '1.0-300.0 kg');
    }
    if (serumCreatinineMgDl < 0.10 || serumCreatinineMgDl > 20) {
      return const CrClInvalid(
        field: 'serumCreatinineMgDl',
        range: '0.10-20.00 mg/dL',
      );
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
  const CrClInvalid({required this.field, required this.range});

  /// Invalid field name.
  final String field;

  /// Accepted range label.
  final String range;
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
