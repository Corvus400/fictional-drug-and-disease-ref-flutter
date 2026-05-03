import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/categories_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';

/// Repository for filter category master data.
final class CategoriesRepository {
  /// Creates a categories repository.
  CategoriesRepository(this._apiClient);

  final CategoryApiClient _apiClient;

  Categories? _cached;

  /// Fetches filter categories, using an in-memory cache by default.
  Future<Result<Categories>> getCategories({bool forceRefresh = false}) async {
    final cached = _cached;
    if (cached != null && !forceRefresh) {
      return Result.ok(cached);
    }

    try {
      final response = await _apiClient.getCategories();
      final categories = response.toDomain();
      _cached = categories;
      return Result.ok(categories);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
