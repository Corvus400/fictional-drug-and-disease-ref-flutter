import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// eGFR form composite.
class CalcFormEgfr extends StatelessWidget {
  /// Creates an eGFR form.
  const CalcFormEgfr({
    required this.draft,
    required this.errors,
    required this.onChanged,
    required this.onSexChanged,
    super.key,
  });

  /// Current draft inputs.
  final CalcInputDraft draft;

  /// Field errors.
  final Map<String, String> errors;

  /// Field change callback.
  final void Function(CalcInputFieldKey field, String value) onChanged;

  /// Sex change callback.
  final ValueChanged<Sex> onSexChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        CalcInputField(
          key: const ValueKey<String>('calc-input-ageYears'),
          label: l10n.calcInputAge,
          valueText: draft.valueOf(CalcInputFieldKey.ageYears),
          unit: l10n.calcUnitYear,
          errorText: errors['ageYears'],
          onChanged: (value) => onChanged(CalcInputFieldKey.ageYears, value),
        ),
        const SizedBox(height: 12),
        CalcInputField(
          key: const ValueKey<String>('calc-input-serumCreatinineMgDl'),
          label: l10n.calcInputCreatinine,
          valueText: draft.valueOf(CalcInputFieldKey.serumCreatinineMgDl),
          unit: l10n.calcUnitMgDl,
          errorText: errors['serumCreatinineMgDl'],
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
              icon: Symbols.male,
            ),
            CalcSegmentedControlItem<Sex>(
              value: Sex.female,
              label: l10n.calcSexFemale,
              icon: Symbols.female,
            ),
          ],
        ),
      ],
    );
  }
}
