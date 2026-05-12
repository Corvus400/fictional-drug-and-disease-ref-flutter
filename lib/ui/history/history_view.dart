import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/bulk_delete_confirm_dialog.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/widgets/history_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

const _historyDestructiveBg = Color(0xFFD62A2A);
const _historyDestructiveFg = Color(0xFFFFFFFF);

/// Browsing history tab.
class HistoryView extends ConsumerWidget {
  /// Creates a history view.
  const HistoryView({super.key, this.currentTime, this.debugSwipeRevealRowId});

  /// Fixed time for deterministic tests; defaults to the current local time.
  final DateTime? currentTime;

  /// Forces one row into the 72dp swipe reveal state for golden tests.
  @visibleForTesting
  final String? debugSwipeRevealRowId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final state = ref.watch(historyScreenProvider);
    final notifier = ref.read(historyScreenProvider.notifier);
    final drugImageCacheManager = ref.watch(drugCardImageCacheManagerProvider);
    final now = currentTime ?? DateTime.now();
    final selectedTab = switch (state) {
      HistoryLoaded(:final selectedTab) => selectedTab,
      _ => HistoryTab.all,
    };
    final bulkDeleteCount = switch (state) {
      HistoryLoaded(:final totalCount) => totalCount,
      _ => 0,
    };
    final showRetryFab = switch (state) {
      HistoryLoaded(:final hasNameFailure) => hasNameFailure,
      _ => false,
    };
    final body = switch (state) {
      HistoryEmpty() => const _HistoryEmptyState(),
      HistoryLoaded(:final rows) when rows.isEmpty =>
        const _HistoryEmptyState(),
      HistoryLoaded(:final rows) => _HistoryRowsList(
        rows: rows,
        now: now,
        drugImageCacheManager: drugImageCacheManager,
        onDelete: notifier.deleteRow,
        debugSwipeRevealRowId: debugSwipeRevealRowId,
      ),
      _ => const _HistoryLoadingState(),
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final usePaneLayout = _usesPaneLayout(constraints.biggest);
        return Scaffold(
          backgroundColor: palette.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            titleSpacing: 16,
            toolbarHeight: usePaneLayout ? 64 : 56,
            title: Text(
              l10n.tabHistory,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: palette.ink,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            backgroundColor: palette.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            bottom: usePaneLayout
                ? null
                : PreferredSize(
                    preferredSize: const Size.fromHeight(45),
                    child: _HistoryTabBar(
                      selectedTab: selectedTab,
                      onSelect: notifier.selectTab,
                    ),
                  ),
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: usePaneLayout
                    ? _HistoryPaneBody(
                        selectedTab: selectedTab,
                        onSelect: notifier.selectTab,
                        child: body,
                      )
                    : body,
              ),
              if (showRetryFab)
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: _HistoryRetryFab(onPressed: notifier.retryFailedNames),
                ),
              if (bulkDeleteCount > 0)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: _HistoryBulkDeleteFab(
                    count: bulkDeleteCount,
                    onPressed: () async {
                      final confirmed = await showBulkDeleteConfirmDialog(
                        context: context,
                        count: bulkDeleteCount,
                      );
                      if (confirmed ?? false) {
                        await notifier.clearAll();
                      }
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static bool _usesPaneLayout(Size size) {
    return size.width >= 600 || size.width > size.height;
  }
}

class _HistoryPaneBody extends StatelessWidget {
  const _HistoryPaneBody({
    required this.selectedTab,
    required this.onSelect,
    required this.child,
  });

  final HistoryTab selectedTab;
  final ValueChanged<HistoryTab> onSelect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final size = MediaQuery.sizeOf(context);
    final railWidth = size.width > size.height && size.width < 900
        ? 180.0
        : 280.0;

    return ColoredBox(
      color: palette.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: railWidth,
            child: _HistorySideTabBar(
              selectedTab: selectedTab,
              onSelect: onSelect,
              compact: railWidth < 200,
            ),
          ),
          VerticalDivider(width: 1, thickness: 1, color: palette.hairline),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _HistorySideTabBar extends StatelessWidget {
  const _HistorySideTabBar({
    required this.selectedTab,
    required this.onSelect,
    required this.compact,
  });

  final HistoryTab selectedTab;
  final ValueChanged<HistoryTab> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return ColoredBox(
      color: palette.surface,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: compact ? 12 : 24),
        child: Column(
          children: [
            _HistorySideTabButton(
              label: l10n.historyTabAll,
              tab: HistoryTab.all,
              selectedTab: selectedTab,
              onSelect: onSelect,
              compact: compact,
            ),
            _HistorySideTabButton(
              label: l10n.historyTabDrug,
              tab: HistoryTab.drug,
              selectedTab: selectedTab,
              onSelect: onSelect,
              compact: compact,
            ),
            _HistorySideTabButton(
              label: l10n.historyTabDisease,
              tab: HistoryTab.disease,
              selectedTab: selectedTab,
              onSelect: onSelect,
              compact: compact,
            ),
          ],
        ),
      ),
    );
  }
}

class _HistorySideTabButton extends StatelessWidget {
  const _HistorySideTabButton({
    required this.label,
    required this.tab,
    required this.selectedTab,
    required this.onSelect,
    required this.compact,
  });

