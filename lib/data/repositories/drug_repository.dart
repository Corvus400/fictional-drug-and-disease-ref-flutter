import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';

/// Repository for drug search and detail retrieval.
final class DrugRepository {
  /// Creates a drug repository.
  const DrugRepository(this._apiClient);

  final DrugApiClient _apiClient;

  /// Fetches a paginated drug list.
  Future<Result<DrugListPage>> getDrugs([
    DrugSearchParams params = const DrugSearchParams(),
  ]) async {
    try {
      final response = await _apiClient.getDrugs(
        page: params.page,
        pageSize: params.pageSize,
        categoryAtc: params.categoryAtc,
        therapeuticCategory: params.therapeuticCategory,
        regulatoryClass: params.regulatoryClass,
        dosageForm: params.dosageForm,
        route: params.route,
        keyword: params.keyword,
        keywordMatch: params.keywordMatch?.serialName,
        keywordTarget: params.keywordTarget?.serialName,
        adverseReactionKeyword: params.adverseReactionKeyword,
        precautionCategory: params.precautionCategory,
        sort: params.sort?.serialName,
      );
      return Result.ok(response.toDomain());
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Fetches a single drug detail.
  Future<Result<Drug>> getDrug(String id) async {
    try {
      final response = await _apiClient.getDrug(id);
      return Result.ok(response.toDomain());
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
