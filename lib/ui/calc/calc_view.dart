import 'dart:async';

import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_category_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_form_bmi.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_form_crcl.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_form_egfr.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_empty_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/bmi_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/crcl_chart.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/charts/egfr_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'calc_responsive_layout.dart';
part 'calc_history_section.dart';

/// Calculation tools tab.
class CalcView extends ConsumerStatefulWidget {
  /// Creates a calculation tools view.
  const CalcView({
    @visibleForTesting this.debugRestoringHistory = false,
    @visibleForTesting this.debugRestoringProgressValue,
    super.key,
  });

  /// Forces the restoring state for deterministic visual tests.
  @visibleForTesting
  final bool debugRestoringHistory;

  /// Forces a deterministic progress arc for visual tests.
  @visibleForTesting
  final double? debugRestoringProgressValue;

  @override
  ConsumerState<CalcView> createState() => _CalcViewState();
}

class _CalcViewState extends ConsumerState<CalcView> {
  bool _restoringHistory = false;
  CalcInputFieldKey? _focusedField;
  late final Map<CalcInputFieldKey, FocusNode> _focusNodes = {
    for (final field in CalcInputFieldKey.values)
      field: FocusNode(debugLabel: 'calc-${field.name}'),
  };

  @override
  void initState() {
    super.initState();
    _restoringHistory = widget.debugRestoringHistory;
    for (final node in _focusNodes.values) {
      node.addListener(_syncFocusedField);
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes.values) {
      node
        ..removeListener(_syncFocusedField)
        ..dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final theme = Theme.of(context);
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
    final state = ref.watch(calcScreenProvider);
    final notifier = ref.read(calcScreenProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: isTablet ? 44 : 16,
        title: Text(
          l10n.calcAppBarTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: isTablet ? 26 : 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: palette.calcBg,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return IgnorePointer(
                  ignoring: _restoringHistory,
                  child: _CalcResponsiveBody(
                    mode: _CalcResponsiveMode.fromSize(constraints.biggest),
                    state: state,
                    restoringHistory: _restoringHistory,
                    restoringProgressValue: widget.debugRestoringProgressValue,
                    focusNodes: _focusNodes,
                    onToolChanged: notifier.selectTool,
                    onFieldChanged: notifier.updateField,
                    onSexChanged: notifier.updateSex,
                    onHistoryToggle: notifier.toggleHistory,
                    onHistoryRestore: _restoreFromHistory,
                    onHistoryDelete: notifier.deleteHistory,
                  ),
                );
              },
            ),
            if (_showsInputToolbar(context, state))
              _CalcInputToolbar(
                bottomInset: MediaQuery.viewInsetsOf(context).bottom,
                onNext: () => _focusNext(state.activeTool),
                onDone: _finishInput,
                showNext: _nextField(state.activeTool) != null,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _restoreFromHistory(CalculationHistoryEntry entry) async {
    setState(() => _restoringHistory = true);
    try {
      ref.read(calcScreenProvider.notifier).restoreFromHistory(entry);
    } finally {
      if (mounted) {
        setState(() => _restoringHistory = false);
      }
    }
  }

  bool _showsInputToolbar(BuildContext context, CalcScreenState state) {
    return Theme.of(context).platform == TargetPlatform.iOS &&
        _focusedField != null &&
        _fieldOrder(state.activeTool).contains(_focusedField);
  }

  void _syncFocusedField() {
    if (!mounted) {
      return;
    }
    CalcInputFieldKey? nextField;
    for (final entry in _focusNodes.entries) {
      if (entry.value.hasFocus) {
        nextField = entry.key;
        break;
      }
    }
    if (nextField == _focusedField) {
      return;
    }
    setState(() => _focusedField = nextField);
    if (nextField != null) {
      _ensureVisible(nextField);
    }
  }

  void _focusNext(CalcType calcType) {
    final nextField = _nextField(calcType);
    if (nextField == null) {
      _finishInput();
      return;
    }
    _focusNodes[nextField]?.requestFocus();
    _ensureVisible(nextField);
  }

  CalcInputFieldKey? _nextField(CalcType calcType) {
    final focusedField = _focusedField;
    if (focusedField == null) {
      return null;
    }
    final order = _fieldOrder(calcType);
    final index = order.indexOf(focusedField);
    if (index < 0 || index == order.length - 1) {
      return null;
    }
    return order[index + 1];
  }

  void _finishInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _ensureVisible(CalcInputFieldKey field) {
    if (MediaQuery.sizeOf(context).shortestSide >= 600) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final context = _focusNodes[field]?.context;
      if (context == null) {
        return;
      }
      unawaited(
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        ),
      );
    });
  }

