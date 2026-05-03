import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Maps an [AppException] to an ARB localization key.
String errorKeyFor(AppException exception) {
  return switch (exception) {
    NetworkException() => 'errNetwork',
    ServerException() => 'errServer',
    ApiException(:final code) => _apiErrorKeyFor(code),
    ParseException() => 'errParse',
    StorageException(:final kind) => _storageErrorKeyFor(kind),
    UnknownException() => 'errUnknown',
  };
}

String _apiErrorKeyFor(String code) {
  return switch (code) {
    'NOT_FOUND' => 'errApiNotFound',
    'BAD_REQUEST' => 'errApiBadRequest',
    _ when code.startsWith('INVALID_') => 'errApiInvalidCategory',
    _ => 'errApi4xx',
  };
}

String _storageErrorKeyFor(StorageErrorKind kind) {
  return switch (kind) {
    StorageErrorKind.uniqueConstraint => 'errStorageUnique',
    StorageErrorKind.checkConstraint => 'errStorageCheck',
    StorageErrorKind.notNull ||
    StorageErrorKind.prefsWriteFailed ||
    StorageErrorKind.unknown => 'errStorageGeneric',
  };
}
