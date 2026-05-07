import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_query_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/clear_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/delete_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/list_search_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/load_categories_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmark_state_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_diseases_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/search_drugs_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/toggle_bookmark_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_drug_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

/// View-drug-detail use case provider.
final viewDrugDetailUsecaseProvider = Provider<ViewDrugDetailUsecase>(
  (ref) => ViewDrugDetailUsecase(
    drugRepository: ref.watch(drugRepositoryProvider),
    browsingHistoryRepository: ref.watch(browsingHistoryRepositoryProvider),
    bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
  ),
);

/// View-disease-detail use case provider.
final viewDiseaseDetailUsecaseProvider = Provider<ViewDiseaseDetailUsecase>(
  (ref) => ViewDiseaseDetailUsecase(
    diseaseRepository: ref.watch(diseaseRepositoryProvider),
    browsingHistoryRepository: ref.watch(browsingHistoryRepositoryProvider),
    bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
  ),
);

/// Observe-bookmark-state use case provider.
final observeBookmarkStateUsecaseProvider =
    Provider<ObserveBookmarkStateUsecase>(
      (ref) => ObserveBookmarkStateUsecase(
        bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
      ),
    );

/// Toggle-bookmark use case provider.
final toggleBookmarkUsecaseProvider = Provider<ToggleBookmarkUsecase>(
  (ref) => ToggleBookmarkUsecase(
    bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
    drugCodec: const DrugBookmarkSnapshotCodec(),
    diseaseCodec: const DiseaseBookmarkSnapshotCodec(),
  ),
);

/// Bookmark state stream provider for detail screens.
final StreamProviderFamily<bool, String> streamBookmarkStateProvider =
    StreamProvider.autoDispose.family<bool, String>(
      (ref, id) => ref.watch(observeBookmarkStateUsecaseProvider).execute(id),
    );

/// Search query codec provider.
final searchQueryCodecProvider = Provider<SearchQueryCodec>(
  (ref) => const SearchQueryCodec(),
);

/// Load-categories use case provider.
final loadCategoriesUsecaseProvider = Provider<LoadCategoriesUsecase>(
  (ref) => LoadCategoriesUsecase(ref.watch(categoriesRepositoryProvider)),
);

/// Search-drugs use case provider.
final searchDrugsUsecaseProvider = Provider<SearchDrugsUsecase>(
  (ref) => SearchDrugsUsecase(
    drugRepository: ref.watch(drugRepositoryProvider),
    searchHistoryRepository: ref.watch(searchHistoryRepositoryProvider),
    codec: ref.watch(searchQueryCodecProvider),
  ),
);

/// Search-diseases use case provider.
final searchDiseasesUsecaseProvider = Provider<SearchDiseasesUsecase>(
  (ref) => SearchDiseasesUsecase(
    diseaseRepository: ref.watch(diseaseRepositoryProvider),
    searchHistoryRepository: ref.watch(searchHistoryRepositoryProvider),
    codec: ref.watch(searchQueryCodecProvider),
  ),
);

/// List-search-history use case provider.
final listSearchHistoryUsecaseProvider = Provider<ListSearchHistoryUsecase>(
  (ref) => ListSearchHistoryUsecase(
    searchHistoryRepository: ref.watch(searchHistoryRepositoryProvider),
    codec: ref.watch(searchQueryCodecProvider),
  ),
);

/// Delete-search-history use case provider.
final deleteSearchHistoryUsecaseProvider = Provider<DeleteSearchHistoryUsecase>(
  (ref) => DeleteSearchHistoryUsecase(
    searchHistoryRepository: ref.watch(searchHistoryRepositoryProvider),
  ),
);

/// Clear-search-history use case provider.
final clearSearchHistoryUsecaseProvider = Provider<ClearSearchHistoryUsecase>(
  (ref) => ClearSearchHistoryUsecase(
    searchHistoryRepository: ref.watch(searchHistoryRepositoryProvider),
  ),
);
