import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_list_page.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Search screen notifier provider.
final searchScreenProvider =
    NotifierProvider<SearchScreenNotifier, SearchScreenState>(
      SearchScreenNotifier.new,
    );

/// ViewModel for the search screen.
final class SearchScreenNotifier extends Notifier<SearchScreenState> {
  @override
  SearchScreenState build() {
    final initial = SearchScreenState.initial();
    unawaited(Future.microtask(loadHistory));
    return initial;
  }

  /// Changes active tab and reloads tab-specific history.
  Future<void> changeTab(SearchTab tab) async {
    state = state.copyWith(
      tab: tab,
      phase: const SearchPhase.idle(),
      appliedChips: const AppliedFilterChips([]),
    );
    await loadHistory();
  }

  /// Updates query text without running live search.
  void changeQueryText(String value) {
    state = state.copyWith(
      queryText: value,
      drugParams: _copyDrugParams(state.drugParams, keyword: value),
      diseaseParams: _copyDiseaseParams(state.diseaseParams, keyword: value),
    );
  }

  /// Clears only the query text.
  void clearQueryText() {
    changeQueryText('');
  }

  /// Opens history dropdown.
  void openHistoryDropdown() {
    state = state.copyWith(historyDropdownOpen: true);
  }

  /// Closes history dropdown.
  void closeHistoryDropdown() {
    state = state.copyWith(historyDropdownOpen: false);
  }

  /// Loads history for the active tab.
  Future<void> loadHistory() async {
    final target = state.tab == SearchTab.drugs ? 'drug' : 'disease';
    final result = await ref
        .read(listSearchHistoryUsecaseProvider)
        .execute(
          target,
        );
    if (result case Ok(:final value)) {
      state = state.copyWith(historyForTab: value);
    }
  }

  /// Performs first-page search.
  Future<void> performSearch() async {
    state = state.copyWith(phase: const SearchPhase.loading());
    if (state.tab == SearchTab.drugs) {
      final params = _copyDrugParams(
        state.drugParams,
        page: 1,
        pageSize: SearchConstants.searchPageSize,
        keyword: state.queryText,
      );
      state = state.copyWith(drugParams: params);
      final result = await ref.read(searchDrugsUsecaseProvider).execute(params);
      state = state.copyWith(phase: _drugPhase(result, '検索: 医薬品'));
    } else {
      final params = _copyDiseaseParams(
        state.diseaseParams,
        page: 1,
        pageSize: SearchConstants.searchPageSize,
        keyword: state.queryText,
      );
      state = state.copyWith(diseaseParams: params);
      final result = await ref
          .read(searchDiseasesUsecaseProvider)
          .execute(params);
      state = state.copyWith(phase: _diseasePhase(result, '検索: 疾患'));
    }
    await loadHistory();
  }

  /// Loads next page if possible.
  Future<void> loadMore() async {
    final phase = state.phase;
    if (phase is! SearchPhaseResults || !phase.view.canLoadMore) {
      return;
    }
    state = state.copyWith(
      phase: SearchPhase.loadingMore(previous: phase.view),
    );
    if (phase.view is DrugSearchResultsView) {
      final previous = phase.view as DrugSearchResultsView;
      final params = _copyDrugParams(state.drugParams, page: previous.page + 1);
      final result = await ref.read(searchDrugsUsecaseProvider).execute(params);
      if (result case Ok<DrugListPage>(:final value)) {
        state = state.copyWith(
          drugParams: params,
          phase: SearchPhase.results(
            _drugResults(value, previousItems: previous.items),
          ),
        );
      }
      return;
    }
    final previous = phase.view as DiseaseSearchResultsView;
    final params = _copyDiseaseParams(
      state.diseaseParams,
      page: previous.page + 1,
    );
    final result = await ref
        .read(searchDiseasesUsecaseProvider)
        .execute(params);
    if (result case Ok<DiseaseListPage>(:final value)) {
      state = state.copyWith(
        diseaseParams: params,
        phase: SearchPhase.results(
          _diseaseResults(value, previousItems: previous.items),
        ),
      );
    }
  }

  /// Applies drug filter values and searches immediately.
  Future<void> applyDrugFilter({
    List<String>? regulatoryClass,
    List<String>? dosageForm,
  }) async {
    state = state.copyWith(
      drugParams: _copyDrugParams(
        state.drugParams,
        page: 1,
        regulatoryClass: regulatoryClass,
        dosageForm: dosageForm,
      ),
      appliedChips: _drugChips(
        regulatoryClass: regulatoryClass,
        dosageForm: dosageForm,
      ),
    );
    await performSearch();
  }

  /// Resets filters and searches immediately.
  Future<void> resetFilter() async {
    state = state.copyWith(
      drugParams: DrugSearchParams(
        page: 1,
        pageSize: SearchConstants.searchPageSize,
        keyword: state.queryText,
      ),
      diseaseParams: DiseaseSearchParams(
        page: 1,
        pageSize: SearchConstants.searchPageSize,
        keyword: state.queryText,
      ),
      appliedChips: const AppliedFilterChips([]),
    );
    await performSearch();
  }

  /// Removes the latest applied chip and searches.
  Future<void> removeOneChip() async {
    final items = state.appliedChips.items;
    if (items.isEmpty) {
      return;
    }
    final next = items.sublist(0, items.length - 1);
    state = state.copyWith(appliedChips: AppliedFilterChips(next));
    await performSearch();
  }

