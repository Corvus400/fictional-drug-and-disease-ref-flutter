import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/retry_interceptor.dart';

/// Builds the app-wide Dio client.
Dio buildAppDio(FlavorConfig config) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      listFormat: ListFormat.multi,
    ),
  );
  // Keep responseBody explicit so payloads stay out of logs
  // if dio defaults change.
  // ignore: avoid_redundant_argument_values
  dio.interceptors.add(LogInterceptor(responseBody: false));
  dio.interceptors.add(RetryInterceptor(dio: dio));
  return dio;
}
