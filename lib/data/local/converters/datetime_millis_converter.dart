import 'package:drift/drift.dart';

/// Converts DateTime values to Unix epoch milliseconds for SQLite storage.
final class DateTimeMillisConverter extends TypeConverter<DateTime, int> {
  /// Creates a DateTime milliseconds converter.
  const DateTimeMillisConverter();

  @override
  DateTime fromSql(int fromDb) {
    return DateTime.fromMillisecondsSinceEpoch(fromDb, isUtc: true);
  }

  @override
  int toSql(DateTime value) {
    return value.toUtc().millisecondsSinceEpoch;
  }
}
