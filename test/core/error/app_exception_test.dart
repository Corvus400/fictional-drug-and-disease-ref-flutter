import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ServerException carries statusCode', () {
    const e = ServerException(statusCode: 503);

    expect(
      e,
      isA<ServerException>().having((e) => e.statusCode, 'statusCode', 503),
    );
  });

  test('ApiException carries RFC 9457 fields', () {
    const e = ApiException(
      statusCode: 422,
      type:
          'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
      title: 'Validation failed',
      detail: 'Invalid query parameter',
      instance: '/v1/drugs?therapeutic_category=BOGUS',
      errors: <FieldViolation>[
        FieldViolation(
          field: 'therapeutic_category',
          reason: 'Unknown therapeutic_category: BOGUS',
        ),
      ],
    );

    expect(
      e,
      isA<ApiException>()
          .having((e) => e.statusCode, 'statusCode', 422)
          .having((e) => e.type, 'type', endsWith('/validation'))
          .having((e) => e.title, 'title', 'Validation failed')
          .having((e) => e.detail, 'detail', 'Invalid query parameter')
          .having(
            (e) => e.instance,
            'instance',
            '/v1/drugs?therapeutic_category=BOGUS',
          )
          .having(
            (e) => e.errors.single.field,
            'error field',
            'therapeutic_category',
          )
          .having(
            (e) => e.errors.single.reason,
            'error reason',
            'Unknown therapeutic_category: BOGUS',
          ),
    );
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
