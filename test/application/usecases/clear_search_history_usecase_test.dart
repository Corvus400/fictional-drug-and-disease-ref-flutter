import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/clear_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ClearSearchHistoryUsecase clears rows by target', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repository = SearchHistoryRepository(db.searchHistoriesDao);
    final usecase = ClearSearchHistoryUsecase(
      searchHistoryRepository: repository,
    );
    await repository.insertWithDedup(
      id: 'search_001',
      target: 'drug',
      queryJson: '{"keyword":"a"}',
      searchedAt: DateTime.utc(2026, 5, 5),
      totalCount: 1,
    );
    await repository.insertWithDedup(
      id: 'search_002',
      target: 'disease',
      queryJson: '{"keyword":"b"}',
      searchedAt: DateTime.utc(2026, 5, 5),
      totalCount: 1,
    );

    final result = await usecase.execute('drug');

    expect(result, isA<Ok<void>>());
    expect((await repository.findByTarget('drug') as Ok).value, isEmpty);
    expect(
      (await repository.findByTarget('disease') as Ok).value,
      hasLength(1),
    );
  });
}
