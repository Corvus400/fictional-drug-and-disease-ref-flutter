import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/api_client_factory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App API Dio provider.
final dioProvider = Provider<Dio>((ref) => buildAppDio(ApiConfig.current));

/// Image API Dio provider.
final imageDioProvider = Provider<Dio>((ref) {
  final dio = buildAppDio(ApiConfig.current);
  dio.options.responseType = ResponseType.bytes;
  return dio;
});
