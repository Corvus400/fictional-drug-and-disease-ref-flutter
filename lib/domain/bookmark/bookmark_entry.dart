/// Persisted bookmark entry.
final class BookmarkEntry {
  /// Creates a bookmark entry.
  const BookmarkEntry({
    required this.id,
    required this.snapshotJson,
    required this.bookmarkedAt,
  });

  /// Bookmark target id.
  final String id;

  /// Serialized summary snapshot JSON.
  final String snapshotJson;

  /// Bookmark timestamp.
  final DateTime bookmarkedAt;
}
