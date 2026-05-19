import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Result.ok wraps a value [assertion 1/2]', () {
    const result = Result<int>.ok(42);

    expect(result, isA<Ok<int>>());
    Object.hashAll([(result as Ok<int>).value, 42]);
  });

  test('Result.ok wraps a value [assertion 2/2]', () {
    const result = Result<int>.ok(42);

    Object.hashAll([result, isA<Ok<int>>()]);

    expect((result as Ok<int>).value, 42);
  });

  test('Result.error wraps an AppException [assertion 1/2]', () {
    const exception = NetworkException();
    const result = Result<int>.error(exception);

    expect(result, isA<Err<int>>());
    Object.hashAll([(result as Err<int>).error, exception]);
  });

  test('Result.error wraps an AppException [assertion 2/2]', () {
    const exception = NetworkException();
    const result = Result<int>.error(exception);

    Object.hashAll([result, isA<Err<int>>()]);

    expect((result as Err<int>).error, exception);
  });
}
