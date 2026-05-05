part of '../search_view.dart';

class _SearchHistoryDropdown extends StatelessWidget {
  const _SearchHistoryDropdown({
    required this.tapRegionGroupId,
    required this.entries,
    required this.onSelect,
    required this.onDelete,
    required this.onClearAll,
  });

  final Object tapRegionGroupId;
  final List<SearchHistoryEnvelope> entries;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function() onClearAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return TapRegion(
      groupId: tapRegionGroupId,
      child: Material(
        color: theme.colorScheme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SearchConstants.searchPhoneGutter,
                10,
                SearchConstants.searchPhoneGutter,
                6,
              ),
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
                    onPressed: () => unawaited(_confirmClearHistory(context)),
                    child: Text(l10n.searchHistoryClear),
                  ),
                ],
              ),
            ),
            for (final entry in entries)
              _SearchHistoryRow(
                entry: entry,
                palette: palette,
                onSelect: onSelect,
                onDelete: onDelete,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SearchConstants.searchPhoneGutter,
                8,
                SearchConstants.searchPhoneGutter,
                10,
              ),
              child: Text(
                l10n.searchHistoryPrivacyNote,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
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
    required this.onSelect,
    required this.onDelete,
  });

  final SearchHistoryEnvelope entry;
  final SearchPalette palette;
  final Future<void> Function(SearchHistoryEnvelope entry) onSelect;
  final Future<void> Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
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
        title: Text(
          entry.queryText,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(l10n.searchToolbarTotal(entry.totalCount)),
            if (entry.filterCount > 0)
              Text(
                l10n.searchHistoryFilterCount(entry.filterCount),
                style: TextStyle(color: palette.drugInk),
              ),
          ],
        ),
        trailing: IconButton(
          key: ValueKey('delete-history-${entry.id}'),
          onPressed: () => unawaited(onDelete(entry.id)),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
