import 'package:fictional_drug_and_disease_ref/domain/disease/disease_search_params.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';

/// Search history entry decoded for UI display.
sealed class SearchHistoryEnvelope {
  const SearchHistoryEnvelope({
    required this.id,
    required this.queryText,
    required this.filterCount,
    required this.searchedAt,
    required this.totalCount,
  });

  /// Persisted history id.
  final String id;

  /// User-facing query text.
  final String queryText;

  /// Active filter count.
  final int filterCount;

  /// Search timestamp.
  final DateTime searchedAt;

  /// Total count returned by the original search.
  final int totalCount;
}

/// Drug history entry.
final class DrugSearchHistoryEnvelope extends SearchHistoryEnvelope {
  /// Creates a drug history entry.
  const DrugSearchHistoryEnvelope({
    required super.id,
    required super.queryText,
    required this.params,
    required super.filterCount,
    required super.searchedAt,
    required super.totalCount,
  });

  /// Restored drug search params.
  final DrugSearchParams params;
}

/// Disease history entry.
final class DiseaseSearchHistoryEnvelope extends SearchHistoryEnvelope {
  /// Creates a disease history entry.
  const DiseaseSearchHistoryEnvelope({
    required super.id,
    required super.queryText,
    required this.params,
    required super.filterCount,
    required super.searchedAt,
    required super.totalCount,
  });

  /// Restored disease search params.
  final DiseaseSearchParams params;
}
