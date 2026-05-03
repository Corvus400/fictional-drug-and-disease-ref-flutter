import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart' show SqliteException;
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DioException', () {
    test('DioException(connectionTimeout) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.connectionTimeout);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(sendTimeout) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.sendTimeout);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(receiveTimeout) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.receiveTimeout);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(connectionError) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.connectionError);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(badCertificate) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.badCertificate);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(cancel) maps to NetworkException', () {
      final e = _dioException(DioExceptionType.cancel);

      expect(toAppException(e), isA<NetworkException>());
    });

    test('DioException(badResponse, 503) maps to ServerException(503)', () {
      final mapped = toAppException(_badResponse(503));

      expect(mapped, isA<ServerException>());
      expect((mapped as ServerException).statusCode, 503);
    });

    test('DioException(badResponse, 4xx, valid body) maps to ApiException', () {
      final mapped =
          toAppException(
                _badResponse(
                  404,
                  data: <String, dynamic>{
                    'code': 'NOT_FOUND',
                    'message': 'not found',
                    'details': 'd',
                    'disclaimer': 'disc',
                  },
                ),
              )
              as ApiException;

      expect(mapped.statusCode, 404);
      expect(mapped.code, 'NOT_FOUND');
      expect(mapped.message, 'not found');
      expect(mapped.details, 'd');
      expect(mapped.disclaimer, 'disc');
    });

    test(
      'DioException(badResponse, 4xx, empty body) maps to fallback',
      () {
        final mapped = toAppException(_badResponse(400)) as ApiException;

        expect(mapped.statusCode, 400);
        expect(mapped.code, 'UNKNOWN');
        expect(mapped.message, '');
      },
    );

    test('DioException(unknown, FormatException) maps to ParseException', () {
      final e = _dioException(
        DioExceptionType.unknown,
        error: const FormatException('bad json'),
      );

      expect(toAppException(e), isA<ParseException>());
    });

    test('DioException(unknown, SocketException) maps to NetworkException', () {
      final e = _dioException(
        DioExceptionType.unknown,
        error: const SocketException('no network'),
      );

      expect(toAppException(e), isA<NetworkException>());
    });

    test(
      'DioException(unknown, TimeoutException) maps to NetworkException',
      () {
        final e = _dioException(
          DioExceptionType.unknown,
          error: TimeoutException('timeout'),
        );

        expect(toAppException(e), isA<NetworkException>());
      },
    );

    test('DioException(unknown, other inner) maps to UnknownException', () {
      final e = _dioException(DioExceptionType.unknown, error: Object());

      expect(toAppException(e), isA<UnknownException>());
    });
  });

  test('SocketException maps to NetworkException', () {
    expect(
      toAppException(const SocketException('no network')),
      isA<NetworkException>(),
    );
  });

  test('TimeoutException maps to NetworkException', () {
    expect(
      toAppException(TimeoutException('timeout')),
      isA<NetworkException>(),
    );
  });

  test('FormatException maps to ParseException', () {
    expect(
      toAppException(const FormatException('bad json')),
      isA<ParseException>(),
    );
  });

  test(
    'SqliteException(2067) maps to StorageException(uniqueConstraint)',
    () {
      final mapped = toAppException(_sqliteException(2067)) as StorageException;

      expect(mapped.kind, StorageErrorKind.uniqueConstraint);
    },
  );

  test(
    'SqliteException(1555) maps to StorageException(uniqueConstraint)',
    () {
      final mapped = toAppException(_sqliteException(1555)) as StorageException;

      expect(mapped.kind, StorageErrorKind.uniqueConstraint);
    },
  );

  test('SqliteException(275) maps to StorageException(checkConstraint)', () {
    final mapped = toAppException(_sqliteException(275)) as StorageException;

    expect(mapped.kind, StorageErrorKind.checkConstraint);
  });

  test('SqliteException(1299) maps to StorageException(notNull)', () {
    final mapped = toAppException(_sqliteException(1299)) as StorageException;

    expect(mapped.kind, StorageErrorKind.notNull);
  });

  test('SqliteException(other code) maps to StorageException(unknown)', () {
    final mapped = toAppException(_sqliteException(999)) as StorageException;

    expect(mapped.kind, StorageErrorKind.unknown);
  });

  test('PlatformException maps to StorageException(prefsWriteFailed)', () {
    final mapped = toAppException(PlatformException(code: 'X'));

    expect(mapped, isA<StorageException>());
    expect(
      (mapped as StorageException).kind,
      StorageErrorKind.prefsWriteFailed,
    );
  });

  test('MissingPluginException maps to StorageException(prefsWriteFailed)', () {
    final mapped = toAppException(MissingPluginException());

    expect(mapped, isA<StorageException>());
    expect(
      (mapped as StorageException).kind,
      StorageErrorKind.prefsWriteFailed,
    );
  });

  test('Unrecognized Exception falls back to UnknownException', () {
    expect(toAppException(Exception('x')), isA<UnknownException>());
  });
}

DioException _dioException(DioExceptionType type, {Object? error}) {
  return DioException(
    requestOptions: RequestOptions(path: '/'),
    type: type,
    error: error,
  );
}

DioException _badResponse(int statusCode, {Object? data}) {
  final response = Response<Object?>(
    requestOptions: RequestOptions(path: '/'),
    statusCode: statusCode,
    data: data,
  );
  return DioException(
    requestOptions: response.requestOptions,
    type: DioExceptionType.badResponse,
    response: response,
  );
}

SqliteException _sqliteException(int extendedResultCode) {
  return SqliteException(
    extendedResultCode: extendedResultCode,
    message: 'sqlite error',
  );
}
