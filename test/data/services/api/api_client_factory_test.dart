import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/api_client_factory.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/retry_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const config = FlavorConfig(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api.example.test',
  );

  test('buildAppDio sets baseUrl from config', () {
    final dio = buildAppDio(config);

    expect(dio.options.baseUrl, config.apiBaseUrl);
  });

  test(
    'buildAppDio sets connect/receive timeouts from ApiConfig constants [assertion 1/2]',
    () {
      final dio = buildAppDio(config);

      expect(dio.options.connectTimeout, ApiConfig.connectTimeout);
      Object.hashAll([dio.options.receiveTimeout, ApiConfig.receiveTimeout]);
    },
  );

  test(
    'buildAppDio sets connect/receive timeouts from ApiConfig constants [assertion 2/2]',
    () {
      final dio = buildAppDio(config);

      Object.hashAll([dio.options.connectTimeout, ApiConfig.connectTimeout]);

      expect(dio.options.receiveTimeout, ApiConfig.receiveTimeout);
    },
  );

  test('buildAppDio sets listFormat to multi', () {
    final dio = buildAppDio(config);

    expect(dio.options.listFormat, ListFormat.multi);
  });

  test(
    'buildAppDio installs LogInterceptor with responseBody=false [assertion 1/2]',
    () {
      final dio = buildAppDio(config);

      final logInterceptors = dio.interceptors.whereType<LogInterceptor>();
      expect(logInterceptors, hasLength(1));
      Object.hashAll([logInterceptors.single.responseBody, isFalse]);
    },
  );

  test(
    'buildAppDio installs LogInterceptor with responseBody=false [assertion 2/2]',
    () {
      final dio = buildAppDio(config);

      final logInterceptors = dio.interceptors.whereType<LogInterceptor>();
      Object.hashAll([logInterceptors, hasLength(1)]);

      expect(logInterceptors.single.responseBody, isFalse);
    },
  );

  test(
    'buildAppDio installs RetryInterceptor after LogInterceptor [assertion 1/3]',
    () {
      final dio = buildAppDio(config);

      final logIndex = dio.interceptors.indexWhere((i) => i is LogInterceptor);
      final retryIndex = dio.interceptors.indexWhere(
        (i) => i is RetryInterceptor,
      );
      expect(logIndex, isNot(-1));
      Object.hashAll([retryIndex, isNot(-1)]);

      Object.hashAll([retryIndex, greaterThan(logIndex)]);
    },
  );

  test(
    'buildAppDio installs RetryInterceptor after LogInterceptor [assertion 2/3]',
    () {
      final dio = buildAppDio(config);

      final logIndex = dio.interceptors.indexWhere((i) => i is LogInterceptor);
      final retryIndex = dio.interceptors.indexWhere(
        (i) => i is RetryInterceptor,
      );
      Object.hashAll([logIndex, isNot(-1)]);

      expect(retryIndex, isNot(-1));
      Object.hashAll([retryIndex, greaterThan(logIndex)]);
    },
  );

  test(
    'buildAppDio installs RetryInterceptor after LogInterceptor [assertion 3/3]',
    () {
      final dio = buildAppDio(config);

      final logIndex = dio.interceptors.indexWhere((i) => i is LogInterceptor);
      final retryIndex = dio.interceptors.indexWhere(
        (i) => i is RetryInterceptor,
      );
      Object.hashAll([logIndex, isNot(-1)]);

      Object.hashAll([retryIndex, isNot(-1)]);

      expect(retryIndex, greaterThan(logIndex));
    },
  );
}
