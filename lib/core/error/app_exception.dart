/// Base exception type used across the application.
sealed class AppException implements Exception {
  /// Creates an application exception.
  const AppException({this.cause, this.stackTrace});

  /// Original exception or error object.
  final Object? cause;

  /// Stack trace captured at the boundary where this exception was mapped.
  final StackTrace? stackTrace;
}

/// Connectivity or transport-layer failure.
final class NetworkException extends AppException {
  /// Creates a network exception.
  const NetworkException({super.cause, super.stackTrace});
}

/// Server-side 5xx response.
final class ServerException extends AppException {
  /// Creates a server exception.
  const ServerException({
    required this.statusCode,
    super.cause,
    super.stackTrace,
  });

  /// HTTP status code.
  final int statusCode;
}

/// API 4xx response with structured error payload.
final class ApiException extends AppException {
  /// Creates an API exception.
  const ApiException({
    required this.statusCode,
    required this.code,
    required this.message,
    this.details,
    this.disclaimer,
    super.cause,
    super.stackTrace,
  });

  /// HTTP status code.
  final int statusCode;

  /// API error code.
  final String code;

  /// API error message.
  final String message;

  /// Optional error detail.
  final String? details;

  /// Optional API disclaimer.
  final String? disclaimer;
}

/// Response parsing failure.
final class ParseException extends AppException {
  /// Creates a parse exception.
  const ParseException({super.cause, super.stackTrace});
}

/// Storage failure kind.
enum StorageErrorKind {
  /// Unique constraint violation.
  uniqueConstraint,

  /// Check constraint violation.
  checkConstraint,

  /// Not-null constraint violation.
  notNull,

  /// Shared preferences write failure.
  prefsWriteFailed,

  /// Unknown storage failure.
  unknown,
}

/// Local storage failure.
final class StorageException extends AppException {
  /// Creates a storage exception.
  const StorageException({
    required this.kind,
    super.cause,
    super.stackTrace,
  });

  /// Storage failure kind.
  final StorageErrorKind kind;
}

/// Fallback for recognized Exception objects with no specific mapping.
final class UnknownException extends AppException {
  /// Creates an unknown exception.
  const UnknownException({super.cause, super.stackTrace});
}
