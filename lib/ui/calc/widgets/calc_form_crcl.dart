import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field_config.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';

/// CrCl form composite.
class CalcFormCrCl extends StatelessWidget {
  /// Creates a CrCl form.
  const CalcFormCrCl({
    required this.draft,
    required this.errors,
    required this.focusNodes,
    required this.onChanged,
    required this.onSexChanged,
    super.key,
  });

  /// Current draft inputs.
  final CalcInputDraft draft;

  /// Field errors.
  final Map<String, String> errors;

  /// Shared focus nodes keyed by input field.
  final Map<CalcInputFieldKey, FocusNode> focusNodes;

  /// Field change callback.
  final void Function(CalcInputFieldKey field, String value) onChanged;

  /// Sex change callback.
  final ValueChanged<Sex> onSexChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const ageSpec = CalcInputFieldSpecs.ageYears;
    const weightSpec = CalcInputFieldSpecs.weightKg;
    const creatinineSpec = CalcInputFieldSpecs.serumCreatinineMgDl;

    return Column(
      children: [
        CalcInputField(
          key: const ValueKey<String>('calc-input-ageYears'),
          label: l10n.calcInputAge,
          valueText: draft.valueOf(CalcInputFieldKey.ageYears),
          placeholder: ageSpec.placeholderText,
          unit: l10n.calcUnitYear,
          errorText: errors[ageSpec.fieldName],
          focusNode: focusNodes[CalcInputFieldKey.ageYears],
          keyboardType: calcKeyboardType(ageSpec),
          inputFormatters: calcInputFormatters(ageSpec),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              focusNodes[CalcInputFieldKey.weightKg]?.requestFocus(),
          onChanged: (value) => onChanged(CalcInputFieldKey.ageYears, value),
        ),
        const SizedBox(height: 12),
        CalcInputField(
          key: const ValueKey<String>('calc-input-weightKg'),
          label: l10n.calcInputWeight,
          valueText: draft.valueOf(CalcInputFieldKey.weightKg),
          placeholder: weightSpec.placeholderText,
          unit: l10n.calcUnitKg,
          errorText: errors[weightSpec.fieldName],
          focusNode: focusNodes[CalcInputFieldKey.weightKg],
          keyboardType: calcKeyboardType(weightSpec),
          inputFormatters: calcInputFormatters(weightSpec),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              focusNodes[CalcInputFieldKey.serumCreatinineMgDl]?.requestFocus(),
          onChanged: (value) => onChanged(CalcInputFieldKey.weightKg, value),
        ),
        const SizedBox(height: 12),
        CalcInputField(
          key: const ValueKey<String>('calc-input-serumCreatinineMgDl'),
          label: l10n.calcInputCreatinine,
          valueText: draft.valueOf(
            CalcInputFieldKey.serumCreatinineMgDl,
          ),
          placeholder: creatinineSpec.placeholderText,
          unit: l10n.calcUnitMgDl,
          errorText: errors[creatinineSpec.fieldName],
          focusNode: focusNodes[CalcInputFieldKey.serumCreatinineMgDl],
          keyboardType: calcKeyboardType(creatinineSpec),
          inputFormatters: calcInputFormatters(creatinineSpec),
          onFieldSubmitted: (_) =>
              focusNodes[CalcInputFieldKey.serumCreatinineMgDl]?.unfocus(),
          onChanged: (value) =>
              onChanged(CalcInputFieldKey.serumCreatinineMgDl, value),
        ),
        const SizedBox(height: 12),
        CalcSegmentedControl<Sex>.sex(
          selectedValue: draft.sex,
          onChanged: onSexChanged,
          items: [
            CalcSegmentedControlItem<Sex>(
              value: Sex.male,
              label: l10n.calcSexMale,
              leadingGlyph: '♂',
            ),
            CalcSegmentedControlItem<Sex>(
              value: Sex.female,
              label: l10n.calcSexFemale,
              leadingGlyph: '♀',
            ),
          ],
        ),
      ],
    );
  }
}
