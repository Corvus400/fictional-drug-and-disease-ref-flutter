part of '../app_database.dart';

/// Persisted calculation history rows.
@TableIndex.sql(
  'CREATE INDEX idx_calc_type_date '
  'ON calculation_history(calc_type, calculated_at DESC)',
)
class CalculationHistoriesTable extends Table {
  @override
  String get tableName => 'calculation_history';

  /// Calculation history id.
  TextColumn get id => text()();

  /// Calculation type.
  TextColumn get calcType => text().customConstraint(
    "NOT NULL CHECK (calc_type IN ('bmi', 'egfr', 'crcl'))",
  )();

  /// Serialized inputs JSON.
  TextColumn get inputs => text()();

  /// Serialized result JSON.
  TextColumn get result => text()();

  /// Calculation timestamp as Unix epoch milliseconds.
  IntColumn get calculatedAt =>
      integer().map(const DateTimeMillisConverter())();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
