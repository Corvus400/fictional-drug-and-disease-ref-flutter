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

  test('ApiException not-found type maps to errApiNotFound', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 404,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/not-found',
          title: 'Resource not found',
        ),
      ),
      'errApiNotFound',
    );
  });

  test('ApiException validation type maps to errApiValidation', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 422,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation',
          title: 'Validation failed',
          errors: <FieldViolation>[
            FieldViolation(field: 'therapeutic_category', reason: 'Unknown'),
          ],
        ),
      ),
      'errApiValidation',
    );
  });

  test('ApiException conflict type maps to errApiConflict', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 409,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/conflict',
          title: 'Conflict',
        ),
      ),
      'errApiConflict',
    );
  });

  test('ApiException unauthorized type maps to errApiUnauthorized', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 401,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/unauthorized',
          title: 'Unauthorized',
        ),
      ),
      'errApiUnauthorized',
    );
  });

  test('ApiException forbidden type maps to errApiForbidden', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 403,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/forbidden',
          title: 'Forbidden',
        ),
      ),
      'errApiForbidden',
    );
  });

  test('ApiException rate-limited type maps to errApiRateLimited', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 429,
          type:
              'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/rate-limited',
          title: 'Too Many Requests',
        ),
      ),
      'errApiRateLimited',
    );
  });

  test('ApiException other type maps to errApi4xx', () {
    expect(
      errorKeyFor(
        const ApiException(
          statusCode: 400,
          type: 'about:blank',
          title: '',
        ),
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
