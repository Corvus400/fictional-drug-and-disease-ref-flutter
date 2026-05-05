import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Search target tab.
enum SearchTab {
  /// Drug search.
  drugs,

  /// Disease search.
  diseases,
}

/// Search screen state.
final class SearchScreenState {
  /// Creates state.
  const SearchScreenState({
    required this.tab,
    required this.queryText,
    required this.drugParams,
    required this.diseaseParams,
    required this.phase,
    required this.historyForTab,
    required this.historyDropdownOpen,
    required this.appliedChips,
  });

  /// Initial state.
  factory SearchScreenState.initial() => const SearchScreenState(
    tab: SearchTab.drugs,
    queryText: '',
    drugParams: DrugSearchParams(page: 1, pageSize: 20),
    diseaseParams: DiseaseSearchParams(page: 1, pageSize: 20),
    phase: SearchPhase.idle(),
    historyForTab: [],
    historyDropdownOpen: false,
    appliedChips: AppliedFilterChips([]),
  );

  /// Active tab.
  final SearchTab tab;

  /// Current field text.
  final String queryText;

  /// Drug params.
  final DrugSearchParams drugParams;

  /// Disease params.
  final DiseaseSearchParams diseaseParams;

  /// Current phase.
  final SearchPhase phase;

  /// Decoded history rows for the active tab.
  final List<SearchHistoryEnvelope> historyForTab;

  /// Whether history dropdown is open.
  final bool historyDropdownOpen;

  /// Applied filter chips.
  final AppliedFilterChips appliedChips;

  /// Copies state.
  SearchScreenState copyWith({
    SearchTab? tab,
    String? queryText,
    DrugSearchParams? drugParams,
    DiseaseSearchParams? diseaseParams,
    SearchPhase? phase,
    List<SearchHistoryEnvelope>? historyForTab,
    bool? historyDropdownOpen,
    AppliedFilterChips? appliedChips,
  }) {
    return SearchScreenState(
      tab: tab ?? this.tab,
      queryText: queryText ?? this.queryText,
      drugParams: drugParams ?? this.drugParams,
      diseaseParams: diseaseParams ?? this.diseaseParams,
      phase: phase ?? this.phase,
      historyForTab: historyForTab ?? this.historyForTab,
      historyDropdownOpen: historyDropdownOpen ?? this.historyDropdownOpen,
      appliedChips: appliedChips ?? this.appliedChips,
    );
  }
}

/// Search phase.
sealed class SearchPhase {
  const SearchPhase();

  /// Idle.
  const factory SearchPhase.idle() = SearchPhaseIdle;

  /// First-page loading.
  const factory SearchPhase.loading() = SearchPhaseLoading;

  /// Additional page loading.
  const factory SearchPhase.loadingMore({
    required SearchResultsView previous,
  }) = SearchPhaseLoadingMore;

  /// Has results.
  const factory SearchPhase.results(SearchResultsView view) =
      SearchPhaseResults;

  /// Empty result.
  const factory SearchPhase.empty({required AppliedFilterChips chips}) =
      SearchPhaseEmpty;

  /// Error result.
  const factory SearchPhase.error({
    required AppException error,
    required String requestLabel,
  }) = SearchPhaseError;
}

/// Idle phase.
final class SearchPhaseIdle extends SearchPhase {
  /// Creates idle phase.
  const SearchPhaseIdle();
}

/// Loading phase.
final class SearchPhaseLoading extends SearchPhase {
  /// Creates loading phase.
  const SearchPhaseLoading();
}

/// Loading-more phase.
final class SearchPhaseLoadingMore extends SearchPhase {
  /// Creates loading-more phase.
  const SearchPhaseLoadingMore({required this.previous});

  /// Previous visible results.
  final SearchResultsView previous;
}

/// Results phase.
final class SearchPhaseResults extends SearchPhase {
  /// Creates results phase.
  const SearchPhaseResults(this.view);

  /// Result view.
  final SearchResultsView view;
}

/// Empty phase.
final class SearchPhaseEmpty extends SearchPhase {
  /// Creates empty phase.
  const SearchPhaseEmpty({required this.chips});

  /// Applied chips at empty state.
  final AppliedFilterChips chips;
}

/// Error phase.
final class SearchPhaseError extends SearchPhase {
  /// Creates error phase.
  const SearchPhaseError({required this.error, required this.requestLabel});

  /// App error.
  final AppException error;

  /// Non-sensitive request label.
  final String requestLabel;
}

/// Result list view.
sealed class SearchResultsView {
  const SearchResultsView({
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
  });

  /// Current page.
  final int page;

  /// Page size.
  final int pageSize;

  /// Total pages.
  final int totalPages;

  /// Total count.
  final int totalCount;

  /// Whether another page can be loaded.
  bool get canLoadMore => page < totalPages;
}

/// Drug results.
final class DrugSearchResultsView extends SearchResultsView {
  /// Creates drug results.
  const DrugSearchResultsView({
    required this.items,
    required super.page,
    required super.pageSize,
    required super.totalPages,
    required super.totalCount,
  });

  /// Drug items.
  final List<DrugSummary> items;
}

/// Disease results.
final class DiseaseSearchResultsView extends SearchResultsView {
  /// Creates disease results.
  const DiseaseSearchResultsView({
    required this.items,
    required super.page,
    required super.pageSize,
    required super.totalPages,
    required super.totalCount,
  });

  /// Disease items.
  final List<DiseaseSummary> items;
}

/// Applied filter chips.
final class AppliedFilterChips {
  /// Creates chips.
  const AppliedFilterChips(this.items);

  /// Chip items.
  final List<AppliedChip> items;

  /// Active chip count.
  int get count => items.length;
}

/// Applied chip.
final class AppliedChip {
  /// Creates chip.
  const AppliedChip({required this.axis, required this.label});

  /// Filter axis id.
  final String axis;

  /// Display label.
  final String label;
}
