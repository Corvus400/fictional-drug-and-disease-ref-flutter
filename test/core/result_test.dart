import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Result.ok wraps a value', () {
    const result = Result<int>.ok(42);

    expect(result, isA<Ok<int>>());
    expect((result as Ok<int>).value, 42);
  });

  test('Result.error wraps an AppException', () {
    const exception = NetworkException();
    const result = Result<int>.error(exception);

    expect(result, isA<Err<int>>());
    expect((result as Err<int>).error, exception);
  });
}
