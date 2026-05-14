import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/core/error/platform_exception_classifier.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

const _networkDioTypes = <DioExceptionType>{
  DioExceptionType.connectionTimeout,
  DioExceptionType.sendTimeout,
  DioExceptionType.receiveTimeout,
  DioExceptionType.connectionError,
  DioExceptionType.badCertificate,
  DioExceptionType.cancel,
};

/// Maps boundary-layer exceptions to application exceptions.
AppException toAppException(Object error) {
  if (error is DioException) {
    return _fromDioException(error);
  }
  if (isSocketException(error) || error is TimeoutException) {
    return NetworkException(cause: error);
  }
  if (error is FormatException) {
    return ParseException(cause: error);
  }
  if (isSqliteException(error)) {
    return StorageException(kind: sqliteStorageKind(error), cause: error);
  }
  if (error is PlatformException || error is MissingPluginException) {
    return StorageException(
      kind: StorageErrorKind.prefsWriteFailed,
      cause: error,
    );
  }
  return UnknownException(cause: error);
}

AppException _fromDioException(DioException error) {
  if (_networkDioTypes.contains(error.type)) {
    return NetworkException(cause: error);
  }

  if (error.type == DioExceptionType.badResponse) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 500 && statusCode <= 599) {
      return ServerException(statusCode: statusCode, cause: error);
    }
    if (statusCode != null && statusCode >= 400 && statusCode <= 499) {
      return _toApiException(statusCode, error.response?.data, cause: error);
    }
  }

  if (error.type == DioExceptionType.unknown) {
    final inner = error.error;
    if (inner is FormatException) {
      return ParseException(cause: error);
    }
    if (isSocketException(inner) || inner is TimeoutException) {
      return NetworkException(cause: error);
    }
  }

  return UnknownException(cause: error);
}

ApiException _toApiException(
  int statusCode,
  Object? data, {
  required DioException cause,
}) {
  if (data is Map<String, dynamic>) {
    try {
      final dto = ErrorResponseDto.fromJson(data);
      return ApiException(
        statusCode: statusCode,
        code: dto.code,
        message: dto.message,
        details: dto.details,
        disclaimer: dto.disclaimer,
        cause: cause,
      );
    } on CheckedFromJsonException catch (_) {
      // Fall through to the defensive fallback below.
    } on FormatException catch (_) {
      // Fall through to the defensive fallback below.
    }
  }

  return ApiException(
    statusCode: statusCode,
    code: 'UNKNOWN',
    message: '',
    cause: cause,
  );
}
