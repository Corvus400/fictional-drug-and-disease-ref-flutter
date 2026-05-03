import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'drug_api_client.g.dart';

/// Retrofit API client for drug endpoints.
@RestApi()
abstract class DrugApiClient {
  /// Creates a drug API client.
  factory DrugApiClient(Dio dio, {String? baseUrl}) = _DrugApiClient;

  /// Fetches paginated drugs.
  @GET('/v1/drugs')
  Future<DrugListResponseDto> getDrugs({
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('category_atc') String? categoryAtc,
    @Query('therapeutic_category') String? therapeuticCategory,
    @Query('regulatory_class') List<String>? regulatoryClass,
    @Query('dosage_form') List<String>? dosageForm,
    @Query('route') List<String>? route,
    @Query('keyword') String? keyword,
    @Query('keyword_match') String? keywordMatch,
    @Query('keyword_target') String? keywordTarget,
    @Query('adverse_reaction_keyword') String? adverseReactionKeyword,
    @Query('precaution_category') List<String>? precautionCategory,
    @Query('sort') String? sort,
  });

  /// Fetches a drug by id.
  @GET('/v1/drugs/{id}')
  Future<DrugDto> getDrug(@Path('id') String id);
}
