part of '../search_view.dart';

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
      return Column(
        children: [
          _SearchResultToolbar(
            state: state,
            totalCount: 0,
            onChangeDrugSort: onChangeDrugSort,
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.manage_search,
                        size: 48,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.searchEmptyResultTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => unawaited(onResetFilter()),
                        child: Text(l10n.searchEmptyResetFilter),
                      ),
                      OutlinedButton(
                        onPressed: () => unawaited(onRemoveOneChip()),
                        child: Text(l10n.searchEmptyRemoveOneFilter),
                      ),
                      TextButton(
                        onPressed: () => unawaited(onChangeMatchToPartial()),
                        child: Text(l10n.searchEmptyChangeMatchToPartial),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
      if (state.historyDropdownOpen) {
        return const SizedBox.shrink();
      }
      if (state.queryText.isEmpty && state.historyForTab.isEmpty) {
        return const _NoSearchHistoryState();
      }
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          _SearchResultToolbar(
            state: state,
            totalCount: view.totalCount,
            onChangeDrugSort: onChangeDrugSort,
          ),
          switch (view) {
            DrugSearchResultsView(:final items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final item in items) _DrugResultCard(item: item),
              ],
            ),
            DiseaseSearchResultsView(:final items) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final item in items) _DiseaseResultCard(item: item),
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

class _NoSearchHistoryState extends StatelessWidget {
  const _NoSearchHistoryState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: palette.surfaceSubtle,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(Icons.history, size: 22),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.searchHistoryEmptyTitle,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.searchHistoryEmptyDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
