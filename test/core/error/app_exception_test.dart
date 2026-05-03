import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ServerException carries statusCode', () {
    const e = ServerException(statusCode: 503);

    expect(e, isA<AppException>());
    expect(e.statusCode, 503);
  });

  test('ApiException carries all fields', () {
    const e = ApiException(
      statusCode: 404,
      code: 'NOT_FOUND',
      message: 'not found',
      details: 'detail',
      disclaimer: 'disc',
    );

    expect(e.statusCode, 404);
    expect(e.code, 'NOT_FOUND');
    expect(e.message, 'not found');
    expect(e.details, 'detail');
    expect(e.disclaimer, 'disc');
  });

  test('ParseException is an AppException', () {
    expect(const ParseException(), isA<AppException>());
  });

  test('StorageException carries kind', () {
    const e = StorageException(kind: StorageErrorKind.uniqueConstraint);

    expect(e.kind, StorageErrorKind.uniqueConstraint);
  });

  test('UnknownException is an AppException', () {
    expect(const UnknownException(), isA<AppException>());
  });
}
