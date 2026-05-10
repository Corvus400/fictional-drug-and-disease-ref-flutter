/// Field-level input constraints for calculation tools.
final class CalcInputFieldSpec {
  /// Creates a calculation input field spec.
  const CalcInputFieldSpec({
    required this.fieldName,
    required this.min,
    required this.max,
    required this.minText,
    required this.maxText,
    required this.unitText,
    required this.integerDigits,
    required this.fractionDigits,
  });

  /// Domain field name used by validation error maps.
  final String fieldName;

  /// Minimum accepted numeric value.
  final num min;

  /// Maximum accepted numeric value.
  final num max;

  /// Formatted minimum value.
  final String minText;

  /// Formatted maximum value.
  final String maxText;

  /// Unit label for range errors.
  final String unitText;

  /// Maximum digits before a decimal point.
  final int integerDigits;

  /// Maximum digits after a decimal point.
  final int fractionDigits;

  /// Placeholder text shown while the field is empty.
  String get placeholderText => '$minText〜$maxText';

  /// Range text used by domain validation errors.
  String get rangeText => '$minText-$maxText $unitText';

  /// Whether [text] is allowed while the user is editing the field.
  bool allowsEditing(String text) => _editingPattern.hasMatch(text);

  /// Whether [text] is complete enough to parse and calculate.
  bool isCompleteText(String text) {
    return text.isNotEmpty && allowsEditing(text) && !text.endsWith('.');
  }

  /// Whether [value] is outside this field's accepted range.
  bool isOutOfRange(num value) => value < min || value > max;

  RegExp get _editingPattern {
    if (fractionDigits == 0) {
      return RegExp('^\\d{0,$integerDigits}\$');
    }
    return RegExp(
      '^(?:\\d{0,$integerDigits}|\\d{1,$integerDigits}\\.\\d{0,$fractionDigits})\$',
    );
  }
}

/// Calculation input specs shared by domain validation and UI input fields.
abstract final class CalcInputFieldSpecs {
  /// Height in centimeters.
  static const heightCm = CalcInputFieldSpec(
    fieldName: 'heightCm',
    min: 50.0,
    max: 250.0,
    minText: '50.0',
    maxText: '250.0',
    unitText: 'cm',
    integerDigits: 3,
    fractionDigits: 1,
  );

  /// Weight in kilograms.
  static const weightKg = CalcInputFieldSpec(
    fieldName: 'weightKg',
    min: 1.0,
    max: 300.0,
    minText: '1.0',
    maxText: '300.0',
    unitText: 'kg',
    integerDigits: 3,
    fractionDigits: 1,
  );

  /// Age in years.
  static const ageYears = CalcInputFieldSpec(
    fieldName: 'ageYears',
    min: 18,
    max: 120,
    minText: '18',
    maxText: '120',
    unitText: 'years',
    integerDigits: 3,
    fractionDigits: 0,
  );

  /// Serum creatinine in mg/dL.
  static const serumCreatinineMgDl = CalcInputFieldSpec(
    fieldName: 'serumCreatinineMgDl',
    min: 0.10,
    max: 20.00,
    minText: '0.10',
    maxText: '20.00',
    unitText: 'mg/dL',
    integerDigits: 2,
    fractionDigits: 2,
  );
}
