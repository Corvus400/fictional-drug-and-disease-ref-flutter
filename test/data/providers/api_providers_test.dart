import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  test('dioProvider returns Dio with ApiConfig.current.apiBaseUrl', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final dio = container.read(dioProvider);

    expect(dio.options.baseUrl, ApiConfig.current.apiBaseUrl);
  });

  test('imageDioProvider returns Dio with bytes responseType', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final dio = container.read(imageDioProvider);

    expect(dio.options.baseUrl, ApiConfig.current.apiBaseUrl);
    expect(dio.options.responseType, ResponseType.bytes);
  });
}
