import 'dart:io' as io;

import 'package:fictional_drug_and_disease_ref/core/logging/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Cache manager that keeps the resized image entry and removes the original.
class ResizedImageCacheManager extends CacheManager with ImageCacheManager {
  /// Returns the shared resized image cache manager.
  factory ResizedImageCacheManager() {
    return _instance ??= ResizedImageCacheManager._();
  }

  ResizedImageCacheManager._() : super(Config(_key));

  /// Creates a manager with a custom config for tests.
  @visibleForTesting
  ResizedImageCacheManager.testing(super.config);

  static const _key = 'resizedImageCache';
  static ResizedImageCacheManager? _instance;

  /// Gets a resized image file and removes the original cache entry.
  Future<io.File> resizedFile({
    required String url,
    required String originalKey,
    required int maxWidth,
    required int maxHeight,
  }) async {
    final fileInfo = await imageFileResponses(
      url: url,
      key: originalKey,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    ).where((response) => response is FileInfo).cast<FileInfo>().last;
    try {
      await removeOriginalFile(originalKey);
    } on Object catch (error, stackTrace) {
      logOriginalRemovalFailure(originalKey, error, stackTrace);
    }
    return io.File(fileInfo.file.path);
  }

  /// Wrapper around [getImageFile] so the contract can be unit-tested.
  @visibleForTesting
  Stream<FileResponse> imageFileResponses({
    required String url,
    required String key,
    required int maxWidth,
    required int maxHeight,
  }) {
    return getImageFile(
      url,
      key: key,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
  }

  /// Wrapper around [removeFile] so the contract can be unit-tested.
  @visibleForTesting
  Future<void> removeOriginalFile(String key) {
    return removeFile(key);
  }

  /// Logs removal failures without failing image rendering.
  @visibleForTesting
  void logOriginalRemovalFailure(
    String originalKey,
    Object error,
    StackTrace stackTrace,
  ) {
    appLogger.w(
      {
        'message': 'failed to remove original cached image',
        'cacheKey': originalKey,
      },
      error: error,
      stackTrace: stackTrace,
    );
  }
}
