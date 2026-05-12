import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_bookmark_rows_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bookmarks screen notifier provider.
// ignore: specify_nonobvious_property_types
final bookmarksScreenProvider =
    NotifierProvider.autoDispose<BookmarksScreenNotifier, BookmarksScreenState>(
      BookmarksScreenNotifier.new,
    );

/// ViewModel for the bookmarks screen.
final class BookmarksScreenNotifier extends Notifier<BookmarksScreenState> {
  BookmarksTab _selectedTab = BookmarksTab.all;
  String _searchQuery = '';
  int _generation = 0;
  List<BookmarkEntry> _entries = const [];
  List<BookmarksRow> _allRows = const [];
  List<BookmarkEntry>? _pendingLocalEntries;
  bool _hasLoadedEntries = false;

  @override
  BookmarksScreenState build() {
    ref.listen(bookmarksStreamProvider, (_, next) {
      if (next case AsyncData<List<BookmarkEntry>>(:final value)) {
        final pendingLocalEntries = _pendingLocalEntries;
        if (pendingLocalEntries != null &&
            _sameEntries(value, pendingLocalEntries)) {
          _pendingLocalEntries = null;
          _applyEntriesWithoutResolving(value);
          return;
        }
        if (_hasLoadedEntries && _sameEntries(value, _entries)) {
          return;
        }
        unawaited(_loadRows(value));
        return;
      }
      if (next case AsyncError(:final error)) {
        state = BookmarksError(
          selectedTab: _selectedTab,
          searchQuery: _searchQuery,
          cause: error,
        );
      }
    });
    final current = ref.read(bookmarksStreamProvider);
    if (current case AsyncError(:final error)) {
      return BookmarksError(
        selectedTab: _selectedTab,
        searchQuery: _searchQuery,
        cause: error,
      );
    }
    return BookmarksLoading(
      selectedTab: _selectedTab,
      searchQuery: _searchQuery,
    );
  }

  /// Selects a visible bookmarks tab.
  void selectTab(BookmarksTab tab) {
    _selectedTab = tab;
    state = _stateForRows(_allRows);
  }

  /// Updates the search query.
  void setSearchQuery(String query) {
    _searchQuery = query;
    state = _stateForRows(_allRows);
  }

  /// Deletes a single bookmark row.
  Future<void> deleteRow(String id) async {
    final nextEntries = _entries
        .where((entry) => entry.id != id)
        .toList(growable: false);
    _pendingLocalEntries = nextEntries;
    final result = await ref.read(deleteBookmarkUsecaseProvider).execute(id);
    if (result is Err<void>) {
      _pendingLocalEntries = null;
      return;
    }
    if (!ref.mounted) {
      return;
    }
    _pendingLocalEntries = null;
    _applyEntriesWithoutResolving(nextEntries);
  }

  /// Retries bookmark stream loading and snapshot decoding.
  void retry() {
    _generation += 1;
    _hasLoadedEntries = false;
    state = BookmarksLoading(
      selectedTab: _selectedTab,
      searchQuery: _searchQuery,
    );
    ref.invalidate(bookmarksStreamProvider);
  }

  Future<void> _loadRows(List<BookmarkEntry> entries) async {
    final generation = _generation + 1;
    _generation = generation;
    _entries = entries;
    _hasLoadedEntries = true;
    if (entries.isEmpty) {
      _allRows = const [];
      if (ref.mounted && generation == _generation) {
        state = BookmarksEmpty(
          selectedTab: _selectedTab,
          searchQuery: _searchQuery,
        );
      }
      return;
    }

    final result = ref
        .read(resolveBookmarkRowsUsecaseProvider)
        .execute(entries);
    if (!ref.mounted || generation != _generation) {
      return;
    }
    switch (result) {
      case Ok<List<ResolvedBookmarkRow>>(:final value):
        _allRows = value.map(_rowFor).toList(growable: false);
        state = _stateForRows(_allRows);
      case Err<List<ResolvedBookmarkRow>>(:final error):
        state = BookmarksError(
          selectedTab: _selectedTab,
          searchQuery: _searchQuery,
          visibleCount: entries.length,
          cause: error,
        );
    }
  }

  void _applyEntriesWithoutResolving(List<BookmarkEntry> entries) {
    _generation += 1;
    _entries = entries;
    _hasLoadedEntries = true;
    final ids = entries.map((entry) => entry.id).toSet();
    _allRows = _allRows
        .where((row) => ids.contains(row.id))
        .toList(growable: false);
    state = _stateForRows(_allRows);
  }

  BookmarksScreenState _stateForRows(List<BookmarksRow> rows) {
    if (rows.isEmpty) {
      return BookmarksEmpty(
        selectedTab: _selectedTab,
        searchQuery: _searchQuery,
      );
    }
    final visibleRows = rows.where(_matchesFilters).toList(growable: false);
    return BookmarksLoaded(
      selectedTab: _selectedTab,
      searchQuery: _searchQuery,
      visibleRows: visibleRows,
      visibleCount: visibleRows.length,
      isSearchZero: visibleRows.isEmpty,
    );
  }

  bool _matchesFilters(BookmarksRow row) {
    if (!_matchesSelectedTab(row)) {
      return false;
    }
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return true;
    }
    return switch (row) {
      BookmarksDrugRow(:final summary) =>
        summary.brandName.toLowerCase().contains(normalizedQuery) ||
            summary.genericName.toLowerCase().contains(normalizedQuery) ||
            summary.brandNameKana.toLowerCase().contains(normalizedQuery),
      BookmarksDiseaseRow(:final summary) =>
        summary.name.toLowerCase().contains(normalizedQuery) ||
            summary.nameKana.toLowerCase().contains(normalizedQuery),
    };
  }

  bool _matchesSelectedTab(BookmarksRow row) {
    return switch (_selectedTab) {
      BookmarksTab.all => true,
      BookmarksTab.drug => row is BookmarksDrugRow,
      BookmarksTab.disease => row is BookmarksDiseaseRow,
    };
  }
}

BookmarksRow _rowFor(ResolvedBookmarkRow row) {
  return switch (row) {
    ResolvedBookmarkDrugRow(:final id, :final bookmarkedAt, :final summary) =>
      BookmarksDrugRow(
        id: id,
        bookmarkedAt: bookmarkedAt,
        summary: summary,
      ),
    ResolvedBookmarkDiseaseRow(
      :final id,
      :final bookmarkedAt,
      :final summary,
    ) =>
      BookmarksDiseaseRow(
        id: id,
        bookmarkedAt: bookmarkedAt,
        summary: summary,
      ),
  };
}

bool _sameEntries(
  List<BookmarkEntry> left,
  List<BookmarkEntry> right,
) {
  if (left.length != right.length) {
    return false;
  }
  for (var index = 0; index < left.length; index += 1) {
    final leftEntry = left[index];
    final rightEntry = right[index];
    if (leftEntry.id != rightEntry.id ||
        leftEntry.snapshotJson != rightEntry.snapshotJson ||
        leftEntry.bookmarkedAt != rightEntry.bookmarkedAt) {
      return false;
    }
  }
  return true;
}
