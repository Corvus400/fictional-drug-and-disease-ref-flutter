import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Paginated drug list result.
final class DrugListPage {
  /// Creates a paginated drug list result.
  const DrugListPage({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalCount,
    required this.disclaimer,
  });

  /// Drug summaries.
  final List<DrugSummary> items;

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
