import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/platform_exception_classifier_unsupported.dart'
    if (dart.library.io) 'package:fictional_drug_and_disease_ref/core/error/platform_exception_classifier_io.dart'
    as impl;

/// Returns whether [error] is the platform socket exception type.
bool isSocketException(Object? error) {
  return impl.isSocketException(error);
}

/// Returns whether [error] is Drift's native SQLite exception type.
bool isSqliteException(Object? error) {
  return impl.isSqliteException(error);
}

/// Maps a platform SQLite exception to a storage error kind.
StorageErrorKind sqliteStorageKind(Object error) {
  return impl.sqliteStorageKind(error);
}
