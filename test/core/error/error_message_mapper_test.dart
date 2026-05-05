import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_message_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NetworkException maps to errNetwork', () {
    expect(errorKeyFor(const NetworkException()), 'errNetwork');
  });

  test('ServerException maps to errServer', () {
    expect(errorKeyFor(const ServerException(statusCode: 503)), 'errServer');
  });

  test('ApiException NOT_FOUND maps to errApiNotFound', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 404,
          code: 'NOT_FOUND',
          message: '',
        ),
      ),
      'errApiNotFound',
    );
  });

  test('ApiException BAD_REQUEST maps to errApiBadRequest', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 400,
          code: 'BAD_REQUEST',
          message: '',
        ),
      ),
      'errApiBadRequest',
    );
  });

  test('ApiException INVALID_* maps to errApiInvalidCategory', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 400,
          code: 'INVALID_THERAPEUTIC_CATEGORY',
          message: '',
        ),
      ),
      'errApiInvalidCategory',
    );
  });

  test(
    'ApiException INVALID_ONSET_PATTERN maps to business error key (T05)',
    () {
      expect(
        errorKeyFor(
          const ApiException(
            statusCode: 400,
            code: 'INVALID_ONSET_PATTERN',
            message: '',
          ),
        ),
        'errApiInvalidCategory',
      );
    },
  );

  test('ApiException other code maps to errApi4xx', () {
    expect(
      errorKeyFor(
        const ApiException(statusCode: 400, code: 'UNKNOWN', message: ''),
      ),
      'errApi4xx',
    );
  });

  test('ParseException maps to errParse', () {
    expect(errorKeyFor(const ParseException()), 'errParse');
  });

  test('StorageException uniqueConstraint maps to errStorageUnique', () {
    expect(
      errorKeyFor(
        const StorageException(kind: StorageErrorKind.uniqueConstraint),
      ),
      'errStorageUnique',
    );
  });

  test('StorageException checkConstraint maps to errStorageCheck', () {
    expect(
      errorKeyFor(
        const StorageException(kind: StorageErrorKind.checkConstraint),
      ),
      'errStorageCheck',
    );
  });

  test('StorageException notNull maps to errStorageGeneric', () {
    expect(
      errorKeyFor(const StorageException(kind: StorageErrorKind.notNull)),
      'errStorageGeneric',
    );
  });

  test('StorageException prefsWriteFailed maps to errStorageGeneric', () {
    expect(
      errorKeyFor(
        const StorageException(kind: StorageErrorKind.prefsWriteFailed),
      ),
      'errStorageGeneric',
    );
  });

  test('StorageException unknown maps to errStorageGeneric', () {
    expect(
      errorKeyFor(const StorageException(kind: StorageErrorKind.unknown)),
      'errStorageGeneric',
    );
  });

  test('UnknownException maps to errUnknown', () {
    expect(errorKeyFor(const UnknownException()), 'errUnknown');
  });
}
