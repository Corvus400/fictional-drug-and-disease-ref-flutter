import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/image_api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getDosageFormImage returns Ok bytes on 200', () async {
    final adapter = _BytesAdapter(ResponseBody.fromBytes([1, 2, 3], 200));
    final service = ImageApiService(_buildDio(adapter));

    final result = await service.getDosageFormImage('tablet');

    expect(result, isA<Ok<Uint8List>>());
    expect((result as Ok<Uint8List>).value, [1, 2, 3]);
    expect(adapter.lastPath, '/v1/images/dosage-forms/tablet');
  });

  test('getDrugImage returns Ok bytes on 200', () async {
    final adapter = _BytesAdapter(ResponseBody.fromBytes([4, 5, 6], 200));
    final service = ImageApiService(_buildDio(adapter));

    final result = await service.getDrugImage('drug_0080');

    expect(result, isA<Ok<Uint8List>>());
    expect((result as Ok<Uint8List>).value, [4, 5, 6]);
    expect(adapter.lastPath, '/v1/images/drugs/drug_0080');
  });

  test('getDrugImage returns Err(ApiException NOT_FOUND) on 404', () async {
    final adapter = _BytesAdapter(
      ResponseBody.fromString(
        '{"code":"NOT_FOUND","message":"not found","disclaimer":"d"}',
        404,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
    final service = ImageApiService(_buildDio(adapter));

    final result = await service.getDrugImage('drug_missing');

    expect(result, isA<Err<Uint8List>>());
    final error = (result as Err<Uint8List>).error;
    expect(error, isA<ApiException>());
    expect((error as ApiException).code, 'NOT_FOUND');
  });

  test('getDrugImage returns Err(ServerException) on 500', () async {
    final adapter = _BytesAdapter(ResponseBody.fromString('server error', 500));
    final service = ImageApiService(_buildDio(adapter));

    final result = await service.getDrugImage('drug_0080');

    expect(result, isA<Err<Uint8List>>());
    expect((result as Err<Uint8List>).error, isA<ServerException>());
  });

  test(
    'getDrugImage returns Err(NetworkException) on connection error',
    () async {
      final adapter = _BytesAdapter.error(
        DioException(
          requestOptions: RequestOptions(path: '/v1/images/drugs/drug_0080'),
          type: DioExceptionType.connectionError,
        ),
      );
      final service = ImageApiService(_buildDio(adapter));

      final result = await service.getDrugImage('drug_0080');

      expect(result, isA<Err<Uint8List>>());
      expect((result as Err<Uint8List>).error, isA<NetworkException>());
    },
  );
}

Dio _buildDio(HttpClientAdapter adapter) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.example.test',
      responseType: ResponseType.bytes,
      validateStatus: (status) => status != null && status < 400,
    ),
  )..httpClientAdapter = adapter;
}

final class _BytesAdapter implements HttpClientAdapter {
  _BytesAdapter(this._response) : _error = null;

  _BytesAdapter.error(DioException error) : _response = null, _error = error;

  final ResponseBody? _response;
  final DioException? _error;
  String? lastPath;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastPath = options.path;
    final error = _error;
    if (error != null) {
      throw error.copyWith(requestOptions: options);
    }
    return _response!;
  }

  @override
  void close({bool force = false}) {}
}
