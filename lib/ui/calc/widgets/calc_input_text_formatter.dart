import 'package:fictional_drug_and_disease_ref/domain/calc/calc_input_field_spec.dart';
import 'package:flutter/services.dart';

/// Text formatter backed by a calculation input field spec.
final class CalcInputTextFormatter extends TextInputFormatter {
  /// Creates a formatter that accepts only edits allowed by [spec].
  const CalcInputTextFormatter(this.spec);

  /// Field spec that defines the editable grammar.
  final CalcInputFieldSpec spec;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return spec.allowsEditing(newValue.text) ? newValue : oldValue;
  }
}
