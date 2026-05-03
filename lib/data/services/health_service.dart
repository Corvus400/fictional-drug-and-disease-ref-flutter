import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';

/// Smoke-test service for the mock-server health endpoint.
class HealthService {
  /// Creates a health service.
  const HealthService({required Dio client}) : _client = client;

  /// Creates a health service from the active API configuration.
  factory HealthService.fromConfig() {
    return HealthService(
      client: Dio(
        BaseOptions(
          baseUrl: ApiConfig.current.apiBaseUrl,
          connectTimeout: ApiConfig.connectTimeout,
          receiveTimeout: ApiConfig.receiveTimeout,
          responseType: ResponseType.plain,
        ),
      ),
    );
  }

  final Dio _client;

  /// Calls `/health` and returns a normalized health result.
  Future<String> ping() async {
    final response = await _client.get<String>('/health');
    final result = _normalize(response.data ?? '');
    logger.i('HEALTH_CHECK_RESULT: $result');
    return result;
  }

  String _normalize(String body) {
    final trimmed = body.trim();
    if (trimmed == 'OK') {
      return 'OK';
    }
    try {
      final json = jsonDecode(trimmed);
      if (json case {'status': 'ok'}) {
        return 'OK';
      }
    } on FormatException {
      return trimmed;
    }
    return trimmed;
  }
}
