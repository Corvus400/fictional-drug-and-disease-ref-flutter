import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Maps an [AppException] to an ARB localization key.
String errorKeyFor(AppException exception) {
  return switch (exception) {
    NetworkException() => 'errNetwork',
    ServerException() => 'errServer',
    ApiException(:final type, :final errors) => _apiErrorKeyFor(type, errors),
    ParseException() => 'errParse',
    StorageException(:final kind) => _storageErrorKeyFor(kind),
    UnknownException() => 'errUnknown',
  };
}

String _apiErrorKeyFor(String type, List<FieldViolation> errors) {
  return switch (_problemCategory(type)) {
    'not-found' => 'errApiNotFound',
    'validation' when errors.isNotEmpty => 'errApiValidation',
    'validation' => 'errApiValidation',
    'conflict' => 'errApiConflict',
    'unauthorized' => 'errApiUnauthorized',
    'forbidden' => 'errApiForbidden',
    'rate-limited' => 'errApiRateLimited',
    'internal' => 'errServer',
    _ => 'errApi4xx',
  };
}

String _problemCategory(String type) {
  final uri = Uri.tryParse(type);
  if (uri == null || uri.pathSegments.isEmpty) {
    return type;
  }
  return uri.pathSegments.last;
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
