/// Biological sex used by renal function formulas.
enum Sex {
  /// Male.
  male('male', 1),

  /// Female.
  female('female', 0.739)
  ;

  const Sex(this.storageKey, this.egfrCoefficient);

  /// Value stored in calculation history JSON.
  final String storageKey;

  /// CKD-EPI Japanese coefficient multiplier.
  final double egfrCoefficient;

  /// Parses a storage key.
  static Sex parse(String value) {
    for (final sex in values) {
      if (sex.storageKey == value) {
        return sex;
      }
    }
    throw FormatException('Unknown sex: $value');
  }
}