  List<CalcInputFieldKey> _fieldOrder(CalcType calcType) {
    return switch (calcType) {
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
  }
}

class _CalcInputToolbar extends StatelessWidget {
  const _CalcInputToolbar({
    required this.bottomInset,
    required this.onNext,
    required this.onDone,
    required this.showNext,
  });

  final double bottomInset;
  final VoidCallback onNext;
  final VoidCallback onDone;
  final bool showNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomInset,
      child: SafeArea(
        top: false,
        child: Material(
          key: const ValueKey<String>('calc-input-toolbar'),
          color: palette.calcSurface,
          elevation: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: palette.calcHairline)),
            ),
            child: SizedBox(
              height: 44,
              child: Row(
                children: [
                  const Spacer(),
                  TextButton(
                    key: const ValueKey<String>('calc-input-toolbar-next'),
                    onPressed: showNext ? onNext : null,
                    child: Text(
                      l10n.calcKeyboardNext,
                      style: typography.labelM.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    key: const ValueKey<String>('calc-input-toolbar-done'),
                    onPressed: onDone,
                    child: Text(
                      l10n.calcKeyboardDone,
                      style: typography.labelM.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CalcForm extends StatelessWidget {
  const _CalcForm({
    required this.state,
    required this.focusNodes,
    required this.onChanged,
    required this.onSexChanged,
  });

  final CalcScreenState state;
  final Map<CalcInputFieldKey, FocusNode> focusNodes;
  final void Function(CalcInputFieldKey field, String value) onChanged;
  final ValueChanged<Sex> onSexChanged;

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    final errors = _errors;
    return switch (state.activeTool) {
      CalcType.bmi => CalcFormBmi(
        draft: draft,
        errors: errors,
        focusNodes: focusNodes,
        onChanged: onChanged,
      ),
      CalcType.egfr => CalcFormEgfr(
        draft: draft,
        errors: errors,
        focusNodes: focusNodes,
        onChanged: onChanged,
        onSexChanged: onSexChanged,
      ),
      CalcType.crcl => CalcFormCrCl(
        draft: draft,
        errors: errors,
        focusNodes: focusNodes,
        onChanged: onChanged,
        onSexChanged: onSexChanged,
      ),
    };
  }

  CalcInputDraft get _draft {
    return switch (state.phase) {
      CalcPhaseEmpty(:final partialInputs) => partialInputs,
      CalcPhasePartialInput(:final partialInputs) => partialInputs,
      CalcPhaseOutOfRange(:final inputs) when inputs is CalcInputDraft =>
        inputs,
      CalcPhaseValidInput(:final inputs) => _draftFromTyped(inputs),
      CalcPhaseResultWithClassification(:final inputs) => _draftFromTyped(
        inputs,
      ),
      _ => const CalcInputDraft(),
    };
  }

  Map<String, String> get _errors {
    return switch (state.phase) {
      CalcPhaseOutOfRange(:final errors) => errors,
      _ => const <String, String>{},
    };
  }

  CalcInputDraft _draftFromTyped(Object inputs) {
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
}

class _CalcResult extends StatelessWidget {
  const _CalcResult({
    required this.state,
    required this.restoringHistory,
    required this.restoringProgressValue,
  });

  final CalcScreenState state;
  final bool restoringHistory;
  final double? restoringProgressValue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final phase = state.phase;
    final value = _valueText(phase);
    final placeholder =
        phase is CalcPhaseEmpty ||
        phase is CalcPhasePartialInput ||
        phase is CalcPhaseOutOfRange;

    return CalcResultCard(
      title: l10n.calcResultTitle,
      formula: _formula(l10n, state.activeTool),
      valueText: value,
      unit: _unit(l10n, state.activeTool),
      placeholder: placeholder,
      hintText: placeholder ? l10n.calcResultHint : null,
      badges: _badges(context, phase),
      visualization: _visualization(phase),
      restoringMessage: restoringHistory ? l10n.calcHistoryRestoring : null,
      restoringProgressValue: restoringProgressValue,
    );
  }

  String _formula(AppLocalizations l10n, CalcType calcType) {
    return switch (calcType) {
      CalcType.bmi => l10n.calcFormulaBmi,
      CalcType.egfr => l10n.calcFormulaEgfr,
      CalcType.crcl => l10n.calcFormulaCrcl,
    };
  }

  String _unit(AppLocalizations l10n, CalcType calcType) {
    return switch (calcType) {
      CalcType.bmi => l10n.calcResultBmiUnit,
      CalcType.egfr => l10n.calcResultEgfrUnit,
      CalcType.crcl => l10n.calcResultCrclUnit,
    };
  }

  String _valueText(CalcPhase phase) {
    return switch (phase) {
      CalcPhaseResultWithClassification(:final result) => switch (result) {
        BmiResult(:final bmi) => _formatFixed(bmi, 1),
        EgfrResult(:final eGfrMlMin173m2) => _formatFixed(
          eGfrMlMin173m2,
          1,
        ),
        _ => '--',
      },
      CalcPhaseValidInput(:final result) => switch (result) {
        CrClResult(:final crClMlMin) => _formatFixed(crClMlMin, 1),
        _ => '--',
      },
      _ => '--',
    };
  }

  List<Widget> _badges(BuildContext context, CalcPhase phase) {
    final l10n = AppLocalizations.of(context)!;
    return switch (phase) {
      CalcPhaseResultWithClassification(:final category)
          when category is BmiCategory =>
        [
          CalcCategoryBadge.bmi(
            category: category,
            label: _bmiCategoryLabel(l10n, category),
          ),
        ],
      CalcPhaseResultWithClassification(:final category)
          when category is CkdStage =>
        [
          CalcCategoryBadge.ckd(
            stage: category,
            label: _ckdStageLabel(l10n, category),
          ),
        ],
      _ => const [],
    };
  }

  Widget? _visualization(CalcPhase phase) {
    return switch (phase) {
      CalcPhaseResultWithClassification(:final result) => switch (result) {
        BmiResult(:final bmi) => BmiChart(
          value: bmi,
          label: _formatFixed(bmi, 1),
        ),
        EgfrResult(:final eGfrMlMin173m2) => EgfrChart(
          value: eGfrMlMin173m2,
          label: _formatFixed(eGfrMlMin173m2, 1),
        ),
        _ => null,
      },
      CalcPhaseValidInput(:final result) => switch (result) {
        CrClResult(:final crClMlMin) => CrClChart(value: crClMlMin),
        _ => null,
      },
      _ => null,
    };
  }
}

String _bmiCategoryLabel(AppLocalizations l10n, BmiCategory category) {
  return switch (category) {
    BmiCategory.underweight => l10n.calcBmiCategoryUnderweight,
    BmiCategory.normal => l10n.calcBmiCategoryNormal,
    BmiCategory.overweight => l10n.calcBmiCategoryOverweight,
    BmiCategory.obese1 => l10n.calcBmiCategoryObese1,
    BmiCategory.obese2 => l10n.calcBmiCategoryObese2,
    BmiCategory.obese3 => l10n.calcBmiCategoryObese3,
    BmiCategory.obese4 => l10n.calcBmiCategoryObese4,
  };
}

String _ckdStageLabel(AppLocalizations l10n, CkdStage stage) {
  return switch (stage) {
    CkdStage.g1 => l10n.calcCkdStageG1,
    CkdStage.g2 => l10n.calcCkdStageG2,
    CkdStage.g3a => l10n.calcCkdStageG3a,
    CkdStage.g3b => l10n.calcCkdStageG3b,
    CkdStage.g4 => l10n.calcCkdStageG4,
    CkdStage.g5 => l10n.calcCkdStageG5,
  };
}

String _formatNumber(double value) {
  final asInt = value.toInt();
  if (value == asInt) {
    return asInt.toString();
  }
  return value.toString();
}

String _formatFixed(double value, int fractionDigits) {
  return value.toStringAsFixed(fractionDigits);
}
