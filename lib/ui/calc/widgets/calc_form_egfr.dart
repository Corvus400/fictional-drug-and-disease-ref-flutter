import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_field_config.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_segmented_control.dart';
import 'package:flutter/material.dart';

/// eGFR form composite.
class CalcFormEgfr extends StatefulWidget {
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
  State<CalcFormEgfr> createState() => _CalcFormEgfrState();
}

class _CalcFormEgfrState extends State<CalcFormEgfr> {
  late final FocusNode _ageFocusNode;
  late final FocusNode _creatinineFocusNode;

  @override
  void initState() {
    super.initState();
    _ageFocusNode = FocusNode();
    _creatinineFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _ageFocusNode.dispose();
    _creatinineFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const ageSpec = CalcInputFieldSpecs.ageYears;
    const creatinineSpec = CalcInputFieldSpecs.serumCreatinineMgDl;

    return Column(
      children: [
        CalcInputField(
          key: const ValueKey<String>('calc-input-ageYears'),
          label: l10n.calcInputAge,
          valueText: widget.draft.valueOf(CalcInputFieldKey.ageYears),
          placeholder: ageSpec.placeholderText,
          unit: l10n.calcUnitYear,
          errorText: widget.errors[ageSpec.fieldName],
          focusNode: _ageFocusNode,
          keyboardType: calcKeyboardType(ageSpec),
          inputFormatters: calcInputFormatters(ageSpec),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => _creatinineFocusNode.requestFocus(),
          onChanged: (value) =>
              widget.onChanged(CalcInputFieldKey.ageYears, value),
        ),
        const SizedBox(height: 12),
        CalcInputField(
          key: const ValueKey<String>('calc-input-serumCreatinineMgDl'),
          label: l10n.calcInputCreatinine,
          valueText: widget.draft.valueOf(
            CalcInputFieldKey.serumCreatinineMgDl,
          ),
          placeholder: creatinineSpec.placeholderText,
          unit: l10n.calcUnitMgDl,
          errorText: widget.errors[creatinineSpec.fieldName],
          focusNode: _creatinineFocusNode,
          keyboardType: calcKeyboardType(creatinineSpec),
          inputFormatters: calcInputFormatters(creatinineSpec),
          onFieldSubmitted: (_) => _creatinineFocusNode.unfocus(),
          onChanged: (value) =>
              widget.onChanged(CalcInputFieldKey.serumCreatinineMgDl, value),
        ),
        const SizedBox(height: 12),
        CalcSegmentedControl<Sex>.sex(
          selectedValue: widget.draft.sex,
          onChanged: widget.onSexChanged,
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
