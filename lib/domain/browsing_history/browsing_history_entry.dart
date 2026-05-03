/// Persisted browsing history entry.
final class BrowsingHistoryEntry {
  /// Creates a browsing history entry.
  const BrowsingHistoryEntry({
    required this.id,
    required this.viewedAt,
  });

  /// Viewed target id.
  final String id;

  /// Last viewed timestamp.
  final DateTime viewedAt;
}
