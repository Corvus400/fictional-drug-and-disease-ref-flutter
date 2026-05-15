part of '../search_view.dart';

class _SearchInlineHistory extends StatelessWidget {
  const _SearchInlineHistory({
    required this.entries,
    required this.currentTime,
    required this.onSelect,
    required this.onDelete,
    required this.onClearAll,
  });

  final List<SearchHistoryEnvelope> entries;
  final DateTime currentTime;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final visibleEntries = entries.take(5).toList();
    return DecoratedBox(
      key: const ValueKey('search-history-inline'),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SearchConstants.searchCardRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.searchHistoryRecentTitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    key: const ValueKey('clear-history-button'),
                    onPressed: entries.isEmpty
                        ? null
                        : () => unawaited(_confirmClearHistory(context)),
                    child: Text(
                      l10n.searchHistoryClear,
                      style: TextStyle(
                        color: entries.isEmpty ? null : palette.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (entries.isEmpty)
              const Padding(
                key: ValueKey('search-history-inline-empty'),
                padding: EdgeInsets.fromLTRB(20, 18, 20, 24),
                child: _NoSearchHistoryState(),
              )
            else
              for (var index = 0; index < visibleEntries.length; index++) ...[
                if (index > 0)
                  Divider(
                    key: ValueKey(
                      'search-history-inline-divider-'
                      '${visibleEntries[index].id}',
                    ),
                    height: 0,
                    thickness: 0.5,
                    color: palette.hairline2,
                  ),
                _SearchHistoryRow(
                  entry: visibleEntries[index],
                  palette: palette,
                  currentTime: currentTime,
                  onSelect: onSelect,
                  onDelete: onDelete,
                ),
              ],
          ],
        ),
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

class _SearchHistoryRow extends StatelessWidget {
  const _SearchHistoryRow({
    required this.entry,
    required this.palette,
    required this.currentTime,
    required this.onSelect,
    required this.onDelete,
  });

  final SearchHistoryEnvelope entry;
  final AppPalette palette;
  final DateTime currentTime;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final hasFilter = entry.filterCount > 0;
    return Dismissible(
      key: ValueKey('history-row-dismiss-${entry.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => unawaited(onDelete(entry.id)),
      background: ColoredBox(
        color: palette.danger.withValues(alpha: 0.16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete_outline, color: palette.danger),
          ),
        ),
      ),
      child: InkWell(
        key: ValueKey('history-row-${entry.id}'),
        onTap: () => unawaited(onSelect(entry)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 64,
                child: Text(
                  key: ValueKey('history-row-when-${entry.id}'),
                  formatRelativeTime(currentTime, entry.searchedAt, l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: palette.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  key: ValueKey('history-row-query-${entry.id}'),
                  entry.queryText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _SearchHistoryFilterBadge(
                key: ValueKey(
                  hasFilter
                      ? 'history-row-filter-${entry.id}'
                      : 'history-row-filter-empty-${entry.id}',
                ),
                hasFilter: hasFilter,
                palette: palette,
                label: hasFilter
                    ? l10n.searchHistoryFilteredBadge
                    : l10n.searchHistoryNoFilterBadge,
              ),
              const SizedBox(width: 10),
              Text(
                key: ValueKey('history-row-count-${entry.id}'),
                '${entry.totalCount} 件',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: palette.muted,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchHistoryFilterBadge extends StatelessWidget {
  const _SearchHistoryFilterBadge({
    required this.hasFilter,
    required this.palette,
    required this.label,
    super.key,
  });

  final bool hasFilter;
  final AppPalette palette;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: hasFilter ? palette.rxInk : palette.muted,
      fontSize: 10,
      fontWeight: FontWeight.w700,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: hasFilter ? palette.primarySoft : Colors.transparent,
        border: Border.all(
          color: hasFilter ? Colors.transparent : palette.hairline,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasFilter) ...[
              Icon(Icons.tune, size: 12, color: palette.rxInk),
              const SizedBox(width: 3),
            ],
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
