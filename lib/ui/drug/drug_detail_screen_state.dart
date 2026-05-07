import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';

/// Tabs shown on the drug detail screen.
enum DrugDetailTab {
  /// Overview tab.
  overview,

  /// Dosage tab.
  dose,

  /// Cautions and interactions tab.
  caution,

  /// Adverse effects tab.
  adverseEffects,

  /// Pharmacokinetics tab.
  pharmacokinetics,

  /// Related entities tab.
  related,
}

/// Loading state for the drug detail screen.
sealed class DrugDetailPhase {
  const DrugDetailPhase();
}

/// Detail data is being loaded.
final class DrugDetailLoadingPhase extends DrugDetailPhase {
  /// Creates a loading phase.
  const DrugDetailLoadingPhase();
}

/// Detail data was loaded from the API.
final class DrugDetailLoadedPhase extends DrugDetailPhase {
  /// Creates a loaded phase.
  const DrugDetailLoadedPhase(this.drug);

  /// Loaded drug detail.
  final Drug drug;
}

/// Detail data failed to load.
final class DrugDetailErrorPhase extends DrugDetailPhase {
  /// Creates an error phase.
  const DrugDetailErrorPhase(this.error);

  /// Load error.
  final AppException error;
}

/// UI state for the drug detail screen.
final class DrugDetailScreenState {
  /// Creates a drug detail state.
  const DrugDetailScreenState({
    required this.phase,
    required this.activeTab,
    required this.isBookmarked,
    required this.isBookmarkBusy,
    required this.bookmarkError,
  });

  /// Initial state before detail loading completes.
  const DrugDetailScreenState.initial()
    : phase = const DrugDetailLoadingPhase(),
      activeTab = DrugDetailTab.overview,
      isBookmarked = false,
      isBookmarkBusy = false,
      bookmarkError = null;

  /// Current load phase.
  final DrugDetailPhase phase;

  /// Currently selected tab.
  final DrugDetailTab activeTab;

  /// Whether the drug is currently bookmarked.
  final bool isBookmarked;

  /// Whether a bookmark mutation is in flight.
  final bool isBookmarkBusy;

  /// Latest bookmark mutation error, if any.
  final AppException? bookmarkError;

  /// Returns a copy with selected fields replaced.
  DrugDetailScreenState copyWith({
    DrugDetailPhase? phase,
    DrugDetailTab? activeTab,
    bool? isBookmarked,
    bool? isBookmarkBusy,
    AppException? bookmarkError,
    bool clearBookmarkError = false,
  }) {
    return DrugDetailScreenState(
      phase: phase ?? this.phase,
      activeTab: activeTab ?? this.activeTab,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isBookmarkBusy: isBookmarkBusy ?? this.isBookmarkBusy,
      bookmarkError: clearBookmarkError
          ? null
          : bookmarkError ?? this.bookmarkError,
    );
  }
}
