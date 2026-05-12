import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';

/// Repository for persisted bookmark snapshots.
final class BookmarkRepository {
  /// Creates a bookmark repository.
  const BookmarkRepository(this._dao);

  final BookmarksDao _dao;

  /// Inserts a bookmark snapshot.
  Future<Result<void>> insert({
    required String id,
    required String snapshotJson,
    required DateTime bookmarkedAt,
  }) async {
    try {
      await _dao.insertBookmark(
        BookmarksTableCompanion.insert(
          id: id,
          snapshot: snapshotJson,
          bookmarkedAt: bookmarkedAt,
        ),
      );
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Finds a bookmark snapshot by id.
  Future<Result<BookmarkEntry?>> findById(String id) async {
    try {
      final row = await _dao.findById(id);
      return Result.ok(row == null ? null : _toDomain(row));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Updates the stored bookmark snapshot JSON.
  Future<Result<void>> updateSnapshot(String id, String snapshotJson) async {
    try {
      await _dao.updateSnapshot(id, snapshotJson);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Deletes a bookmark by id.
  Future<Result<void>> deleteById(String id) async {
    try {
      await _dao.deleteById(id);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Finds all bookmarks ordered by newest first.
  Future<Result<List<BookmarkEntry>>> findAll({String? idPrefix}) async {
    try {
      final rows = await _dao.findAll(idPrefix: idPrefix);
      return Result.ok(rows.map(_toDomain).toList(growable: false));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Watches all bookmarks ordered by newest first.
  Stream<List<BookmarkEntry>> watchAll() {
    return _dao.watchAll().map(
      (rows) => rows.map(_toDomain).toList(growable: false),
    );
  }

  /// Returns whether a bookmark exists.
  Future<Result<bool>> existsById(String id) async {
    try {
      return Result.ok(await _dao.existsById(id));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Watches whether a bookmark exists.
  Stream<bool> watchExists(String id) {
    return _dao.watchExists(id);
  }
}

BookmarkEntry _toDomain(BookmarksTableData row) {
  return BookmarkEntry(
    id: row.id,
    snapshotJson: row.snapshot,
    bookmarkedAt: row.bookmarkedAt,
  );
}
