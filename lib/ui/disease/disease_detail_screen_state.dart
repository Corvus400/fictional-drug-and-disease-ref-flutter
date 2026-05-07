import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';

/// Tabs shown on the disease detail screen.
enum DiseaseDetailTab {
  /// Overview tab.
  overview,

  /// Diagnosis tab.
  diagnosis,

  /// Treatment tab.
  treatment,

  /// Clinical course tab.
  clinicalCourse,

  /// Related entities tab.
  related,
}

/// Loading state for the disease detail screen.
sealed class DiseaseDetailPhase {
  const DiseaseDetailPhase();
}

/// Detail data is being loaded.
final class DiseaseDetailLoadingPhase extends DiseaseDetailPhase {
  /// Creates a loading phase.
  const DiseaseDetailLoadingPhase();
}

/// Detail data was loaded from the API.
final class DiseaseDetailLoadedPhase extends DiseaseDetailPhase {
  /// Creates a loaded phase.
  const DiseaseDetailLoadedPhase(this.disease);

  /// Loaded disease detail.
  final Disease disease;
}

/// Detail data failed to load.
final class DiseaseDetailErrorPhase extends DiseaseDetailPhase {
  /// Creates an error phase.
  const DiseaseDetailErrorPhase(this.error);

  /// Load error.
  final AppException error;
}

/// UI state for the disease detail screen.
final class DiseaseDetailScreenState {
  /// Creates a disease detail state.
  const DiseaseDetailScreenState({
    required this.phase,
    required this.activeTab,
    required this.isBookmarked,
    required this.isBookmarkBusy,
    required this.bookmarkError,
  });

  /// Initial state before detail loading completes.
  const DiseaseDetailScreenState.initial()
    : phase = const DiseaseDetailLoadingPhase(),
      activeTab = DiseaseDetailTab.overview,
      isBookmarked = false,
      isBookmarkBusy = false,
      bookmarkError = null;

  /// Current load phase.
  final DiseaseDetailPhase phase;

  /// Currently selected tab.
  final DiseaseDetailTab activeTab;

  /// Whether the disease is currently bookmarked.
  final bool isBookmarked;

  /// Whether a bookmark mutation is in flight.
  final bool isBookmarkBusy;

  /// Latest bookmark mutation error, if any.
  final AppException? bookmarkError;

  /// Returns a copy with selected fields replaced.
  DiseaseDetailScreenState copyWith({
    DiseaseDetailPhase? phase,
    DiseaseDetailTab? activeTab,
    bool? isBookmarked,
    bool? isBookmarkBusy,
    AppException? bookmarkError,
    bool clearBookmarkError = false,
  }) {
    return DiseaseDetailScreenState(
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
