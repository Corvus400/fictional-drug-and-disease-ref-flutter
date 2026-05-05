import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/search_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListSearchHistoryUsecase', () {
    late AppDatabase db;
    late SearchHistoryRepository repository;
    late ListSearchHistoryUsecase usecase;
    const codec = SearchQueryCodec();

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = SearchHistoryRepository(db.searchHistoriesDao);
      usecase = ListSearchHistoryUsecase(
        searchHistoryRepository: repository,
        codec: codec,
      );
    });

    tearDown(() async {
      await db.close();
    });

    test('execute decodes drug history into display envelope', () async {
      const params = DrugSearchParams(
        keyword: 'アムロ',
        regulatoryClass: ['poison'],
      );
      await repository.insertWithDedup(
        id: 'search_001',
        target: 'drug',
        queryJson: codec.encode(params),
        searchedAt: DateTime.utc(2026, 5, 5),
        totalCount: 12,
      );

      final result = await usecase.execute('drug');

      expect(result, isA<Ok<List<SearchHistoryEnvelope>>>());
      final envelopes = (result as Ok<List<SearchHistoryEnvelope>>).value;
      expect(envelopes.single, isA<DrugSearchHistoryEnvelope>());
      expect(envelopes.single.queryText, 'アムロ');
      expect(envelopes.single.filterCount, 1);
      expect(envelopes.single.totalCount, 12);
    });
  });
}
