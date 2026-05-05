import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/categories_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';

/// Loads filter category master data.
final class LoadCategoriesUsecase {
  /// Creates the use case.
  const LoadCategoriesUsecase(this._repository);

  final CategoriesRepository _repository;

  /// Executes category master loading.
  Future<Result<Categories>> execute({bool forceRefresh = false}) {
    return _repository.getCategories(forceRefresh: forceRefresh);
  }
}
