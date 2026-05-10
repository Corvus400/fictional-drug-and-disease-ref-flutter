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
import 'package:material_symbols_icons/symbols.dart';

/// Calculation tools tab.
class CalcView extends ConsumerStatefulWidget {
  /// Creates a calculation tools view.
  const CalcView({super.key});

  @override
  ConsumerState<CalcView> createState() => _CalcViewState();
}

class _CalcViewState extends ConsumerState<CalcView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final state = ref.watch(calcScreenProvider);
    final notifier = ref.read(calcScreenProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Symbols.menu),
          onPressed: () {},
        ),
        title: Text(l10n.calcAppBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Symbols.history),
            tooltip: l10n.calcActionHistory,
            onPressed: notifier.toggleHistory,
          ),
        ],
      ),
      backgroundColor: palette.calcBg,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.fromLTRB(
                spacing.s4,
                spacing.s5,
                spacing.s4,
                110,
              ),
              children: [
                _CalcForm(
                  state: state,
                  onChanged: notifier.updateField,
                  onSexChanged: notifier.updateSex,
                ),
                SizedBox(height: spacing.s4),
                _CalcResult(state: state),
                SizedBox(height: spacing.s4),
                _CalcHistorySection(
                  state: state,
                  onToggle: notifier.toggleHistory,
                  onRestore: notifier.restoreFromHistory,
                  onDelete: notifier.deleteHistory,
                ),
              ],
            ),
            Positioned(
              left: spacing.s4,
              right: spacing.s4,
              bottom: spacing.s4,
              child: CalcSegmentedControl<CalcType>.tool(
                selectedValue: state.activeTool,
                onChanged: notifier.selectTool,
                items: [
                  CalcSegmentedControlItem<CalcType>(
                    value: CalcType.bmi,
                    label: l10n.calcToolBmi,
                  ),
                  CalcSegmentedControlItem<CalcType>(
                    value: CalcType.egfr,
                    label: l10n.calcToolEgfr,
                  ),
                  CalcSegmentedControlItem<CalcType>(
                    value: CalcType.crcl,
                    label: l10n.calcToolCrcl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalcForm extends StatelessWidget {
  const _CalcForm({
    required this.state,
    required this.onChanged,
    required this.onSexChanged,
  });

  final CalcScreenState state;
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
        onChanged: onChanged,
      ),
      CalcType.egfr => CalcFormEgfr(
        draft: draft,
        errors: errors,
        onChanged: onChanged,
        onSexChanged: onSexChanged,
      ),
      CalcType.crcl => CalcFormCrCl(
        draft: draft,
        errors: errors,
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
  const _CalcResult({required this.state});

  final CalcScreenState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final phase = state.phase;
    final value = _valueText(phase);
    final placeholder =
        phase is CalcPhaseEmpty || phase is CalcPhasePartialInput;

    return CalcResultCard(
      title: l10n.calcResultTitle,
      formula: _formula(l10n, state.activeTool),
      valueText: value,
      unit: _unit(l10n, state.activeTool),
      placeholder: placeholder,
      hintText: placeholder ? l10n.calcResultHint : null,
      badges: _badges(context, phase),
      visualization: _visualization(phase),
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

class _CalcHistorySection extends StatelessWidget {
  const _CalcHistorySection({
    required this.state,
    required this.onToggle,
    required this.onRestore,
    required this.onDelete,
  });

  static const _inputsCodec = CalculationInputsCodec();
  static const _resultCodec = CalculationResultCodec();

  final CalcScreenState state;
  final VoidCallback onToggle;
  final ValueChanged<CalculationHistoryEntry> onRestore;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final isEmpty =
        state.historyPhase == CalcHistoryPhase.empty || state.history.isEmpty;
    final showBody = state.historyExpanded || isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _CalcHistoryHeader(
          count: state.history.length,
          expanded: showBody,
          onToggle: isEmpty ? null : onToggle,
        ),
        if (showBody) ...[
          SizedBox(height: spacing.s2 - 2),
          if (isEmpty)
            CalcHistoryEmptyState(message: l10n.calcHistoryEmpty)
          else
            _CalcHistoryList(
              rows: [
                for (final indexed in state.history.indexed)
                  _CalcHistoryRowData.fromEntry(
                    entry: indexed.$2,
                    l10n: l10n,
                    inputsCodec: _inputsCodec,
                    resultCodec: _resultCodec,
                    showBottomBorder: indexed.$1 != state.history.length - 1,
                  ),
              ],
              onRestore: onRestore,
              onDelete: onDelete,
            ),
        ],
      ],
    );
  }
}

class _CalcHistoryHeader extends StatelessWidget {
  const _CalcHistoryHeader({
    required this.count,
    required this.expanded,
    required this.onToggle,
  });

  final int count;
  final bool expanded;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radii.card),
        onTap: onToggle,
        child: Ink(
          decoration: BoxDecoration(
            color: palette.calcSurface,
            border: Border.all(color: palette.calcHairline),
            borderRadius: BorderRadius.circular(radii.card),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.s3,
              vertical: spacing.s2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.calcHistoryHeader} ($count)',
                    style: typography.labelM.copyWith(
                      color: palette.calcInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  key: const ValueKey<String>('calc-history-header-icon'),
                  count == 0
                      ? Symbols.history_toggle_off
                      : expanded
                      ? Symbols.expand_less
                      : Symbols.expand_more,
                  size: 18,
                  color: count == 0 ? palette.calcMuted2 : palette.calcMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CalcHistoryList extends StatelessWidget {
  const _CalcHistoryList({
    required this.rows,
    required this.onRestore,
    required this.onDelete,
  });

  final List<_CalcHistoryRowData> rows;
  final ValueChanged<CalculationHistoryEntry> onRestore;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final showScrollHint = rows.length > 5;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcSurface,
        border: Border.all(color: palette.calcHairline),
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radii.card),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 220),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    for (final row in rows)
                      CalcHistoryRow(
                        key: ValueKey<String>('calc-history-${row.entry.id}'),
                        dateText: row.dateText,
                        resultText: row.resultText,
                        summaryText: row.summaryText,
                        showBottomBorder: row.showBottomBorder,
                        onRestore: () => onRestore(row.entry),
                        onDelete: () => onDelete(row.entry.id),
                      ),
                  ],
                ),
              ),
              if (showScrollHint)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 18,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            palette.calcSurface.withValues(alpha: 0),
                            palette.calcSurface,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalcHistoryRowData {
  const _CalcHistoryRowData({
    required this.entry,
    required this.dateText,
    required this.resultText,
    required this.summaryText,
    required this.showBottomBorder,
  });

  factory _CalcHistoryRowData.fromEntry({
    required CalculationHistoryEntry entry,
    required AppLocalizations l10n,
    required CalculationInputsCodec inputsCodec,
    required CalculationResultCodec resultCodec,
    required bool showBottomBorder,
  }) {
    try {
      final calcType = CalcType.parse(entry.calcType);
      final inputs = inputsCodec.decode(calcType, entry.inputsJson);
      final result = resultCodec.decode(calcType, entry.resultJson);
      return _CalcHistoryRowData(
        entry: entry,
        dateText: _formatDate(entry.calculatedAt),
        resultText: _historyResultText(l10n, calcType, result),
        summaryText: _historySummaryText(l10n, inputs),
        showBottomBorder: showBottomBorder,
      );
    } on Object {
      return _CalcHistoryRowData(
        entry: entry,
        dateText: _formatDate(entry.calculatedAt),
        resultText: entry.calcType,
        summaryText: '--',
        showBottomBorder: showBottomBorder,
      );
    }
  }

  final CalculationHistoryEntry entry;
  final String dateText;
  final String resultText;
  final String summaryText;
  final bool showBottomBorder;
}

String _historyResultText(
  AppLocalizations l10n,
  CalcType calcType,
  Object result,
) {
  return switch ((calcType, result)) {
    (CalcType.bmi, BmiResult(:final bmi, :final category)) =>
      'BMI ${_formatFixed(bmi, 1)} (${_bmiCategoryLabel(l10n, category)})',
    (CalcType.egfr, EgfrResult(:final eGfrMlMin173m2, :final stage)) => [
      'eGFR ${_formatFixed(eGfrMlMin173m2, 1)}',
      '(${_ckdStageLabel(l10n, stage)})',
    ].join(' '),
    (CalcType.crcl, CrClResult(:final crClMlMin)) =>
      'CrCl ${_formatFixed(crClMlMin, 1)}',
    _ => '--',
  };
}

String _historySummaryText(AppLocalizations l10n, Object inputs) {
  return switch (inputs) {
    BmiInputs(:final heightCm, :final weightKg) =>
      'H${_formatNumber(heightCm)}/W${_formatNumber(weightKg)}',
    EgfrInputs(:final ageYears, :final sex, :final serumCreatinineMgDl) =>
      '$ageYears歳/${_sexLabel(l10n, sex)}/Cr${_formatNumber(serumCreatinineMgDl)}',
    CrClInputs(
      :final ageYears,
      :final sex,
      :final weightKg,
      :final serumCreatinineMgDl,
    ) =>
      '$ageYears歳/${_sexLabel(l10n, sex)}/W${_formatNumber(weightKg)}/Cr${_formatNumber(serumCreatinineMgDl)}',
    _ => '--',
  };
}

String _sexLabel(AppLocalizations l10n, Sex sex) {
  return switch (sex) {
    Sex.male => l10n.calcSexMale,
    Sex.female => l10n.calcSexFemale,
  };
}

String _formatDate(DateTime value) {
  final local = value.toLocal();
  return [
    local.year.toString().padLeft(4, '0'),
    local.month.toString().padLeft(2, '0'),
    local.day.toString().padLeft(2, '0'),
  ].join('/');
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
