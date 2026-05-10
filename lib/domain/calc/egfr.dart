import 'dart:math' as math;

import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:flutter/foundation.dart';

/// eGFR input values.
@immutable
final class EgfrInputs {
  /// Creates eGFR input values.
  const EgfrInputs({
    required this.ageYears,
    required this.sex,
    required this.serumCreatinineMgDl,
  });

  /// Age in years.
  final int ageYears;

  /// Sex coefficient source.
  final Sex sex;

  /// Serum creatinine in mg/dL.
  final double serumCreatinineMgDl;

  /// Returns a copy with changed fields.
  EgfrInputs copyWith({
    int? ageYears,
    Sex? sex,
    double? serumCreatinineMgDl,
  }) {
    return EgfrInputs(
      ageYears: ageYears ?? this.ageYears,
      sex: sex ?? this.sex,
      serumCreatinineMgDl: serumCreatinineMgDl ?? this.serumCreatinineMgDl,
    );
  }

  /// Validates canonical eGFR input ranges.
  EgfrValidation validate() {
    final errors = <String, String>{};
    if (ageYears < 18 || ageYears > 120) {
      errors['ageYears'] = '18-120 years';
    }
    if (serumCreatinineMgDl < 0.10 || serumCreatinineMgDl > 20) {
      errors['serumCreatinineMgDl'] = '0.10-20.00 mg/dL';
    }
    if (errors.isNotEmpty) {
      return EgfrInvalid(errors: errors);
    }
    return const EgfrValid();
  }

  @override
  bool operator ==(Object other) {
    return other is EgfrInputs &&
        other.ageYears == ageYears &&
        other.sex == sex &&
        other.serumCreatinineMgDl == serumCreatinineMgDl;
  }

  @override
  int get hashCode => Object.hash(ageYears, sex, serumCreatinineMgDl);
}

/// CKD stage.
enum CkdStage {
  /// G1, eGFR >= 90.
  g1('G1'),

  /// G2, 60 <= eGFR < 90.
  g2('G2'),

  /// G3a, 45 <= eGFR < 60.
  g3a('G3a'),

  /// G3b, 30 <= eGFR < 45.
  g3b('G3b'),

  /// G4, 15 <= eGFR < 30.
  g4('G4'),

  /// G5, eGFR < 15.
  g5('G5')
  ;

  const CkdStage(this.storageKey);

  /// Value stored in calculation history JSON.
  final String storageKey;

  /// Categorizes an eGFR value.
  static CkdStage categorize(double egfr) {
    if (egfr >= 90) {
      return g1;
    }
    if (egfr >= 60) {
      return g2;
    }
    if (egfr >= 45) {
      return g3a;
    }
    if (egfr >= 30) {
      return g3b;
    }
    if (egfr >= 15) {
      return g4;
    }
    return g5;
  }

  /// Parses a storage key.
  static CkdStage parse(String value) {
    for (final stage in values) {
      if (stage.storageKey == value) {
        return stage;
      }
    }
    throw FormatException('Unknown CKD stage: $value');
  }
}

/// eGFR calculation result.
@immutable
final class EgfrResult {
  /// Creates an eGFR result.
  const EgfrResult({required this.eGfrMlMin173m2, required this.stage});

  /// eGFR in mL/min/1.73m2.
  final double eGfrMlMin173m2;

  /// CKD stage.
  final CkdStage stage;

  /// Returns a copy with changed fields.
  EgfrResult copyWith({double? eGfrMlMin173m2, CkdStage? stage}) {
    return EgfrResult(
      eGfrMlMin173m2: eGfrMlMin173m2 ?? this.eGfrMlMin173m2,
      stage: stage ?? this.stage,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EgfrResult &&
        other.eGfrMlMin173m2 == eGfrMlMin173m2 &&
        other.stage == stage;
  }

  @override
  int get hashCode => Object.hash(eGfrMlMin173m2, stage);
}

/// eGFR validation result.
sealed class EgfrValidation {
  const EgfrValidation();
}

/// Valid eGFR inputs.
final class EgfrValid extends EgfrValidation {
  /// Creates a valid result.
  const EgfrValid();
}

/// Invalid eGFR input.
final class EgfrInvalid extends EgfrValidation {
  /// Creates an invalid result.
  const EgfrInvalid({required this.errors});

  /// Field-level accepted range labels.
  final Map<String, String> errors;

  /// Invalid field name.
  String get field => errors.keys.first;

  /// Accepted range label.
  String get range => errors[field]!;
}

/// Pure eGFR calculator.
abstract final class Egfr {
  /// Calculates Japanese coefficient eGFR and CKD stage.
  static EgfrResult calculate(EgfrInputs inputs) {
    final value =
        194 *
        math.pow(inputs.serumCreatinineMgDl, -1.094) *
        math.pow(inputs.ageYears, -0.287) *
        inputs.sex.egfrCoefficient;
    return EgfrResult(
      eGfrMlMin173m2: value,
      stage: CkdStage.categorize(value),
    );
  }
}
