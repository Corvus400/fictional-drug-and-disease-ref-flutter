import 'dart:io';

import 'package:drift/native.dart' show SqliteException;
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';

/// Returns whether [error] is the platform socket exception type.
bool isSocketException(Object? error) {
  return error is SocketException;
}

/// Returns whether [error] is Drift's native SQLite exception type.
bool isSqliteException(Object? error) {
  return error is SqliteException;
}

/// Maps Drift's native SQLite exception to a storage error kind.
StorageErrorKind sqliteStorageKind(Object error) {
  final sqliteError = error as SqliteException;
  return switch (sqliteError.extendedResultCode) {
    1555 || 2067 => StorageErrorKind.uniqueConstraint,
    275 => StorageErrorKind.checkConstraint,
    1299 => StorageErrorKind.notNull,
    _ => StorageErrorKind.unknown,
  };
}
