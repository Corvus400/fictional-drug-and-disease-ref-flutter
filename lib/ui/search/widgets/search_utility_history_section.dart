part of '../search_view.dart';

class _SearchUtilityHistorySection extends StatelessWidget {
  const _SearchUtilityHistorySection({
    required this.entries,
    required this.currentTime,
    required this.palette,
    required this.onSelect,
    required this.onClearAll,
  });

  final List<SearchHistoryEnvelope> entries;
  final DateTime currentTime;
  final AppPalette palette;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final visibleEntries = entries.take(SearchConstants.searchHistoryMaxItems);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (entries.isEmpty)
          const _SearchUtilityNoHistoryState()
        else
          DecoratedBox(
            key: const ValueKey('search-utility-history-list'),
            decoration: BoxDecoration(
              color: palette.hairline2,
              borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Column(
                children: [
                  for (final (index, entry) in visibleEntries.indexed) ...[
                    if (index > 0)
                      SizedBox(
                        height: 1,
                        child: ColoredBox(color: palette.hairline2),
                      ),
                    _SearchUtilityHistoryRow(
                      entry: entry,
                      currentTime: currentTime,
                      palette: palette,
                      onSelect: onSelect,
                    ),
                  ],
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            key: const ValueKey('search-utility-history-clear'),
            onPressed: entries.isEmpty ? null : () => unawaited(onClearAll()),
            style: TextButton.styleFrom(
              foregroundColor: entries.isEmpty
                  ? palette.muted2
                  : palette.primary,
              minimumSize: const Size(0, 32),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              textStyle: theme.textTheme.labelSmall?.copyWith(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              l10n.searchHistoryClear,
              style: theme.textTheme.labelSmall?.copyWith(
                color: entries.isEmpty ? palette.muted2 : palette.primary,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchUtilityNoHistoryState extends StatelessWidget {
  const _SearchUtilityNoHistoryState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return Padding(
      key: const ValueKey('search-utility-history-empty'),
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            key: const ValueKey('search-utility-history-empty-icon'),
            width: 28,
            height: 28,
            child: Icon(Icons.history, size: 22, color: palette.muted2),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.searchHistoryEmptyTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.searchHistoryEmptyDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: palette.muted,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchUtilityHistoryRow extends StatelessWidget {
  const _SearchUtilityHistoryRow({
    required this.entry,
    required this.currentTime,
    required this.palette,
    required this.onSelect,
  });

  final SearchHistoryEnvelope entry;
  final DateTime currentTime;
  final AppPalette palette;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hasFilter = entry.filterCount > 0;
    return InkWell(
      key: ValueKey('search-utility-history-row-${entry.id}'),
      onTap: () => unawaited(onSelect(entry)),
      child: ColoredBox(
        color: palette.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 2),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      key: ValueKey('search-utility-history-query-${entry.id}'),
                      entry.queryText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    key: ValueKey('search-utility-history-count-${entry.id}'),
                    l10n.searchResultCountShort(entry.totalCount),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: palette.muted,
                      fontFeatures: const [FontFeature.tabularFigures()],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      key: ValueKey('search-utility-history-when-${entry.id}'),
                      formatRelativeTime(currentTime, entry.searchedAt, l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: palette.muted,
                        fontFeatures: const [FontFeature.tabularFigures()],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _SearchHistoryFilterBadge(
                    key: ValueKey(
                      hasFilter
                          ? 'search-utility-history-filter-${entry.id}'
                          : 'search-utility-history-filter-empty-${entry.id}',
                    ),
                    hasFilter: hasFilter,
                    palette: palette,
                    label: hasFilter
                        ? l10n.searchHistoryFilteredBadge
                        : l10n.searchHistoryNoFilterBadge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
