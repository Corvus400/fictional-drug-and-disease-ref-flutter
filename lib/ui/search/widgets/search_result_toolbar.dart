part of '../search_view.dart';

class _SearchResultToolbar extends StatelessWidget {
  const _SearchResultToolbar({
    required this.state,
    required this.totalCount,
    required this.onRemoveChipAt,
    required this.onChangeDrugSort,
  });

  final SearchScreenState state;
  final int totalCount;
  final Future<void> Function(int index) onRemoveChipAt;
  final Future<void> Function(DrugSort sort) onChangeDrugSort;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<SearchPalette>() ??
        (theme.brightness == Brightness.dark
            ? SearchPalette.dark
            : SearchPalette.light);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.appliedChips.count > 0)
          DecoratedBox(
            key: const ValueKey('search-applied-filter-bar'),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: palette.hairline)),
            ),
            child: SizedBox(
              height: 36,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          const SizedBox(width: 2),
                          Text(
                            l10n.searchToolbarApplied,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: palette.muted,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          for (
                            var i = 0;
                            i < state.appliedChips.items.length;
                            i++
                          ) ...[
                            _AppliedFilterChip(
                              label: _appliedChipLabel(
                                l10n,
                                state.categories,
                                state.appliedChips.items[i],
                              ),
                              palette: palette,
                              onTap: () => onRemoveChipAt(i),
                            ),
                            const SizedBox(width: 6),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    key: const ValueKey('search-applied-filter-fade'),
                    top: 0,
                    right: 0,
                    bottom: 0,
                    width: 30,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.surface.withValues(alpha: 0),
                              theme.colorScheme.surface,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    key: const ValueKey('search-applied-filter-chevron'),
                    top: 8,
                    right: 4,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: palette.surfaceSubtle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(Icons.chevron_right, size: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          key: const ValueKey('search-results-toolbar'),
          height: SearchConstants.searchResultToolbarHeight,
          child: Row(
            children: [
              Text(l10n.searchToolbarTotal(totalCount)),
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
      ],
    );
  }
}

class _AppliedFilterChip extends StatelessWidget {
  const _AppliedFilterChip({
    required this.label,
    required this.palette,
    required this.onTap,
  });

  final String label;
  final SearchPalette palette;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final closeColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0x389ECAFF)
        : const Color(0x2E007AFF);
    return InkWell(
      onTap: () => unawaited(onTap()),
      borderRadius: BorderRadius.circular(14),
      child: DecoratedBox(
        key: ValueKey('search-applied-filter-chip-$label'),
        decoration: BoxDecoration(
          color: palette.primarySoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: palette.primaryRing, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 8, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: palette.rxInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              DecoratedBox(
                key: ValueKey('search-applied-filter-close-$label'),
                decoration: BoxDecoration(
                  color: closeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: Icon(Icons.close, size: 10, color: palette.rxInk),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
