import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';

/// Repository for disease search and detail retrieval.
final class DiseaseRepository {
  /// Creates a disease repository.
  const DiseaseRepository(this._apiClient);

  final DiseaseApiClient _apiClient;

  /// Fetches a paginated disease list.
  Future<Result<DiseaseListPage>> getDiseases([
    DiseaseSearchParams params = const DiseaseSearchParams(),
  ]) async {
    try {
      final response = await _apiClient.getDiseases(
        page: params.page,
        pageSize: params.pageSize,
        icd10Chapter: params.icd10Chapter,
        department: params.department,
        chronicity: params.chronicity,
        infectious: params.infectious,
        keyword: params.keyword,
        keywordMatch: params.keywordMatch?.serialName,
        keywordTarget: params.keywordTarget?.serialName,
        symptomKeyword: params.symptomKeyword,
        onsetPattern: params.onsetPattern,
        examCategory: params.examCategory,
        hasPharmacologicalTreatment: params.hasPharmacologicalTreatment,
        hasSeverityGrading: params.hasSeverityGrading,
        sort: params.sort?.serialName,
      );
      return Result.ok(response.toDomain());
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Fetches a single disease detail.
  Future<Result<Disease>> getDisease(String id) async {
    try {
      final response = await _apiClient.getDisease(id);
      return Result.ok(response.toDomain());
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
