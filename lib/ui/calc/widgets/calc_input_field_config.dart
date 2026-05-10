import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_text_formatter.dart';
import 'package:flutter/services.dart';

/// Input formatters for a calculation field.
List<TextInputFormatter> calcInputFormatters(CalcInputFieldSpec spec) {
  return [CalcInputTextFormatter(spec)];
}

/// Keyboard type for a calculation field.
TextInputType calcKeyboardType(CalcInputFieldSpec spec) {
  return spec.fractionDigits == 0
      ? TextInputType.number
      : const TextInputType.numberWithOptions(decimal: true);
}
