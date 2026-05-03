/// Persisted calculation history entry.
final class CalculationHistoryEntry {
  /// Creates a calculation history entry.
  const CalculationHistoryEntry({
    required this.id,
    required this.calcType,
    required this.inputsJson,
    required this.resultJson,
    required this.calculatedAt,
  });

  /// Calculation history id.
  final String id;

  /// Calculation type.
  final String calcType;

  /// Serialized inputs JSON.
  final String inputsJson;

  /// Serialized result JSON.
  final String resultJson;

  /// Calculation timestamp.
  final DateTime calculatedAt;
}
