import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';

/// Paginated disease list result.
final class DiseaseListPage {
  /// Creates a paginated disease list result.
  const DiseaseListPage({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
    required this.disclaimer,
  });

  /// Disease summaries.
  final List<DiseaseSummary> items;

  /// Current page.
  final int page;

  /// Page size.
  final int pageSize;

  /// Total page count.
  final int totalPages;

  /// Total item count.
  final int totalCount;

  /// Response disclaimer.
  final String disclaimer;
}
