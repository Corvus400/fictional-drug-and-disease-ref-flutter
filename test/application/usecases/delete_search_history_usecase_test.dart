import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DeleteSearchHistoryUsecase deletes one row by id', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repository = SearchHistoryRepository(db.searchHistoriesDao);
    final usecase = DeleteSearchHistoryUsecase(
      searchHistoryRepository: repository,
    );
    await repository.insertWithDedup(
      id: 'search_001',
      target: 'drug',
      queryJson: '{}',
      searchedAt: DateTime.utc(2026, 5, 5),
      totalCount: 1,
    );

    final result = await usecase.execute('search_001');

    expect(result, isA<Ok<void>>());
    expect((await repository.findByTarget('drug') as Ok).value, isEmpty);
  });
}
