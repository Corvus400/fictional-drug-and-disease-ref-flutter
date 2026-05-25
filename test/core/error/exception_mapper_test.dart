import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/native.dart' show SqliteException;
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _validationType =
    'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/validation';
const _notFoundType =
    'https://github.com/Corvus400/fictional-drug-and-disease-ref/problems/not-found';

void main() {
  group('DioException', () {
    test('network DioException types map to NetworkException', () {
      for (final type in <DioExceptionType>{
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
        DioExceptionType.badCertificate,
        DioExceptionType.cancel,
      }) {
        expect(toAppException(_dioException(type)), isA<NetworkException>());
      }
    });

    test('DioException(badResponse, 503) maps to ServerException(503)', () {
      expect(
        toAppException(_badResponse(503)),
        isA<ServerException>().having((e) => e.statusCode, 'statusCode', 503),
      );
    });

    test(
      'DioException(badResponse, RFC 9457 body) maps to ApiException fields',
      () {
        expect(
          toAppException(
            _badResponse(
              422,
              data: <String, dynamic>{
                'type': _validationType,
                'title': 'Validation failed',
                'status': 422,
                'detail': 'Invalid query parameter',
                'instance': '/v1/drugs?therapeutic_category=BOGUS',
                'errors': <Map<String, dynamic>>[
                  <String, dynamic>{
                    'field': 'therapeutic_category',
                    'reason': 'Unknown therapeutic_category: BOGUS',
                  },
                ],
              },
            ),
          ),
          isA<ApiException>()
              .having((e) => e.statusCode, 'statusCode', 422)
              .having((e) => e.type, 'type', _validationType)
              .having((e) => e.title, 'title', 'Validation failed')
              .having((e) => e.detail, 'detail', 'Invalid query parameter')
              .having(
                (e) => e.instance,
                'instance',
                '/v1/drugs?therapeutic_category=BOGUS',
              )
              .having((e) => e.errors, 'errors', hasLength(1))
              .having(
                (e) => e.errors.single.field,
                'error field',
                'therapeutic_category',
              )
              .having(
                (e) => e.errors.single.reason,
                'error reason',
                'Unknown therapeutic_category: BOGUS',
              ),
        );
      },
    );

    test(
      'DioException(badResponse, RFC 9457 bytes body) maps to ApiException',
      () {
        final body = utf8.encode(
          jsonEncode(<String, dynamic>{
            'type': _notFoundType,
            'title': 'Resource not found',
            'status': 404,
            'detail': 'drug-image nonexistent',
          }),
        );
        expect(
          toAppException(_badResponse(404, data: Uint8List.fromList(body))),
          isA<ApiException>()
              .having((e) => e.statusCode, 'statusCode', 404)
              .having((e) => e.type, 'type', _notFoundType)
              .having((e) => e.title, 'title', 'Resource not found')
              .having((e) => e.detail, 'detail', 'drug-image nonexistent'),
        );
      },
    );

    test(
      'DioException(badResponse, empty 4xx body) maps to fallback problem',
      () {
        expect(
          toAppException(_badResponse(400)),
          isA<ApiException>()
              .having((e) => e.statusCode, 'statusCode', 400)
              .having((e) => e.type, 'type', 'about:blank')
              .having((e) => e.title, 'title', '')
              .having((e) => e.errors, 'errors', isEmpty),
        );
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

  test('SqliteException(2067) maps to StorageException(uniqueConstraint)', () {
    final mapped = toAppException(_sqliteException(2067)) as StorageException;

    expect(mapped.kind, StorageErrorKind.uniqueConstraint);
  });

  test('SqliteException(1555) maps to StorageException(uniqueConstraint)', () {
    final mapped = toAppException(_sqliteException(1555)) as StorageException;

    expect(mapped.kind, StorageErrorKind.uniqueConstraint);
  });

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
    expect(
      toAppException(PlatformException(code: 'X')),
      isA<StorageException>().having(
        (e) => e.kind,
        'kind',
        StorageErrorKind.prefsWriteFailed,
      ),
    );
  });

  test('MissingPluginException maps to StorageException(prefsWriteFailed)', () {
    expect(
      toAppException(MissingPluginException()),
      isA<StorageException>().having(
        (e) => e.kind,
        'kind',
        StorageErrorKind.prefsWriteFailed,
      ),
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
