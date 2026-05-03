import 'package:dio/dio.dart';

const _retriedKey = '__retried';
const _retryBackoff = Duration(milliseconds: 500);

/// Retries transient API failures.
class RetryInterceptor extends Interceptor {
  /// Creates a retry interceptor.
  RetryInterceptor({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.requestOptions.extra[_retriedKey] == true) {
      handler.next(err);
      return;
    }

    final statusCode = err.response?.statusCode;
    if (statusCode != null && statusCode >= 500 && statusCode <= 599) {
      err.requestOptions.extra[_retriedKey] = true;
      await Future<void>.delayed(_retryBackoff);
      try {
        final response = await _dio.fetch<Object?>(err.requestOptions);
        handler.resolve(response);
      } on DioException catch (retryError) {
        handler.next(retryError);
      }
      return;
    }
    handler.next(err);
  }
}
