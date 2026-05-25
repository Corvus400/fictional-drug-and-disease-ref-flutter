import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart' show SqliteException;
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/error_response_dto.dart';
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
  if (error is SocketException || error is TimeoutException) {
    return NetworkException(cause: error);
  }
  if (error is FormatException) {
    return ParseException(cause: error);
  }
  if (error is SqliteException) {
    return StorageException(kind: _storageKindFor(error), cause: error);
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
    if (inner is SocketException || inner is TimeoutException) {
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
  final problem = _problemJsonFrom(data);
  if (problem != null) {
    try {
      final dto = ErrorResponseDto.fromJson(problem);
      return ApiException(
        statusCode: statusCode,
        type: dto.type ?? 'about:blank',
        title: dto.title,
        detail: dto.detail,
        instance: dto.instance,
        errors:
            dto.errors
                ?.map(
                  (error) => FieldViolation(
                    field: error.field,
                    reason: error.reason,
                  ),
                )
                .toList(growable: false) ??
            const <FieldViolation>[],
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
    type: 'about:blank',
    title: '',
    cause: cause,
  );
}

Map<String, dynamic>? _problemJsonFrom(Object? data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return data.map((key, value) => MapEntry(key.toString(), value));
  }
  if (data is Uint8List) {
    return _decodeProblemJson(utf8.decode(data));
  }
  if (data is List<int>) {
    return _decodeProblemJson(utf8.decode(data));
  }
  if (data is String) {
    return _decodeProblemJson(data);
  }
  return null;
}

Map<String, dynamic>? _decodeProblemJson(String data) {
  final Object? decoded;
  try {
    decoded = jsonDecode(data);
  } on FormatException {
    return null;
  }
  if (decoded is Map<String, dynamic>) {
    return decoded;
  }
  if (decoded is Map) {
    return decoded.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

StorageErrorKind _storageKindFor(SqliteException error) {
  return switch (error.extendedResultCode) {
    1555 || 2067 => StorageErrorKind.uniqueConstraint,
    275 => StorageErrorKind.checkConstraint,
    1299 => StorageErrorKind.notNull,
    _ => StorageErrorKind.unknown,
  };
}
