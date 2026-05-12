import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/usecase_providers.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_browsing_history_names_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Browsing history screen notifier provider.
// ignore: specify_nonobvious_property_types
final historyScreenProvider =
    NotifierProvider.autoDispose<HistoryScreenNotifier, HistoryScreenState>(
      HistoryScreenNotifier.new,
    );

/// ViewModel for the browsing history screen.
final class HistoryScreenNotifier extends Notifier<HistoryScreenState> {
  HistoryTab _selectedTab = HistoryTab.all;
  int _generation = 0;
  List<BrowsingHistoryEntry> _entries = const [];
  List<HistoryRow> _allRows = const [];

  @override
  HistoryScreenState build() {
    ref.listen(browsingHistoryStreamProvider, (_, next) {
      if (next case AsyncData<List<BrowsingHistoryEntry>>(:final value)) {
        unawaited(_loadRows(value));
      }
    });
    return const HistoryLoading();
  }

  /// Selects a visible history tab.
  void selectTab(HistoryTab tab) {
    _selectedTab = tab;
    state = _stateForRows(_allRows);
  }

  /// Deletes a single history row.
  Future<void> deleteRow(String id) async {
    final result = await ref
        .read(deleteBrowsingHistoryUsecaseProvider)
        .execute(
          id,
        );
    if (result is Err<void> || !ref.mounted) {
      return;
    }
    await _loadRows(_entries.where((entry) => entry.id != id).toList());
  }

  /// Clears all history rows.
  Future<void> clearAll() async {
    final result = await ref
        .read(clearBrowsingHistoryUsecaseProvider)
        .execute();
    if (result is Err<void> || !ref.mounted) {
      return;
    }
    await _loadRows(const []);
  }

  /// Retries name resolution for rows that failed previously.
  Future<void> retryFailedNames() async {
    final unresolvedIds = _allRows
        .whereType<HistoryUnresolvedRow>()
        .map((row) => row.id)
        .toSet();
    if (unresolvedIds.isEmpty) {
      return;
    }
    final unresolvedEntries = _entries
        .where((entry) => unresolvedIds.contains(entry.id))
        .toList(growable: false);
    final resolutions = await ref
        .read(resolveBrowsingHistoryNamesUsecaseProvider)
        .execute(unresolvedEntries);
    if (!ref.mounted) {
      return;
    }
    _allRows = _allRows
        .map((row) {
          final resolution = resolutions[row.id];
          if (resolution == null || row is! HistoryUnresolvedRow) {
            return row;
          }
          return _rowFor(row.id, row.viewedAt, resolution);
        })
        .toList(growable: false);
    state = _stateForRows(_allRows);
  }

  Future<void> _loadRows(List<BrowsingHistoryEntry> entries) async {
    final generation = _generation + 1;
    _generation = generation;
    _entries = entries;
    if (entries.isEmpty) {
      _allRows = const [];
      if (ref.mounted && generation == _generation) {
        state = const HistoryEmpty();
      }
      return;
    }
    final resolutions = await ref
        .read(resolveBrowsingHistoryNamesUsecaseProvider)
        .execute(entries);
    if (!ref.mounted || generation != _generation) {
      return;
    }
    _allRows = entries
        .map(
          (entry) => _rowFor(entry.id, entry.viewedAt, resolutions[entry.id]),
        )
        .toList(growable: false);
    state = _stateForRows(_allRows);
  }

  HistoryScreenState _stateForRows(List<HistoryRow> rows) {
    if (rows.isEmpty) {
      return const HistoryEmpty();
    }
    final visibleRows = rows.where(_matchesSelectedTab).toList(growable: false);
    return HistoryLoaded(
      rows: visibleRows,
      selectedTab: _selectedTab,
      hasNameFailure: rows.any((row) => row is HistoryUnresolvedRow),
    );
  }

  bool _matchesSelectedTab(HistoryRow row) {
    return switch (_selectedTab) {
      HistoryTab.all => true,
      HistoryTab.drug => row is HistoryDrugRow,
      HistoryTab.disease => row is HistoryDiseaseRow,
    };
  }
}

HistoryRow _rowFor(
  String id,
  DateTime viewedAt,
  NameResolution? resolution,
) {
  return switch (resolution) {
    NameResolvedDrug(:final summary) => HistoryDrugRow(
      id: id,
      viewedAt: viewedAt,
      summary: summary,
    ),
    NameResolvedDisease(:final summary) => HistoryDiseaseRow(
      id: id,
      viewedAt: viewedAt,
      summary: summary,
    ),
    _ => HistoryUnresolvedRow(id: id, viewedAt: viewedAt),
  };
}
