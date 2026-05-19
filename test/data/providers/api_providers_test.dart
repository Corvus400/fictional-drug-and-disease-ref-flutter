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

  test(
    'imageDioProvider returns Dio with bytes responseType [assertion 1/2]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final dio = container.read(imageDioProvider);

      expect(dio.options.baseUrl, ApiConfig.current.apiBaseUrl);
      Object.hashAll([dio.options.responseType, ResponseType.bytes]);
    },
  );

  test(
    'imageDioProvider returns Dio with bytes responseType [assertion 2/2]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final dio = container.read(imageDioProvider);

      Object.hashAll([dio.options.baseUrl, ApiConfig.current.apiBaseUrl]);

      expect(dio.options.responseType, ResponseType.bytes);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 1/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(drugApiClientProvider), isA<DrugApiClient>());
      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 2/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      expect(container.read(diseaseApiClientProvider), isA<DiseaseApiClient>());
      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 3/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      expect(
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      );
      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 4/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      expect(container.read(imageApiServiceProvider), isA<ImageApiService>());
      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 5/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      expect(container.read(drugRepositoryProvider), isA<DrugRepository>());
      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 6/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      expect(
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      );
      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 7/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      expect(
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      );
      Object.hashAll([
        container.read(imageRepositoryProvider),
        isA<ImageRepository>(),
      ]);
    },
  );

  test(
    'API client and repository providers return typed instances [assertion 8/8]',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      Object.hashAll([
        container.read(drugApiClientProvider),
        isA<DrugApiClient>(),
      ]);

      Object.hashAll([
        container.read(diseaseApiClientProvider),
        isA<DiseaseApiClient>(),
      ]);

      Object.hashAll([
        container.read(categoryApiClientProvider),
        isA<CategoryApiClient>(),
      ]);

      Object.hashAll([
        container.read(imageApiServiceProvider),
        isA<ImageApiService>(),
      ]);

      Object.hashAll([
        container.read(drugRepositoryProvider),
        isA<DrugRepository>(),
      ]);

      Object.hashAll([
        container.read(diseaseRepositoryProvider),
        isA<DiseaseRepository>(),
      ]);

      Object.hashAll([
        container.read(categoriesRepositoryProvider),
        isA<CategoriesRepository>(),
      ]);

      expect(container.read(imageRepositoryProvider), isA<ImageRepository>());
    },
  );
}
