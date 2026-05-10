import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_bmi_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_crcl_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/calculate_egfr_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Calc screen notifier provider.
final calcScreenProvider =
    NotifierProvider<CalcScreenNotifier, CalcScreenState>(
      CalcScreenNotifier.new,
    );

/// ViewModel for the calculation tools screen.
final class CalcScreenNotifier extends Notifier<CalcScreenState> {
  static const _inputsCodec = CalculationInputsCodec();
  static const _resultCodec = CalculationResultCodec();

  Timer? _recordDebounce;

  @override
  CalcScreenState build() {
    ref.onDispose(() => _recordDebounce?.cancel());
    final initial = CalcScreenState.initial();
    unawaited(Future<void>.microtask(loadHistory));
    return initial;
  }

  /// Loads history rows for the active tool.
  Future<void> loadHistory() async {
    final result = await ref
        .read(listCalculationHistoryUsecaseProvider)
        .execute(state.activeTool);
    state = switch (result) {
      ListCalculationHistorySuccess(:final entries) => state.copyWith(
        history: entries,
        historyPhase: CalcHistoryPhase.loaded,
      ),
      ListCalculationHistoryEmpty() => state.copyWith(
        history: const <CalculationHistoryEntry>[],
        historyPhase: CalcHistoryPhase.empty,
      ),
      ListCalculationHistoryFailure() => state.copyWith(
        historyPhase: CalcHistoryPhase.error,
      ),
    };
  }

  /// Selects a calculation tool and resets draft/result state.
  Future<void> selectTool(CalcType calcType) async {
    state = state.copyWith(
      activeTool: calcType,
      phase: CalcPhase.empty(calcType),
      history: const <CalculationHistoryEntry>[],
      historyPhase: CalcHistoryPhase.loading,
    );
    await loadHistory();
  }

  /// Toggles history expansion.
  void toggleHistory() {
    state = state.copyWith(historyExpanded: !state.historyExpanded);
  }

  /// Restores inputs from a history entry.
  void restoreFromHistory(CalculationHistoryEntry entry) {
    try {
      final calcType = CalcType.parse(entry.calcType);
      final inputs = _inputsCodec.decode(calcType, entry.inputsJson);
      final result = _resultCodec.decode(calcType, entry.resultJson);
      state = state.copyWith(
        activeTool: calcType,
        phase: _phaseFromTyped(calcType, inputs, result),
      );
    } on Object {
      state = state.copyWith(historyPhase: CalcHistoryPhase.error);
    }
  }

  /// Deletes a history entry.
  Future<void> deleteHistory(String id) async {
    final result = await ref
        .read(deleteCalculationHistoryUsecaseProvider)
        .execute(id);
    if (result is DeleteCalculationHistoryFailure) {
      state = state.copyWith(historyPhase: CalcHistoryPhase.error);
      return;
    }
    await loadHistory();
  }

  /// Updates one input field.
  void updateField(CalcInputFieldKey field, String value) {
    final draft = _currentDraft().copyWithField(field, value);
    state = state.copyWith(phase: _phaseForDraft(state.activeTool, draft));
  }

  /// Updates sex selection for renal formulas.
  void updateSex(Sex sex) {
    final draft = _currentDraft().copyWithSex(sex);
    state = state.copyWith(phase: _phaseForDraft(state.activeTool, draft));
  }

  CalcInputDraft _currentDraft() {
    return switch (state.phase) {
      CalcPhaseEmpty(:final partialInputs) => partialInputs,
      CalcPhasePartialInput(:final partialInputs) => partialInputs,
      CalcPhaseValidInput(:final inputs) => _draftFromInputs(inputs),
      CalcPhaseResultWithClassification(:final inputs) => _draftFromInputs(
        inputs,
      ),
      _ => const CalcInputDraft(),
    };
  }

  CalcInputDraft _draftFromInputs(Object inputs) {
    return switch (inputs) {
      BmiInputs(:final heightCm, :final weightKg) => CalcInputDraft(
        values: {
          CalcInputFieldKey.heightCm: _formatNumber(heightCm),
          CalcInputFieldKey.weightKg: _formatNumber(weightKg),
        },
      ),
      EgfrInputs(
        :final ageYears,
        :final sex,
        :final serumCreatinineMgDl,
      ) =>
        CalcInputDraft(
          values: {
            CalcInputFieldKey.ageYears: ageYears.toString(),
            CalcInputFieldKey.serumCreatinineMgDl: _formatNumber(
              serumCreatinineMgDl,
            ),
          },
          sex: sex,
        ),
      CrClInputs(
        :final ageYears,
        :final sex,
        :final weightKg,
        :final serumCreatinineMgDl,
      ) =>
        CalcInputDraft(
          values: {
            CalcInputFieldKey.ageYears: ageYears.toString(),
            CalcInputFieldKey.weightKg: _formatNumber(weightKg),
            CalcInputFieldKey.serumCreatinineMgDl: _formatNumber(
              serumCreatinineMgDl,
            ),
          },
          sex: sex,
        ),
      _ => const CalcInputDraft(),
    };
  }

  String _formatNumber(double value) {
    final asInt = value.toInt();
    if (value == asInt) {
      return asInt.toString();
    }
    return value.toString();
  }

