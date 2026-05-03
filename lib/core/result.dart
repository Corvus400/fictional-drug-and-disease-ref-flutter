import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Success-or-failure result used by service/repository boundaries.
sealed class Result<T> {
  /// Creates a result.
  const Result();

  /// Creates a successful result.
  const factory Result.ok(T value) = Ok<T>._;

  /// Creates a failed result.
  const factory Result.error(AppException error) = Err<T>._;
}

/// Successful result.
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Success value.
  final T value;
}

/// Failed result.
final class Err<T> extends Result<T> {
  const Err._(this.error);

  /// Application exception.
  final AppException error;
}
