import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/categories_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/image_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/image_api_service.dart';
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

  test('API client and repository providers return typed instances', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(drugApiClientProvider), isA<DrugApiClient>());
    expect(container.read(diseaseApiClientProvider), isA<DiseaseApiClient>());
    expect(container.read(categoryApiClientProvider), isA<CategoryApiClient>());
    expect(container.read(imageApiServiceProvider), isA<ImageApiService>());
    expect(container.read(drugRepositoryProvider), isA<DrugRepository>());
    expect(container.read(diseaseRepositoryProvider), isA<DiseaseRepository>());
    expect(
      container.read(categoriesRepositoryProvider),
      isA<CategoriesRepository>(),
    );
    expect(container.read(imageRepositoryProvider), isA<ImageRepository>());
  });
}
