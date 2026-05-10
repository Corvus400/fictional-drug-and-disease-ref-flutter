import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:flutter/foundation.dart';

/// Input field keys used by the calculation screen state machine.
enum CalcInputFieldKey {
  /// Height in centimeters.
  heightCm,

  /// Weight in kilograms.
  weightKg,

  /// Age in years.
  ageYears,

  /// Serum creatinine in mg/dL.
  serumCreatinineMgDl,
}

/// Draft input values before they become typed domain inputs.
@immutable
final class CalcInputDraft {
  /// Creates draft input values.
  const CalcInputDraft({
    this.values = const <CalcInputFieldKey, String>{},
    this.sex = Sex.male,
  });

  /// Raw field text values.
  final Map<CalcInputFieldKey, String> values;

  /// Selected sex for eGFR and CrCl.
  final Sex sex;

  /// Returns the raw value for [field].
  String valueOf(CalcInputFieldKey field) => values[field] ?? '';

  /// Copies draft with one changed field.
  CalcInputDraft copyWithField(CalcInputFieldKey field, String value) {
    return CalcInputDraft(values: {...values, field: value}, sex: sex);
  }

  /// Copies draft with changed sex.
  CalcInputDraft copyWithSex(Sex value) {
    return CalcInputDraft(values: values, sex: value);
  }

  @override
  bool operator ==(Object other) {
    return other is CalcInputDraft &&
        mapEquals(other.values, values) &&
        other.sex == sex;
  }

  @override
  int get hashCode => Object.hash(Object.hashAll(values.entries), sex);
}

/// Calculation phase for the visible screen.
sealed class CalcPhase {
  const CalcPhase();

  /// Empty input phase.
  const factory CalcPhase.empty(
    CalcType calcType, [
    CalcInputDraft partialInputs,
  ]) = CalcPhaseEmpty;

  /// Partial input phase.
  const factory CalcPhase.partialInput(
    CalcType calcType,
    CalcInputDraft partialInputs,
  ) = CalcPhasePartialInput;

  /// Valid input phase before classification rendering.
  const factory CalcPhase.validInput(
    CalcType calcType,
    Object inputs,
    Object result,
  ) = CalcPhaseValidInput;

  /// Input exists but is outside accepted ranges.
  const factory CalcPhase.outOfRange(
    CalcType calcType,
    Object inputs, {
    required Map<String, String> errors,
  }) = CalcPhaseOutOfRange;

  /// Result phase with BMI or eGFR classification.
  const factory CalcPhase.resultWithClassification(
    CalcType calcType,
    Object inputs,
    Object result,
    Object category,
  ) = CalcPhaseResultWithClassification;
}

/// Empty input phase.
@immutable
final class CalcPhaseEmpty extends CalcPhase {
  /// Creates an empty input phase.
  const CalcPhaseEmpty(
    this.calcType, [
    this.partialInputs = const CalcInputDraft(),
  ]);

  /// Active calculation type.
  final CalcType calcType;

  /// Draft inputs.
  final CalcInputDraft partialInputs;

  @override
  bool operator ==(Object other) {
    return other is CalcPhaseEmpty &&
        other.calcType == calcType &&
        other.partialInputs == partialInputs;
  }

  @override
  int get hashCode => Object.hash(calcType, partialInputs);
}

/// Partial input phase.
@immutable
final class CalcPhasePartialInput extends CalcPhase {
  /// Creates a partial input phase.
  const CalcPhasePartialInput(this.calcType, this.partialInputs);

  /// Active calculation type.
  final CalcType calcType;

  /// Draft inputs.
  final CalcInputDraft partialInputs;

  @override
  bool operator ==(Object other) {
    return other is CalcPhasePartialInput &&
        other.calcType == calcType &&
        other.partialInputs == partialInputs;
  }

  @override
  int get hashCode => Object.hash(calcType, partialInputs);
}

/// Valid input phase.
@immutable
final class CalcPhaseValidInput extends CalcPhase {
  /// Creates a valid input phase.
  const CalcPhaseValidInput(this.calcType, this.inputs, this.result);

  /// Active calculation type.
  final CalcType calcType;

  /// Typed domain inputs.
  final Object inputs;

  /// Typed calculation result.
  final Object result;

  @override
  bool operator ==(Object other) {
    return other is CalcPhaseValidInput &&
        other.calcType == calcType &&
        other.inputs == inputs &&
        other.result == result;
  }

  @override
  int get hashCode => Object.hash(calcType, inputs, result);
}

/// Out-of-range input phase.
@immutable
final class CalcPhaseOutOfRange extends CalcPhase {
  /// Creates an out-of-range phase.
  const CalcPhaseOutOfRange(
    this.calcType,
    this.inputs, {
    required this.errors,
  });

  /// Active calculation type.
  final CalcType calcType;

  /// Draft or typed inputs that produced the error.
  final Object inputs;

  /// Field-level error messages keyed by domain field name.
  final Map<String, String> errors;

  @override
  bool operator ==(Object other) {
    return other is CalcPhaseOutOfRange &&
        other.calcType == calcType &&
        other.inputs == inputs &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode =>
      Object.hash(calcType, inputs, Object.hashAll(errors.entries));
}

/// Classified result phase.
@immutable
final class CalcPhaseResultWithClassification extends CalcPhase {
  /// Creates a classified result phase.
  const CalcPhaseResultWithClassification(
    this.calcType,
    this.inputs,
    this.result,
    this.category,
  );

  /// Active calculation type.
  final CalcType calcType;

  /// Typed domain inputs.
  final Object inputs;

  /// Typed calculation result.
  final Object result;

  /// BMI category or CKD stage.
  final Object category;

  @override
  bool operator ==(Object other) {
    return other is CalcPhaseResultWithClassification &&
        other.calcType == calcType &&
        other.inputs == inputs &&
        other.result == result &&
        other.category == category;
  }

  @override
  int get hashCode => Object.hash(calcType, inputs, result, category);
}

/// Calculation history loading phase.
enum CalcHistoryPhase {
  /// History is loading.
  loading,

  /// History has no rows.
  empty,

  /// History rows are loaded.
  loaded,

  /// History operation failed.
  error,
}

/// Calc screen state.
@immutable
final class CalcScreenState {
  /// Creates calc screen state.
  const CalcScreenState({
    required this.activeTool,
    required this.phase,
    required this.historyExpanded,
    required this.history,
    required this.historyPhase,
  });

  /// Initial state.
  factory CalcScreenState.initial() => const CalcScreenState(
    activeTool: CalcType.bmi,
    phase: CalcPhase.empty(CalcType.bmi),
    historyExpanded: false,
    history: <CalculationHistoryEntry>[],
    historyPhase: CalcHistoryPhase.loading,
  );

  /// Active calculation tool.
  final CalcType activeTool;

  /// Current input/result phase.
  final CalcPhase phase;

  /// Whether history section is expanded.
  final bool historyExpanded;

  /// Current history rows for [activeTool].
  final List<CalculationHistoryEntry> history;

  /// History loading phase.
  final CalcHistoryPhase historyPhase;

  /// Copies state.
  CalcScreenState copyWith({
    CalcType? activeTool,
    CalcPhase? phase,
    bool? historyExpanded,
    List<CalculationHistoryEntry>? history,
    CalcHistoryPhase? historyPhase,
  }) {
    return CalcScreenState(
      activeTool: activeTool ?? this.activeTool,
      phase: phase ?? this.phase,
      historyExpanded: historyExpanded ?? this.historyExpanded,
      history: history ?? this.history,
      historyPhase: historyPhase ?? this.historyPhase,
    );
  }
}