  /// Switches keyword match to partial and searches.
  Future<void> changeMatchToPartial() async {
    state = state.copyWith(
      drugParams: _copyDrugParams(
        state.drugParams,
        keywordMatch: KeywordMatch.partial,
      ),
      diseaseParams: _copyDiseaseParams(
        state.diseaseParams,
        keywordMatch: KeywordMatch.partial,
      ),
    );
    await performSearch();
  }

  /// Changes sort and searches.
  Future<void> changeDrugSort(DrugSort sort) async {
    state = state.copyWith(
      drugParams: _copyDrugParams(state.drugParams, page: 1, sort: sort),
    );
    await performSearch();
  }

  /// Selects a history row, restores params, and searches immediately.
  Future<void> selectHistory(SearchHistoryEnvelope history) async {
    switch (history) {
      case DrugSearchHistoryEnvelope(:final params):
        state = state.copyWith(
          tab: SearchTab.drugs,
          queryText: params.keyword ?? '',
          drugParams: params,
          historyDropdownOpen: false,
        );
      case DiseaseSearchHistoryEnvelope(:final params):
        state = state.copyWith(
          tab: SearchTab.diseases,
          queryText: params.keyword ?? '',
          diseaseParams: params,
          historyDropdownOpen: false,
        );
    }
    await performSearch();
  }

  /// Deletes a history row and refreshes history.
  Future<void> deleteHistory(String id) async {
    await ref.read(deleteSearchHistoryUsecaseProvider).execute(id);
    await loadHistory();
  }

  /// Clears all history rows for active tab and refreshes history.
  Future<void> clearAllHistory() async {
    final target = state.tab == SearchTab.drugs ? 'drug' : 'disease';
    await ref.read(clearSearchHistoryUsecaseProvider).execute(target);
    await loadHistory();
  }
}

SearchPhase _drugPhase(Result<DrugListPage> result, String requestLabel) {
  return switch (result) {
    Ok(:final value) when value.items.isEmpty => const SearchPhase.empty(
      chips: AppliedFilterChips([]),
    ),
    Ok(:final value) => SearchPhase.results(_drugResults(value)),
    Err(:final error) => SearchPhase.error(
      error: error,
      requestLabel: requestLabel,
    ),
  };
}

SearchPhase _diseasePhase(
  Result<DiseaseListPage> result,
  String requestLabel,
) {
  return switch (result) {
    Ok(:final value) when value.items.isEmpty => const SearchPhase.empty(
      chips: AppliedFilterChips([]),
    ),
    Ok(:final value) => SearchPhase.results(_diseaseResults(value)),
    Err(:final error) => SearchPhase.error(
      error: error,
      requestLabel: requestLabel,
    ),
  };
}

DrugSearchResultsView _drugResults(
  DrugListPage page, {
  List<DrugSummary> previousItems = const [],
}) {
  return DrugSearchResultsView(
    items: [...previousItems, ...page.items],
    page: page.page,
    pageSize: page.pageSize,
    totalPages: page.totalPages,
    totalCount: page.totalCount,
  );
}

DiseaseSearchResultsView _diseaseResults(
  DiseaseListPage page, {
  List<DiseaseSummary> previousItems = const [],
}) {
  return DiseaseSearchResultsView(
    items: [...previousItems, ...page.items],
    page: page.page,
    pageSize: page.pageSize,
    totalPages: page.totalPages,
    totalCount: page.totalCount,
  );
}

AppliedFilterChips _drugChips({
  List<String>? regulatoryClass,
  List<String>? dosageForm,
}) {
  final chips = <AppliedChip>[
    for (final value in regulatoryClass ?? <String>[])
      AppliedChip(axis: 'regulatoryClass', label: value),
    for (final value in dosageForm ?? <String>[])
      AppliedChip(axis: 'dosageForm', label: value),
  ];
  return AppliedFilterChips(chips);
}

DrugSearchParams _copyDrugParams(
  DrugSearchParams params, {
  int? page,
  int? pageSize,
  String? keyword,
  KeywordMatch? keywordMatch,
  DrugSort? sort,
  List<String>? regulatoryClass,
  List<String>? dosageForm,
}) {
  return DrugSearchParams(
    page: page ?? params.page,
    pageSize: pageSize ?? params.pageSize,
    categoryAtc: params.categoryAtc,
    therapeuticCategory: params.therapeuticCategory,
    regulatoryClass: regulatoryClass ?? params.regulatoryClass,
    dosageForm: dosageForm ?? params.dosageForm,
    route: params.route,
    keyword: keyword ?? params.keyword,
    keywordMatch: keywordMatch ?? params.keywordMatch,
    keywordTarget: params.keywordTarget,
    adverseReactionKeyword: params.adverseReactionKeyword,
    precautionCategory: params.precautionCategory,
    sort: sort ?? params.sort,
  );
}

DiseaseSearchParams _copyDiseaseParams(
  DiseaseSearchParams params, {
  int? page,
  int? pageSize,
  String? keyword,
  KeywordMatch? keywordMatch,
}) {
  return DiseaseSearchParams(
    page: page ?? params.page,
    pageSize: pageSize ?? params.pageSize,
    icd10Chapter: params.icd10Chapter,
    department: params.department,
    chronicity: params.chronicity,
    infectious: params.infectious,
    keyword: keyword ?? params.keyword,
    keywordMatch: keywordMatch ?? params.keywordMatch,
    keywordTarget: params.keywordTarget,
    symptomKeyword: params.symptomKeyword,
    onsetPattern: params.onsetPattern,
    examCategory: params.examCategory,
    hasPharmacologicalTreatment: params.hasPharmacologicalTreatment,
    hasSeverityGrading: params.hasSeverityGrading,
    sort: params.sort,
  );
}
