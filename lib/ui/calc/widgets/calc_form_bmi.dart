import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:flutter/material.dart';

/// BMI form composite.
class CalcFormBmi extends StatelessWidget {
  /// Creates a BMI form.
  const CalcFormBmi({
    required this.draft,
    required this.errors,
    required this.onChanged,
    super.key,
  });

  /// Current draft inputs.
  final CalcInputDraft draft;

  /// Field errors.
  final Map<String, String> errors;

  /// Field change callback.
  final void Function(CalcInputFieldKey field, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        CalcInputField(
          key: const ValueKey<String>('calc-input-heightCm'),
          label: l10n.calcInputHeight,
          valueText: draft.valueOf(CalcInputFieldKey.heightCm),
          unit: l10n.calcUnitCm,
          errorText: errors['heightCm'],
          onChanged: (value) => onChanged(CalcInputFieldKey.heightCm, value),
        ),
        const SizedBox(height: 12),
        CalcInputField(
          key: const ValueKey<String>('calc-input-weightKg'),
          label: l10n.calcInputWeight,
          valueText: draft.valueOf(CalcInputFieldKey.weightKg),
          unit: l10n.calcUnitKg,
          errorText: errors['weightKg'],
          onChanged: (value) => onChanged(CalcInputFieldKey.weightKg, value),
        ),
      ],
    );
  }
}
