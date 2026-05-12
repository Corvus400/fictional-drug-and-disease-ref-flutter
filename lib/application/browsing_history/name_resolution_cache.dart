import 'dart:collection';

/// Small in-memory LRU cache for browsing-history name resolution results.
final class NameResolutionCache {
  /// Creates the cache.
  NameResolutionCache({this.capacity = 200})
    : assert(capacity > 0, 'capacity must be positive');

  /// Maximum number of cached entries.
  final int capacity;

  final _values = LinkedHashMap<String, Object>();

  /// Reads a cached value and promotes it to most-recently used.
  Object? get(String id) {
    final value = _values.remove(id);
    if (value == null) {
      return null;
    }
    _values[id] = value;
    return value;
  }

  /// Writes a cached value.
  void put(String id, Object value) {
    _values.remove(id);
    _values[id] = value;
    while (_values.length > capacity) {
      _values.remove(_values.keys.first);
    }
  }
}
