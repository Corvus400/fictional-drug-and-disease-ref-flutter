import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/search/search_history_envelope.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_search_params.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Search tab view.
class SearchView extends ConsumerWidget {
  /// Creates a search view.
  const SearchView({super.key, this.healthCheck});

  /// Deprecated compatibility parameter. Search UI no longer performs health
  /// checks from the view layer.
  final Future<String>? healthCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchScreenProvider);
    final notifier = ref.read(searchScreenProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(title: Text(l10n.tabSearch)),
      floatingActionButton: Badge(
        isLabelVisible: state.appliedChips.count > 0,
        label: Text('+${state.appliedChips.count}'),
        child: FloatingActionButton(
          onPressed: () => _showFilterSheet(context),
          child: const Icon(Icons.tune),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<SearchTab>(
                segments: [
                  ButtonSegment(
                    value: SearchTab.drugs,
                    label: Text(l10n.searchTabDrugs),
                  ),
                  ButtonSegment(
                    value: SearchTab.diseases,
                    label: Text(l10n.searchTabDiseases),
                  ),
                ],
                selected: {state.tab},
                onSelectionChanged: (selection) {
                  unawaited(notifier.changeTab(selection.single));
                },
              ),
              const SizedBox(height: 12),
              TextField(
                key: const ValueKey('search-field'),
                onTap: () {
                  notifier.openHistoryDropdown();
                  unawaited(notifier.loadHistory());
                },
                onChanged: notifier.changeQueryText,
                onSubmitted: (_) => notifier.performSearch(),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: state.tab == SearchTab.drugs
                      ? l10n.searchHintDrugs
                      : l10n.searchHintDiseases,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: state.queryText.isEmpty
                      ? null
                      : IconButton(
                          onPressed: notifier.clearQueryText,
                          icon: const Icon(Icons.cancel),
                        ),
                  border: const OutlineInputBorder(),
                ),
              ),
              if (state.historyDropdownOpen)
                _SearchHistoryDropdown(
                  entries: state.historyForTab,
                  onDelete: notifier.deleteHistory,
                  onClearAll: notifier.clearAllHistory,
                ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: notifier.performSearch,
                  child: Text(l10n.searchActionSearch),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _SearchPhaseSection(
                  state: state,
                  onRetry: notifier.performSearch,
                  onResetFilter: notifier.resetFilter,
                  onRemoveOneChip: notifier.removeOneChip,
                  onChangeMatchToPartial: notifier.changeMatchToPartial,
                  onChangeDrugSort: notifier.changeDrugSort,
                  onLoadMore: notifier.loadMore,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.searchFilterTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.searchFilterApply),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchPhaseSection extends StatelessWidget {
  const _SearchPhaseSection({
    required this.state,
    required this.onRetry,
    required this.onResetFilter,
    required this.onRemoveOneChip,
    required this.onChangeMatchToPartial,
    required this.onChangeDrugSort,
    required this.onLoadMore,
  });

  final SearchScreenState state;
  final Future<void> Function() onRetry;
  final Future<void> Function() onResetFilter;
  final Future<void> Function() onRemoveOneChip;
  final Future<void> Function() onChangeMatchToPartial;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;
  final Future<void> Function() onLoadMore;

  @override
  Widget build(BuildContext context) {
    final phase = state.phase;
    final l10n = AppLocalizations.of(context)!;
    if (phase is SearchPhaseLoading) {
      return Skeletonizer(
        child: ListView.builder(
          itemCount: SearchConstants.searchShimmerSkeletonCount,
          itemBuilder: (context, index) => const Card(
            key: ValueKey('search-loading-skeleton-card'),
            child: SizedBox(height: 72),
          ),
        ),
      );
    }
    if (phase is SearchPhaseEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.searchEmptyResultTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => unawaited(onResetFilter()),
              child: Text(l10n.searchEmptyResetFilter),
            ),
            TextButton(
              onPressed: () => unawaited(onRemoveOneChip()),
              child: Text(l10n.searchEmptyRemoveOneFilter),
            ),
            TextButton(
              onPressed: () => unawaited(onChangeMatchToPartial()),
              child: Text(l10n.searchEmptyChangeMatchToPartial),
            ),
          ],
        ),
      );
    }
    if (phase is SearchPhaseError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.searchErrorTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => unawaited(onRetry()),
              child: Text(l10n.searchErrorRetry),
            ),
          ],
        ),
      );
    }
    final view = switch (phase) {
      SearchPhaseResults(:final view) => view,
      SearchPhaseLoadingMore(:final previous) => previous,
      _ => null,
    };
    if (view == null) {
      return const SizedBox.shrink();
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is! ScrollUpdateNotification ||
            notification.dragDetails == null) {
          return false;
        }
        final metrics = notification.metrics;
        final nearEnd =
            metrics.maxScrollExtent > 0 &&
            metrics.pixels >= metrics.maxScrollExtent - 200;
        if (view.canLoadMore && nearEnd) {
          unawaited(onLoadMore());
        }
        return false;
      },
      child: ListView(
        key: const ValueKey('search-results-list'),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Text(l10n.searchToolbarTotal(view.totalCount)),
                const Spacer(),
                TextButton(
                  onPressed: () => _showSortSheet(
                    context,
                    state.tab,
                    onChangeDrugSort: onChangeDrugSort,
                  ),
                  child: Text(l10n.searchSortTitle),
                ),
              ],
            ),
          ),
          switch (view) {
            DrugSearchResultsView(:final items) => Column(
              children: [
                for (final item in items)
                  Card(
                    child: ListTile(
                      title: Text(item.brandName),
                      subtitle: Text(item.genericName),
                    ),
                  ),
              ],
            ),
            DiseaseSearchResultsView(:final items) => Column(
              children: [
                for (final item in items)
                  Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.nameKana),
                    ),
                  ),
              ],
            ),
          },
          if (view.canLoadMore)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text(l10n.searchToolbarLoadMore)),
            ),
        ],
      ),
    );
  }
}

