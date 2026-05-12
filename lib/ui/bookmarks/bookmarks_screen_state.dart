import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';

/// Bookmarks filter tab.
enum BookmarksTab {
  /// All bookmark rows.
  all,

  /// Drug rows only.
  drug,

  /// Disease rows only.
  disease,
}

/// Bookmarks screen state.
sealed class BookmarksScreenState {
  const BookmarksScreenState({
    required this.selectedTab,
    required this.searchQuery,
  });

  /// Selected tab.
  final BookmarksTab selectedTab;

  /// Current search query.
  final String searchQuery;
}

/// Initial local database load.
final class BookmarksLoading extends BookmarksScreenState {
  /// Creates loading state.
  const BookmarksLoading({
    required super.selectedTab,
    required super.searchQuery,
  });
}

/// No bookmark rows exist.
final class BookmarksEmpty extends BookmarksScreenState {
  /// Creates empty state.
  const BookmarksEmpty({
    required super.selectedTab,
    required super.searchQuery,
  });
}

/// Bookmark rows were loaded.
final class BookmarksLoaded extends BookmarksScreenState {
  /// Creates loaded state.
  const BookmarksLoaded({
    required super.selectedTab,
    required super.searchQuery,
    required this.visibleRows,
    required this.visibleCount,
    required this.isSearchZero,
  });

  /// Visible rows after tab and search filtering.
  final List<BookmarksRow> visibleRows;

  /// Number of visible rows.
  final int visibleCount;

  /// Whether filtering produced no visible rows while bookmarks exist.
  final bool isSearchZero;
}

/// Bookmark rows could not be loaded or decoded.
final class BookmarksError extends BookmarksScreenState {
  /// Creates error state.
  const BookmarksError({
    required super.selectedTab,
    required super.searchQuery,
    this.visibleCount,
    this.cause,
  });

  /// Number of rows when the failed load had a known entry count.
  final int? visibleCount;

  /// Underlying error.
  final Object? cause;
}

/// Display row for bookmarks.
sealed class BookmarksRow {
  const BookmarksRow({
    required this.id,
    required this.bookmarkedAt,
  });

  /// Target id.
  final String id;

  /// Saved timestamp.
  final DateTime bookmarkedAt;
}

/// Drug bookmark row.
final class BookmarksDrugRow extends BookmarksRow {
  /// Creates a drug row.
  const BookmarksDrugRow({
    required super.id,
    required super.bookmarkedAt,
    required this.summary,
  });

  /// Resolved drug summary.
  final DrugSummary summary;
}

/// Disease bookmark row.
final class BookmarksDiseaseRow extends BookmarksRow {
  /// Creates a disease row.
  const BookmarksDiseaseRow({
    required super.id,
    required super.bookmarkedAt,
    required this.summary,
  });

  /// Resolved disease summary.
  final DiseaseSummary summary;
}
