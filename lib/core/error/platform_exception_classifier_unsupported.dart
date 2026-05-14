import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Returns whether [error] is the platform socket exception type.
bool isSocketException(Object? error) {
  return false;
}

/// Returns whether [error] is Drift's native SQLite exception type.
bool isSqliteException(Object? error) {
  return false;
}

/// Maps a platform SQLite exception to a storage error kind.
StorageErrorKind sqliteStorageKind(Object error) {
  return StorageErrorKind.unknown;
}
