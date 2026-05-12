import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Browsing history filter tab.
enum HistoryTab {
  /// All history rows.
  all,

  /// Drug rows only.
  drug,

  /// Disease rows only.
  disease,
}

/// Browsing history screen state.
sealed class HistoryScreenState {
  const HistoryScreenState();
}

/// Initial local database load.
final class HistoryLoading extends HistoryScreenState {
  /// Creates loading state.
  const HistoryLoading();
}

/// History rows were loaded.
final class HistoryLoaded extends HistoryScreenState {
  /// Creates loaded state.
  const HistoryLoaded({
    required this.rows,
    required this.selectedTab,
    required this.hasNameFailure,
  });

  /// Visible rows after tab filtering.
  final List<HistoryRow> rows;

  /// Selected tab.
  final HistoryTab selectedTab;

  /// Whether any loaded row failed name resolution.
  final bool hasNameFailure;
}

/// No history rows exist.
final class HistoryEmpty extends HistoryScreenState {
  /// Creates empty state.
  const HistoryEmpty();
}

/// Display row for browsing history.
sealed class HistoryRow {
  const HistoryRow({
    required this.id,
    required this.viewedAt,
  });

  /// Target id.
  final String id;

  /// Last viewed timestamp.
  final DateTime viewedAt;
}

/// Drug history row.
final class HistoryDrugRow extends HistoryRow {
  /// Creates a drug row.
  const HistoryDrugRow({
    required super.id,
    required super.viewedAt,
    required this.summary,
  });

  /// Resolved drug summary.
  final DrugSummary summary;
}

/// Disease history row.
final class HistoryDiseaseRow extends HistoryRow {
  /// Creates a disease row.
  const HistoryDiseaseRow({
    required super.id,
    required super.viewedAt,
    required this.summary,
  });

  /// Resolved disease summary.
  final DiseaseSummary summary;
}

/// History row whose name could not be resolved.
final class HistoryUnresolvedRow extends HistoryRow {
  /// Creates an unresolved row.
  const HistoryUnresolvedRow({
    required super.id,
    required super.viewedAt,
  });
}
