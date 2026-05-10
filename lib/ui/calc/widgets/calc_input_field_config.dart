import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_input_text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input formatters for a calculation field.
List<TextInputFormatter> calcInputFormatters(CalcInputFieldSpec spec) {
  return [CalcInputTextFormatter(spec)];
}

/// Keyboard type for a calculation field.
TextInputType calcKeyboardType(BuildContext context, CalcInputFieldSpec spec) {
  if (Theme.of(context).platform == TargetPlatform.iOS &&
      MediaQuery.sizeOf(context).shortestSide >= 600) {
    return TextInputType.datetime;
  }
  return spec.fractionDigits == 0
      ? TextInputType.number
      : const TextInputType.numberWithOptions(decimal: true);
}
