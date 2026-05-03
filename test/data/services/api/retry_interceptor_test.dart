import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('retries once on 500 status', () async {
    final adapter = _SequenceAdapter(
      [
        ResponseBody.fromString('server error', 500),
        ResponseBody.fromString('ok', 200),
      ],
    );
    final dio = _buildDio(adapter);

    final response = await dio.get<String>('/resource');

    expect(response.statusCode, 200);
    expect(adapter.fetchCount, 2);
  });

  test('does not retry on 404', () async {
    final adapter = _SequenceAdapter(
      [ResponseBody.fromString('not found', 404)],
    );
    final dio = _buildDio(adapter);

    await expectLater(
      dio.get<String>('/missing'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.fetchCount, 1);
  });

  test('does not retry on cancel type', () async {
    final adapter = _SequenceAdapter();
    final dio = _buildDio(adapter);
    adapter.enqueueError(
      DioException(
        requestOptions: RequestOptions(path: '/cancelled'),
        type: DioExceptionType.cancel,
      ),
    );

    await expectLater(
      dio.get<String>('/cancelled'),
      throwsA(
        isA<DioException>().having(
          (error) => error.type,
          'type',
          DioExceptionType.cancel,
        ),
      ),
    );
    expect(adapter.fetchCount, 1);
  });

  test('delays 500ms before retry', () async {
    final adapter = _SequenceAdapter(
      [
        ResponseBody.fromString('server error', 500),
        ResponseBody.fromString('ok', 200),
      ],
    );
    final dio = _buildDio(adapter);
    final stopwatch = Stopwatch()..start();

    await dio.get<String>('/resource');
    stopwatch.stop();

    expect(
      stopwatch.elapsed,
      greaterThanOrEqualTo(const Duration(milliseconds: 500)),
    );
  });

  test('does not retry twice', () async {
    final adapter = _SequenceAdapter(
      [
        ResponseBody.fromString('first server error', 500),
        ResponseBody.fromString('second server error', 500),
        ResponseBody.fromString('ok', 200),
      ],
    );
    final dio = _buildDio(adapter);

    await expectLater(
      dio.get<String>('/resource'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.fetchCount, 2);
  });
}

Dio _buildDio(HttpClientAdapter adapter) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.test',
      validateStatus: (status) => status != null && status < 400,
    ),
  );
  dio
    ..httpClientAdapter = adapter
    ..interceptors.add(RetryInterceptor(dio: dio));
  return dio;
}

final class _SequenceAdapter implements HttpClientAdapter {
  _SequenceAdapter([List<ResponseBody> responses = const []])
    : _responses = [...responses];

  final List<Object> _responses;
  int fetchCount = 0;

  void enqueueError(DioException error) => _responses.add(error);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final index = fetchCount;
    fetchCount += 1;
    final response = _responses[index];
    if (response is DioException) {
      throw response.copyWith(requestOptions: options);
    }
    return response as ResponseBody;
  }

  @override
  void close({bool force = false}) {}
}
