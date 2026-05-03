import 'package:fictional_drug_and_disease_ref/data/local/converters/datetime_millis_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DateTimeMillisConverter roundtrips UTC epoch milliseconds', () {
    const converter = DateTimeMillisConverter();
    final value = DateTime.utc(2026, 5, 4, 12, 30, 45);

    final sql = converter.toSql(value);
    final restored = converter.fromSql(sql);

    expect(sql, value.millisecondsSinceEpoch);
    expect(restored, value);
    expect(restored.isUtc, isTrue);
  });
}
