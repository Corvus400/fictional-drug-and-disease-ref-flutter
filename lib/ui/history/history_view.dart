import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Browsing history tab.
class HistoryView extends ConsumerWidget {
  /// Creates a history view.
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final state = ref.watch(historyScreenProvider);
    final notifier = ref.read(historyScreenProvider.notifier);
    final selectedTab = switch (state) {
      HistoryLoaded(:final selectedTab) => selectedTab,
      _ => HistoryTab.all,
    };
    final body = switch (state) {
      HistoryEmpty() => const _HistoryEmptyState(),
      HistoryLoaded(:final rows) when rows.isEmpty =>
        const _HistoryEmptyState(),
      _ => const _HistoryLoadingState(),
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final usePaneLayout = _usesPaneLayout(constraints.biggest);
        return Scaffold(
          backgroundColor: palette.background,
          appBar: AppBar(
            title: Text(l10n.tabHistory),
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
          body: usePaneLayout
              ? _HistoryPaneBody(
                  selectedTab: selectedTab,
                  onSelect: notifier.selectTab,
                  child: body,
                )
              : body,
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
              label: l10n.historyTabDrugs,
              tab: HistoryTab.drug,
              selectedTab: selectedTab,
              onSelect: onSelect,
              compact: compact,
            ),
            _HistorySideTabButton(
              label: l10n.historyTabDiseases,
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
            label: l10n.historyTabDrugs,
            tab: HistoryTab.drug,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
          _HistoryTabButton(
            label: l10n.historyTabDiseases,
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
