import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api_client.g.dart';

/// Retrofit API client for category endpoints.
@RestApi()
// Retrofit clients must be abstract even when the API has a single method.
// ignore: one_member_abstracts
abstract class CategoryApiClient {
  /// Creates a category API client.
  factory CategoryApiClient(Dio dio, {String? baseUrl}) = _CategoryApiClient;

  /// Fetches all filter categories.
  @GET('/v1/categories')
  Future<CategoriesResponseDto> getCategories();
}
