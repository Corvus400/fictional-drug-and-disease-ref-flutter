part of '../search_view.dart';

class _NoSearchHistoryState extends StatelessWidget {
  const _NoSearchHistoryState();

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

class _SearchUtilityIdleMasterState extends StatelessWidget {
  const _SearchUtilityIdleMasterState({required this.emptyHistory});

  final bool emptyHistory;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    return LayoutBuilder(
      key: const ValueKey('search-utility-idle-master-state'),
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: palette.surfaceSubtle,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: SizedBox(
                          width: 64,
                          height: 64,
                          child: Icon(
                            Icons.search,
                            size: 28,
                            color: palette.muted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.searchUtilityIdleTitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: palette.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        emptyHistory
                            ? l10n.searchUtilityIdleEmptyHistoryDescription
                            : l10n.searchUtilityIdleWithHistoryDescription,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: palette.muted,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