  CalcPhase _phaseForDraft(CalcType calcType, CalcInputDraft draft) {
    final requiredFields = switch (calcType) {
      CalcType.bmi => const [
        CalcInputFieldKey.heightCm,
        CalcInputFieldKey.weightKg,
      ],
      CalcType.egfr => const [
        CalcInputFieldKey.ageYears,
        CalcInputFieldKey.serumCreatinineMgDl,
      ],
      CalcType.crcl => const [
        CalcInputFieldKey.ageYears,
        CalcInputFieldKey.weightKg,
        CalcInputFieldKey.serumCreatinineMgDl,
      ],
    };
    final hasAnyInput = requiredFields.any(
      (field) => draft.valueOf(field).trim().isNotEmpty,
    );
    if (!hasAnyInput) {
      return CalcPhase.empty(calcType, draft);
    }
    final hasAllInputs = requiredFields.every(
      (field) => draft.valueOf(field).trim().isNotEmpty,
    );
    if (!hasAllInputs) {
      return CalcPhase.partialInput(calcType, draft);
    }
    if (calcType == CalcType.bmi) {
      return _bmiPhase(draft);
    }
    if (calcType == CalcType.egfr) {
      return _egfrPhase(draft);
    }
    return _crClPhase(draft);
  }

  CalcPhase _bmiPhase(CalcInputDraft draft) {
    final heightCm = double.tryParse(draft.valueOf(CalcInputFieldKey.heightCm));
    final weightKg = double.tryParse(draft.valueOf(CalcInputFieldKey.weightKg));
    if (heightCm == null || weightKg == null) {
      return CalcPhase.partialInput(CalcType.bmi, draft);
    }
    final inputs = BmiInputs(heightCm: heightCm, weightKg: weightKg);
    return switch (ref.read(calculateBmiUsecaseProvider).execute(inputs)) {
      CalculateBmiSuccess(:final result) => _classifiedBmi(inputs, result),
      CalculateBmiInvalid(:final field, :final range) => CalcPhase.outOfRange(
        CalcType.bmi,
        draft,
        errors: {field: range},
      ),
    };
  }

  CalcPhase _classifiedBmi(BmiInputs inputs, BmiResult result) {
    _scheduleRecord(CalcType.bmi, inputs, result);
    return CalcPhase.resultWithClassification(
      CalcType.bmi,
      inputs,
      result,
      result.category,
    );
  }

  CalcPhase _egfrPhase(CalcInputDraft draft) {
    final ageYears = int.tryParse(draft.valueOf(CalcInputFieldKey.ageYears));
    final serumCreatinineMgDl = double.tryParse(
      draft.valueOf(CalcInputFieldKey.serumCreatinineMgDl),
    );
    if (ageYears == null || serumCreatinineMgDl == null) {
      return CalcPhase.partialInput(CalcType.egfr, draft);
    }
    final inputs = EgfrInputs(
      ageYears: ageYears,
      sex: draft.sex,
      serumCreatinineMgDl: serumCreatinineMgDl,
    );
    return switch (ref.read(calculateEgfrUsecaseProvider).execute(inputs)) {
      CalculateEgfrSuccess(:final result) => _classifiedEgfr(inputs, result),
      CalculateEgfrInvalid(:final field, :final range) => CalcPhase.outOfRange(
        CalcType.egfr,
        draft,
        errors: {field: range},
      ),
    };
  }

  CalcPhase _classifiedEgfr(EgfrInputs inputs, EgfrResult result) {
    _scheduleRecord(CalcType.egfr, inputs, result);
    return CalcPhase.resultWithClassification(
      CalcType.egfr,
      inputs,
      result,
      result.stage,
    );
  }

  CalcPhase _crClPhase(CalcInputDraft draft) {
    final ageYears = int.tryParse(draft.valueOf(CalcInputFieldKey.ageYears));
    final weightKg = double.tryParse(draft.valueOf(CalcInputFieldKey.weightKg));
    final serumCreatinineMgDl = double.tryParse(
      draft.valueOf(CalcInputFieldKey.serumCreatinineMgDl),
    );
    if (ageYears == null || weightKg == null || serumCreatinineMgDl == null) {
      return CalcPhase.partialInput(CalcType.crcl, draft);
    }
    final inputs = CrClInputs(
      ageYears: ageYears,
      sex: draft.sex,
      weightKg: weightKg,
      serumCreatinineMgDl: serumCreatinineMgDl,
    );
    return switch (ref.read(calculateCrClUsecaseProvider).execute(inputs)) {
      CalculateCrClSuccess(:final result) => _validCrCl(inputs, result),
      CalculateCrClInvalid(:final field, :final range) => CalcPhase.outOfRange(
        CalcType.crcl,
        draft,
        errors: {field: range},
      ),
    };
  }

  CalcPhase _validCrCl(CrClInputs inputs, CrClResult result) {
    _scheduleRecord(CalcType.crcl, inputs, result);
    return CalcPhase.validInput(CalcType.crcl, inputs, result);
  }

  CalcPhase _phaseFromTyped(CalcType calcType, Object inputs, Object result) {
    return switch ((calcType, result)) {
      (CalcType.bmi, BmiResult(:final category)) =>
        CalcPhase.resultWithClassification(calcType, inputs, result, category),
      (CalcType.egfr, EgfrResult(:final stage)) =>
        CalcPhase.resultWithClassification(calcType, inputs, result, stage),
      (CalcType.crcl, CrClResult()) => CalcPhase.validInput(
        calcType,
        inputs,
        result,
      ),
      _ => CalcPhase.empty(calcType),
    };
  }

  void _scheduleRecord(CalcType calcType, Object inputs, Object result) {
    _recordDebounce?.cancel();
    _recordDebounce = Timer(const Duration(milliseconds: 200), () async {
      await ref
          .read(recordCalculationHistoryUsecaseProvider)
          .execute(calcType, inputs, result);
      await loadHistory();
    });
  }
}
