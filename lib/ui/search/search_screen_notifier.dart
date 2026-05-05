import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/category/categories.dart';
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

  /// Loads category master data used by filter sheets.
  Future<void> loadCategories({bool forceRefresh = false}) async {
    if (state.categories != null && !forceRefresh) {
      return;
    }
    final result = await ref
        .read(loadCategoriesUsecaseProvider)
        .execute(forceRefresh: forceRefresh);
    if (result case Ok<Categories>(:final value)) {
      state = state.copyWith(categories: value);
    }
  }

  /// Performs first-page search.
  Future<void> performSearch() async {
    state = state.copyWith(
      phase: const SearchPhase.loading(),
      historyDropdownOpen: false,
    );
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
    String? categoryAtc,
    String? therapeuticCategory,
    List<String>? regulatoryClass,
    List<String>? dosageForm,
    List<String>? route,
    String? adverseReactionKeyword,
    List<String>? precautionCategory,
  }) async {
    state = state.copyWith(
      drugParams: _copyDrugParams(
        state.drugParams,
        page: 1,
        categoryAtc: categoryAtc,
        therapeuticCategory: therapeuticCategory,
        regulatoryClass: regulatoryClass,
        dosageForm: dosageForm,
        route: route,
        adverseReactionKeyword: adverseReactionKeyword,
        precautionCategory: precautionCategory,
      ),
      appliedChips: _drugChips(
        categoryAtc: categoryAtc,
        therapeuticCategory: therapeuticCategory,
        regulatoryClass: regulatoryClass,
        dosageForm: dosageForm,
        route: route,
        adverseReactionKeyword: adverseReactionKeyword,
        precautionCategory: precautionCategory,
      ),
    );
    await performSearch();
  }

  /// Applies disease filter values and searches immediately.
  Future<void> applyDiseaseFilter({
    List<String>? icd10Chapter,
    List<String>? department,
    List<String>? chronicity,
    bool? infectious,
    String? symptomKeyword,
    List<String>? onsetPattern,
    List<String>? examCategory,
    bool? hasPharmacologicalTreatment,
    bool? hasSeverityGrading,
  }) async {
    state = state.copyWith(
      diseaseParams: _copyDiseaseParams(
        state.diseaseParams,
        page: 1,
        icd10Chapter: icd10Chapter,
        department: department,
        chronicity: chronicity,
        infectious: infectious,
        symptomKeyword: symptomKeyword,
        onsetPattern: onsetPattern,
        examCategory: examCategory,
        hasPharmacologicalTreatment: hasPharmacologicalTreatment,
        hasSeverityGrading: hasSeverityGrading,
      ),
      appliedChips: _diseaseChips(
        icd10Chapter: icd10Chapter,
        department: department,
        chronicity: chronicity,
        infectious: infectious,
        symptomKeyword: symptomKeyword,
        onsetPattern: onsetPattern,
        examCategory: examCategory,
        hasPharmacologicalTreatment: hasPharmacologicalTreatment,
        hasSeverityGrading: hasSeverityGrading,
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

  /// Removes the oldest applied chip and searches.
  Future<void> removeOneChip() async {
    await removeChipAt(0);
  }

  /// Removes one applied chip by index and searches.
  Future<void> removeChipAt(int index) async {
    final items = state.appliedChips.items;
    if (index < 0 || index >= items.length) {
      return;
    }
    final chip = items[index];
    final next = [...items]..removeAt(index);
    if (state.tab == SearchTab.drugs) {
      state = state.copyWith(
        drugParams: _drugParamsWithoutChip(state.drugParams, chip),
        appliedChips: AppliedFilterChips(next),
      );
    } else {
      state = state.copyWith(
        diseaseParams: _diseaseParamsWithoutChip(state.diseaseParams, chip),
        appliedChips: AppliedFilterChips(next),
      );
    }
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

  /// Changes disease sort and searches.
  Future<void> changeDiseaseSort(DiseaseSort sort) async {
    state = state.copyWith(
      diseaseParams: _copyDiseaseParams(
        state.diseaseParams,
        page: 1,
        sort: sort,
      ),
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
  String? categoryAtc,
  String? therapeuticCategory,
  List<String>? regulatoryClass,
  List<String>? dosageForm,
  List<String>? route,
  String? adverseReactionKeyword,
  List<String>? precautionCategory,
}) {
  final chips = <AppliedChip>[
    if (categoryAtc != null)
      AppliedChip(axis: 'categoryAtc', label: categoryAtc),
    if (therapeuticCategory != null)
      AppliedChip(axis: 'therapeuticCategory', label: therapeuticCategory),
    for (final value in regulatoryClass ?? <String>[])
      AppliedChip(axis: 'regulatoryClass', label: value),
    for (final value in dosageForm ?? <String>[])
      AppliedChip(axis: 'dosageForm', label: value),
    for (final value in route ?? <String>[])
      AppliedChip(axis: 'route', label: value),
    if (adverseReactionKeyword != null && adverseReactionKeyword.isNotEmpty)
      AppliedChip(
        axis: 'adverseReactionKeyword',
        label: adverseReactionKeyword,
      ),
    for (final value in precautionCategory ?? <String>[])
      AppliedChip(axis: 'precautionCategory', label: value),
  ];
  return AppliedFilterChips(chips);
}

AppliedFilterChips _diseaseChips({
  List<String>? icd10Chapter,
  List<String>? department,
  List<String>? chronicity,
  bool? infectious,
  String? symptomKeyword,
  List<String>? onsetPattern,
  List<String>? examCategory,
  bool? hasPharmacologicalTreatment,
  bool? hasSeverityGrading,
}) {
  final chips = <AppliedChip>[
    for (final value in icd10Chapter ?? <String>[])
      AppliedChip(axis: 'icd10Chapter', label: value),
    for (final value in department ?? <String>[])
      AppliedChip(axis: 'department', label: value),
    for (final value in chronicity ?? <String>[])
      AppliedChip(axis: 'chronicity', label: value),
    if (infectious != null)
      AppliedChip(axis: 'infectious', label: infectious.toString()),
    if (symptomKeyword != null && symptomKeyword.isNotEmpty)
      AppliedChip(axis: 'symptomKeyword', label: symptomKeyword),
    for (final value in onsetPattern ?? <String>[])
      AppliedChip(axis: 'onsetPattern', label: value),
    for (final value in examCategory ?? <String>[])
      AppliedChip(axis: 'examCategory', label: value),
    if (hasPharmacologicalTreatment != null)
      AppliedChip(
        axis: 'hasPharmacologicalTreatment',
        label: hasPharmacologicalTreatment.toString(),
      ),
    if (hasSeverityGrading != null)
      AppliedChip(
        axis: 'hasSeverityGrading',
        label: hasSeverityGrading.toString(),
      ),
  ];
  return AppliedFilterChips(chips);
}

DrugSearchParams _drugParamsWithoutChip(
  DrugSearchParams params,
  AppliedChip chip,
) {
  return DrugSearchParams(
    page: 1,
    pageSize: params.pageSize,
    categoryAtc: chip.axis == 'categoryAtc' ? null : params.categoryAtc,
    therapeuticCategory: chip.axis == 'therapeuticCategory'
        ? null
        : params.therapeuticCategory,
    regulatoryClass: chip.axis == 'regulatoryClass'
        ? _filteredOrNull(params.regulatoryClass, chip.label)
        : params.regulatoryClass,
    dosageForm: chip.axis == 'dosageForm'
        ? _filteredOrNull(params.dosageForm, chip.label)
        : params.dosageForm,
    route: chip.axis == 'route'
        ? _filteredOrNull(params.route, chip.label)
        : params.route,
    keyword: params.keyword,
    keywordMatch: params.keywordMatch,
    keywordTarget: params.keywordTarget,
    adverseReactionKeyword: chip.axis == 'adverseReactionKeyword'
        ? null
        : params.adverseReactionKeyword,
    precautionCategory: chip.axis == 'precautionCategory'
        ? _filteredOrNull(params.precautionCategory, chip.label)
        : params.precautionCategory,
    sort: params.sort,
  );
}

DiseaseSearchParams _diseaseParamsWithoutChip(
  DiseaseSearchParams params,
  AppliedChip chip,
) {
  return DiseaseSearchParams(
    page: 1,
    pageSize: params.pageSize,
    icd10Chapter: chip.axis == 'icd10Chapter'
        ? _filteredOrNull(params.icd10Chapter, chip.label)
        : params.icd10Chapter,
    department: chip.axis == 'department'
        ? _filteredOrNull(params.department, chip.label)
        : params.department,
    chronicity: chip.axis == 'chronicity'
        ? _filteredOrNull(params.chronicity, chip.label)
        : params.chronicity,
    infectious: chip.axis == 'infectious' ? null : params.infectious,
    keyword: params.keyword,
    keywordMatch: params.keywordMatch,
    keywordTarget: params.keywordTarget,
    symptomKeyword: chip.axis == 'symptomKeyword'
        ? null
        : params.symptomKeyword,
    onsetPattern: chip.axis == 'onsetPattern'
        ? _filteredOrNull(params.onsetPattern, chip.label)
        : params.onsetPattern,
    examCategory: chip.axis == 'examCategory'
        ? _filteredOrNull(params.examCategory, chip.label)
        : params.examCategory,
    hasPharmacologicalTreatment: chip.axis == 'hasPharmacologicalTreatment'
        ? null
        : params.hasPharmacologicalTreatment,
    hasSeverityGrading: chip.axis == 'hasSeverityGrading'
        ? null
        : params.hasSeverityGrading,
    sort: params.sort,
  );
}

List<String>? _filteredOrNull(List<String>? values, String value) {
  if (values == null) {
    return null;
  }
  final next = values.where((item) => item != value).toList();
  return next.isEmpty ? null : next;
}

DrugSearchParams _copyDrugParams(
  DrugSearchParams params, {
  int? page,
  int? pageSize,
  String? keyword,
  KeywordMatch? keywordMatch,
  DrugSort? sort,
  String? categoryAtc,
  String? therapeuticCategory,
  List<String>? regulatoryClass,
  List<String>? dosageForm,
  List<String>? route,
  String? adverseReactionKeyword,
  List<String>? precautionCategory,
}) {
  return DrugSearchParams(
    page: page ?? params.page,
    pageSize: pageSize ?? params.pageSize,
    categoryAtc: categoryAtc ?? params.categoryAtc,
    therapeuticCategory: therapeuticCategory ?? params.therapeuticCategory,
    regulatoryClass: regulatoryClass ?? params.regulatoryClass,
    dosageForm: dosageForm ?? params.dosageForm,
    route: route ?? params.route,
    keyword: keyword ?? params.keyword,
    keywordMatch: keywordMatch ?? params.keywordMatch,
    keywordTarget: params.keywordTarget,
    adverseReactionKeyword:
        adverseReactionKeyword ?? params.adverseReactionKeyword,
    precautionCategory: precautionCategory ?? params.precautionCategory,
    sort: sort ?? params.sort,
  );
}

DiseaseSearchParams _copyDiseaseParams(
  DiseaseSearchParams params, {
  int? page,
  int? pageSize,
  String? keyword,
  KeywordMatch? keywordMatch,
  List<String>? icd10Chapter,
  List<String>? department,
  List<String>? chronicity,
  bool? infectious,
  String? symptomKeyword,
  List<String>? onsetPattern,
  List<String>? examCategory,
  bool? hasPharmacologicalTreatment,
  bool? hasSeverityGrading,
  DiseaseSort? sort,
}) {
  return DiseaseSearchParams(
    page: page ?? params.page,
    pageSize: pageSize ?? params.pageSize,
    icd10Chapter: icd10Chapter ?? params.icd10Chapter,
    department: department ?? params.department,
    chronicity: chronicity ?? params.chronicity,
    infectious: infectious ?? params.infectious,
    keyword: keyword ?? params.keyword,
    keywordMatch: keywordMatch ?? params.keywordMatch,
    keywordTarget: params.keywordTarget,
    symptomKeyword: symptomKeyword ?? params.symptomKeyword,
    onsetPattern: onsetPattern ?? params.onsetPattern,
    examCategory: examCategory ?? params.examCategory,
    hasPharmacologicalTreatment:
        hasPharmacologicalTreatment ?? params.hasPharmacologicalTreatment,
    hasSeverityGrading: hasSeverityGrading ?? params.hasSeverityGrading,
    sort: sort ?? params.sort,
  );
}
