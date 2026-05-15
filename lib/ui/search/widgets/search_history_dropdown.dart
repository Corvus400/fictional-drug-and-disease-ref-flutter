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
                      l10n.searchHistoryTitle,
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
    final isDrug = entry is DrugSearchHistoryEnvelope;
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
      child: ListTile(
        key: ValueKey('history-row-${entry.id}'),
        onTap: () => unawaited(onSelect(entry)),
        dense: true,
        leading: const Icon(Icons.history, size: 16),
        title: Row(
          children: [
            Container(
              key: ValueKey('history-target-pill-${entry.id}'),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isDrug ? palette.rxTint : palette.dxTint,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                isDrug ? l10n.searchHistoryRxBadge : l10n.searchHistoryDxBadge,
                style: TextStyle(
                  color: isDrug ? palette.rxInk : palette.dxInk,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                entry.queryText,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(l10n.searchToolbarTotal(entry.totalCount)),
            Text(formatRelativeTime(currentTime, entry.searchedAt, l10n)),
            if (entry.filterCount > 0)
              Container(
                padding: const EdgeInsets.fromLTRB(7, 2, 8, 2),
                decoration: BoxDecoration(
                  color: palette.primarySoft,
                  border: Border.all(color: palette.primaryRing, width: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.searchHistoryFilterCount(entry.filterCount),
                  style: TextStyle(
                    color: palette.rxInk,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        trailing: IconButton(
          key: ValueKey('delete-history-${entry.id}'),
          onPressed: () => unawaited(onDelete(entry.id)),
          icon: DecoratedBox(
            key: ValueKey('search-history-delete-bg-${entry.id}'),
            decoration: BoxDecoration(
              color: palette.surface3,
              borderRadius: BorderRadius.circular(11),
            ),
            child: SizedBox(
              width: 22,
              height: 22,
              child: Icon(Icons.close, size: 9, color: palette.muted),
            ),
          ),
        ),
      ),
    );
  }
}
