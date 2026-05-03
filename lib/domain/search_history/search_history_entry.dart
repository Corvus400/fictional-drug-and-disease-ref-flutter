/// Persisted search history entry.
final class SearchHistoryEntry {
  /// Creates a search history entry.
  const SearchHistoryEntry({
    required this.id,
    required this.target,
    required this.queryJson,
    required this.searchedAt,
    required this.totalCount,
  });

  /// Search history id.
  final String id;

  /// Search target.
  final String target;

  /// Serialized query JSON.
  final String queryJson;

  /// Search timestamp.
  final DateTime searchedAt;

  /// Total result count.
  final int totalCount;
}
