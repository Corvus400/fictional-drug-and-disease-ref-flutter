import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'disease_api_client.g.dart';

/// Retrofit API client for disease endpoints.
@RestApi()
abstract class DiseaseApiClient {
  /// Creates a disease API client.
  factory DiseaseApiClient(Dio dio, {String? baseUrl}) = _DiseaseApiClient;

  /// Fetches paginated diseases.
  @GET('/v1/diseases')
  Future<DiseaseListResponseDto> getDiseases({
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('icd10_chapter') List<String>? icd10Chapter,
    @Query('department') List<String>? department,
    @Query('chronicity') List<String>? chronicity,
    @Query('infectious') bool? infectious,
    @Query('keyword') String? keyword,
    @Query('keyword_match') String? keywordMatch,
    @Query('keyword_target') String? keywordTarget,
    @Query('symptom_keyword') String? symptomKeyword,
    @Query('onset_pattern') List<String>? onsetPattern,
    @Query('exam_category') List<String>? examCategory,
    @Query('has_pharmacological_treatment') bool? hasPharmacologicalTreatment,
    @Query('has_severity_grading') bool? hasSeverityGrading,
    @Query('sort') String? sort,
  });

  /// Fetches a disease by id.
  @GET('/v1/diseases/{id}')
  Future<DiseaseDto> getDisease(@Path('id') String id);
}
