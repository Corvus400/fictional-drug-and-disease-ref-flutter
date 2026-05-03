import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/categories_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/image_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/api_client_factory.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/image_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App API Dio provider.
final dioProvider = Provider<Dio>((ref) => buildAppDio(ApiConfig.current));

/// Image API Dio provider.
final imageDioProvider = Provider<Dio>((ref) {
  final dio = buildAppDio(ApiConfig.current);
  dio.options.responseType = ResponseType.bytes;
  return dio;
});

/// Drug API client provider.
final drugApiClientProvider = Provider<DrugApiClient>(
  (ref) => DrugApiClient(ref.watch(dioProvider)),
);

/// Disease API client provider.
final diseaseApiClientProvider = Provider<DiseaseApiClient>(
  (ref) => DiseaseApiClient(ref.watch(dioProvider)),
);

/// Category API client provider.
final categoryApiClientProvider = Provider<CategoryApiClient>(
  (ref) => CategoryApiClient(ref.watch(dioProvider)),
);

/// Image API service provider.
final imageApiServiceProvider = Provider<ImageApiService>(
  (ref) => ImageApiService(ref.watch(imageDioProvider)),
);

/// Drug repository provider.
final drugRepositoryProvider = Provider<DrugRepository>(
  (ref) => DrugRepository(ref.watch(drugApiClientProvider)),
);

/// Disease repository provider.
final diseaseRepositoryProvider = Provider<DiseaseRepository>(
  (ref) => DiseaseRepository(ref.watch(diseaseApiClientProvider)),
);

/// Categories repository provider.
final categoriesRepositoryProvider = Provider<CategoriesRepository>(
  (ref) => CategoriesRepository(ref.watch(categoryApiClientProvider)),
);

/// Image repository provider.
final imageRepositoryProvider = Provider<ImageRepository>(
  (ref) => ImageRepository(ref.watch(imageApiServiceProvider)),
);
