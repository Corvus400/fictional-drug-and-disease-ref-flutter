import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Cache manager for drug card thumbnails.
final drugCardImageCacheManagerProvider = Provider<BaseCacheManager>(
  (ref) => DefaultCacheManager(),
);