  final String label;
  final HistoryTab tab;
  final HistoryTab selectedTab;
  final ValueChanged<HistoryTab> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final selected = tab == selectedTab;
    return Material(
      color: selected ? palette.primarySoft : Colors.transparent,
      child: InkWell(
        onTap: () => onSelect(tab),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: compact ? 48 : 64),
          padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 24),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 4,
                color: selected ? palette.primary : Colors.transparent,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: selected ? palette.primary : palette.ink2,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryTabBar extends StatelessWidget {
  const _HistoryTabBar({
    required this.selectedTab,
    required this.onSelect,
  });

  final HistoryTab selectedTab;
  final ValueChanged<HistoryTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey('history-tabbar'),
      height: 45,
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      child: Row(
        children: [
          _HistoryTabButton(
            label: l10n.historyTabAll,
            tab: HistoryTab.all,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
          _HistoryTabButton(
            label: l10n.historyTabDrug,
            tab: HistoryTab.drug,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
          _HistoryTabButton(
            label: l10n.historyTabDisease,
            tab: HistoryTab.disease,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}

class _HistoryTabButton extends StatelessWidget {
  const _HistoryTabButton({
    required this.label,
    required this.tab,
    required this.selectedTab,
    required this.onSelect,
  });

  final String label;
  final HistoryTab tab;
  final HistoryTab selectedTab;
  final ValueChanged<HistoryTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final selected = tab == selectedTab;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelect(tab),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: selected ? palette.primary : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              label,
              style: theme.textTheme.titleSmall?.copyWith(
                color: selected ? palette.primary : palette.ink2,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryEmptyState extends StatelessWidget {
  const _HistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxHeight < 320 ? 24.0 : 48.0;
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _HistoryEmptyArt(palette: palette),
                    const SizedBox(height: 16),
                    Text(
                      l10n.historyEmptyTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: palette.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Text(
                        l10n.historyEmptyBody,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: palette.ink2,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      key: const ValueKey('history-empty-cta'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: const StadiumBorder(),
                        backgroundColor: palette.searchPrimaryActionBg,
                        foregroundColor: palette.searchPrimaryActionFg,
                      ),
                      onPressed: () => context.go(AppRoutes.search),
                      child: Text(l10n.historyEmptyCta),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HistoryRowsList extends StatelessWidget {
  const _HistoryRowsList({
    required this.rows,
    required this.now,
    required this.drugImageCacheManager,
    required this.onDelete,
    required this.debugSwipeRevealRowId,
  });

  final List<HistoryRow> rows;
  final DateTime now;
  final BaseCacheManager drugImageCacheManager;
  final Future<void> Function(String id) onDelete;
  final String? debugSwipeRevealRowId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: rows.length,
      findChildIndexCallback: (key) => _historyRowIndexForKey(rows, key),
      itemBuilder: (context, index) {
        final row = rows[index];
        return SwipeDeleteHistoryRow(
          key: ValueKey('history-row-${row.id}'),
          row: row,
          now: now,
          drugImageCacheManager: drugImageCacheManager,
          onDelete: onDelete,
          revealForTesting: row.id == debugSwipeRevealRowId,
        );
      },
    );
  }
}

int? _historyRowIndexForKey(List<HistoryRow> rows, Key key) {
  if (key is! ValueKey<String>) {
    return null;
  }
  final value = key.value;
  const prefix = 'history-row-';
  if (!value.startsWith(prefix)) {
    return null;
  }
  final id = value.substring(prefix.length);
  final index = rows.indexWhere((row) => row.id == id);
  return index == -1 ? null : index;
}

class _HistoryRetryFab extends StatelessWidget {
  const _HistoryRetryFab({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Semantics(
      button: true,
      label: l10n.historyRetryFabSemantics,
      child: SizedBox.square(
        dimension: 56,
        child: FloatingActionButton(
          key: const ValueKey('history-retry-fab'),
          heroTag: 'history-retry-fab',
          tooltip: l10n.historyRetryFabSemantics,
          elevation: 2,
          backgroundColor: palette.filterFabBg,
          foregroundColor: palette.filterFabFg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          onPressed: onPressed,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class _HistoryBulkDeleteFab extends StatelessWidget {
  const _HistoryBulkDeleteFab({required this.count, required this.onPressed});

  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Semantics(
      button: true,
      label: l10n.historyBulkDeleteFabSemantics,
      child: SizedBox.square(
        dimension: 56,
        child: FloatingActionButton(
          key: const ValueKey('history-bulk-delete-fab'),
          heroTag: 'history-bulk-delete-fab',
          tooltip: l10n.historyBulkDeleteFabSemantics,
          elevation: 2,
          backgroundColor: _historyDestructiveBg,
          foregroundColor: _historyDestructiveFg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          onPressed: onPressed,
          child: SizedBox.expand(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Icon(Icons.delete_outline),
                Positioned(
                  top: -2,
                  right: -2,
                  child: _HistoryBulkDeleteBadge(count: count),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryBulkDeleteBadge extends StatelessWidget {
  const _HistoryBulkDeleteBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey('history-bulk-delete-count-badge'),
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: _historyDestructiveFg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: palette.surface, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : '$count',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _historyDestructiveBg,
          fontSize: 10,
          height: 1,
          fontWeight: FontWeight.w700,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}

class _HistoryEmptyArt extends StatelessWidget {
  const _HistoryEmptyArt({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('history-empty-art'),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: palette.surface,
        border: Border.all(color: palette.hairline2),
      ),
      child: Icon(Icons.history, size: 72, color: palette.ink2),
    );
  }
}

class _HistoryLoadingState extends StatelessWidget {
  const _HistoryLoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => const _HistorySkeletonRow(),
    );
  }
}

class _HistorySkeletonRow extends StatelessWidget {
  const _HistorySkeletonRow();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return DecoratedBox(
      key: const ValueKey('history-loading-skeleton-row'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [palette.surface3, palette.surface4, palette.surface3],
        ),
      ),
      child: const SizedBox(height: 80, width: double.infinity),
    );
  }
}
