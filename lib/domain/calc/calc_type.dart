/// Supported calculation tools.
enum CalcType {
  /// Body mass index.
  bmi('bmi', 'BMI'),

  /// Estimated glomerular filtration rate.
  egfr('egfr', 'eGFR'),

  /// Creatinine clearance.
  crcl('crcl', 'CrCl')
  ;

  const CalcType(this.storageKey, this.displayName);

  /// Value stored in calculation history.
  final String storageKey;

  /// Compact display label.
  final String displayName;

  /// Parses a storage key.
  static CalcType parse(String value) {
    for (final type in values) {
      if (type.storageKey == value) {
        return type;
      }
    }
    throw FormatException('Unknown calc type: $value');
  }
}
