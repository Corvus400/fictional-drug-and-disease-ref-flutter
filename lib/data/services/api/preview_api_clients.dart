import 'package:fictional_drug_and_disease_ref/data/dto/categories/categories_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_list_response_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';

/// Drug API client that keeps widget previews deterministic.
final class PreviewDrugApiClient implements DrugApiClient {
  /// Creates a preview drug API client.
  const PreviewDrugApiClient();

  @override
  Future<DrugDto> getDrug(String id) {
    return Future<DrugDto>.error(StateError('Preview drug API disabled: $id'));
  }

  @override
  Future<DrugListResponseDto> getDrugs({
    int? page,
    int? pageSize,
    String? categoryAtc,
    String? therapeuticCategory,
    List<String>? regulatoryClass,
    List<String>? dosageForm,
    List<String>? route,
    String? keyword,
    String? keywordMatch,
    String? keywordTarget,
    String? adverseReactionKeyword,
    List<String>? precautionCategory,
    String? sort,
  }) {
    return Future<DrugListResponseDto>.error(
      StateError('Preview drug search API disabled.'),
    );
  }
}

/// Disease API client that keeps widget previews deterministic.
final class PreviewDiseaseApiClient implements DiseaseApiClient {
  /// Creates a preview disease API client.
  const PreviewDiseaseApiClient();

  @override
  Future<DiseaseDto> getDisease(String id) {
    return Future<DiseaseDto>.error(
      StateError('Preview disease API disabled: $id'),
    );
  }

  @override
  Future<DiseaseListResponseDto> getDiseases({
    int? page,
    int? pageSize,
    List<String>? icd10Chapter,
    List<String>? department,
    List<String>? chronicity,
    bool? infectious,
    String? keyword,
    String? keywordMatch,
    String? keywordTarget,
    String? symptomKeyword,
    List<String>? onsetPattern,
    List<String>? examCategory,
    bool? hasPharmacologicalTreatment,
    bool? hasSeverityGrading,
    String? sort,
  }) {
    return Future<DiseaseListResponseDto>.error(
      StateError('Preview disease search API disabled.'),
    );
  }
}

/// Category API client that keeps widget previews deterministic.
final class PreviewCategoryApiClient implements CategoryApiClient {
  /// Creates a preview category API client.
  const PreviewCategoryApiClient();

  @override
  Future<CategoriesResponseDto> getCategories() {
    return Future<CategoriesResponseDto>.error(
      StateError('Preview category API disabled.'),
    );
  }
}