void _showSortSheet(
  BuildContext context,
  SearchTab tab, {
  required Future<void> Function(DrugSort sort) onChangeDrugSort,
}) {
  final l10n = AppLocalizations.of(context)!;
  final drugLabels = {
    DrugSort.revisedAtDesc: l10n.searchSortByRevised,
    DrugSort.brandNameKana: l10n.searchSortByBrandKana,
    DrugSort.atcCode: l10n.searchSortByAtcCode,
    DrugSort.therapeuticCategoryName: l10n.searchSortByTherapeuticCategory,
  };
  unawaited(
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tab == SearchTab.drugs)
              for (final entry in drugLabels.entries)
                ListTile(
                  title: Text(entry.value),
                  onTap: () {
                    Navigator.of(context).pop();
                    unawaited(onChangeDrugSort(entry.key));
                  },
                )
            else
              ListTile(
                title: Text(l10n.searchSortByRevised),
                onTap: () => Navigator.of(context).pop(),
              ),
          ],
        ),
      ),
    ),
  );
}

class _SearchHistoryDropdown extends StatelessWidget {
  const _SearchHistoryDropdown({
    required this.entries,
    required this.onDelete,
    required this.onClearAll,
  });

  final List<SearchHistoryEnvelope> entries;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 4),
                  child: Text(
                    l10n.searchHistoryTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              TextButton(
                key: const ValueKey('clear-history-button'),
                onPressed: () => unawaited(_confirmClearHistory(context)),
                child: Text(l10n.searchHistoryClear),
              ),
            ],
          ),
          for (final entry in entries)
            ListTile(
              dense: true,
              title: Text(entry.queryText),
              subtitle: Text(l10n.searchToolbarTotal(entry.totalCount)),
              trailing: IconButton(
                key: ValueKey('delete-history-${entry.id}'),
                onPressed: () => unawaited(onDelete(entry.id)),
                icon: const Icon(Icons.close),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmClearHistory(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.searchHistoryClearConfirmTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.searchActionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.searchHistoryClearConfirmDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await onClearAll();
    }
  }
}
