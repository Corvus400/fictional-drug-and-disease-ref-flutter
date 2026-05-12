import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/bookmark_search_box.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/swipe_delete_bookmark_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Bookmarks tab.
class BookmarksView extends ConsumerWidget {
  /// Creates a bookmarks view.
  const BookmarksView({super.key, this.debugSwipeRevealRowId});

  /// Forces one row into the 72dp swipe reveal state for golden tests.
  final String? debugSwipeRevealRowId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final state = ref.watch(bookmarksScreenProvider);
    final notifier = ref.read(bookmarksScreenProvider.notifier);
    final drugImageCacheManager = ref.watch(drugCardImageCacheManagerProvider);
    final selectedTab = state.selectedTab;
    final countLabel = switch (state) {
      BookmarksLoading() => AppLocalizations.of(
        context,
      )!.bookmarksResultCountUnknown,
      BookmarksError(:final visibleCount) =>
        visibleCount == null
            ? AppLocalizations.of(context)!.bookmarksResultCountUnknown
            : AppLocalizations.of(context)!.bookmarksResultCount(visibleCount),
      BookmarksEmpty() => AppLocalizations.of(context)!.bookmarksResultCount(0),
      BookmarksLoaded(:final visibleCount) => AppLocalizations.of(
        context,
      )!.bookmarksResultCount(visibleCount),
    };
    final body = switch (state) {
      BookmarksEmpty() => const _BookmarksEmptyState(),
      BookmarksError() => _BookmarksErrorState(onRetry: notifier.retry),
      BookmarksLoaded(:final isSearchZero) when isSearchZero =>
        const _BookmarksSearchZeroState(),
      BookmarksLoaded(:final visibleRows) => _BookmarksRowsList(
        rows: visibleRows,
        drugImageCacheManager: drugImageCacheManager,
        onDelete: notifier.deleteRow,
        debugSwipeRevealRowId: debugSwipeRevealRowId,
      ),
      _ => const _BookmarksLoadingState(),
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final usePaneLayout = _usesPaneLayout(constraints.biggest);
        return Scaffold(
          backgroundColor: palette.background,
          appBar: AppTabHeader(
            tab: AppShellTab.bookmarks,
            toolbarHeight: usePaneLayout ? 64 : 56,
          ),
          body: usePaneLayout
              ? _BookmarksPaneBody(
                  selectedTab: selectedTab,
                  countLabel: countLabel,
                  onSelect: notifier.selectTab,
                  onSearchChanged: notifier.setSearchQuery,
                  child: body,
                )
              : Column(
                  children: [
                    _BookmarksTabBar(
                      selectedTab: selectedTab,
                      onSelect: notifier.selectTab,
                    ),
                    _BookmarksSearchPanel(
                      countLabel: countLabel,
                      onChanged: notifier.setSearchQuery,
                    ),
                    Expanded(child: body),
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

class _BookmarksPaneBody extends StatelessWidget {
  const _BookmarksPaneBody({
    required this.selectedTab,
    required this.countLabel,
    required this.onSelect,
    required this.onSearchChanged,
    required this.child,
  });

  final BookmarksTab selectedTab;
  final String countLabel;
  final ValueChanged<BookmarksTab> onSelect;
  final ValueChanged<String> onSearchChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final size = MediaQuery.sizeOf(context);
    final railWidth = size.width > size.height && size.width < 900
        ? 220.0
        : 320.0;

    return ColoredBox(
      color: palette.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: railWidth,
            child: ColoredBox(
              color: palette.surface,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _BookmarksSearchPanel(
                      countLabel: countLabel,
                      onChanged: onSearchChanged,
                      compact: true,
                    ),
                    const SizedBox(height: 12),
                    _BookmarksSideTabBar(
                      selectedTab: selectedTab,
                      onSelect: onSelect,
                      compact: railWidth < 240,
                    ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(width: 1, thickness: 1, color: palette.hairline),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _BookmarksSearchPanel extends StatelessWidget {
  const _BookmarksSearchPanel({
    required this.countLabel,
    required this.onChanged,
    this.compact = false,
  });

  final String countLabel;
  final ValueChanged<String> onChanged;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final content = compact
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BookmarkSearchBox(onChanged: onChanged),
              const SizedBox(height: 10),
              _BookmarksResultCount(label: countLabel),
            ],
          )
        : Row(
            children: [
              Expanded(child: BookmarkSearchBox(onChanged: onChanged)),
              const SizedBox(width: 10),
              _BookmarksResultCount(label: countLabel),
            ],
          );
    return Container(
      key: const ValueKey('bookmarks-search-panel'),
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      padding: EdgeInsets.all(compact ? 16 : 8).copyWith(
        left: 16,
        right: 16,
      ),
      child: content,
    );
  }
}

class _BookmarksResultCount extends StatelessWidget {
  const _BookmarksResultCount({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Text(
      key: const ValueKey('bookmarks-result-count'),
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: palette.ink2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _BookmarksTabBar extends StatelessWidget {
  const _BookmarksTabBar({
    required this.selectedTab,
    required this.onSelect,
  });

  final BookmarksTab selectedTab;
  final ValueChanged<BookmarksTab> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey('bookmarks-tabbar'),
      height: 45,
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border(bottom: BorderSide(color: palette.hairline)),
      ),
      child: Row(
        children: [
          _BookmarksTabButton(
            label: l10n.bookmarksTabAll,
            tab: BookmarksTab.all,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
          _BookmarksTabButton(
            label: l10n.bookmarksTabDrug,
            tab: BookmarksTab.drug,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
          _BookmarksTabButton(
            label: l10n.bookmarksTabDisease,
            tab: BookmarksTab.disease,
            selectedTab: selectedTab,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}

class _BookmarksSideTabBar extends StatelessWidget {
  const _BookmarksSideTabBar({
    required this.selectedTab,
    required this.onSelect,
    required this.compact,
  });

  final BookmarksTab selectedTab;
  final ValueChanged<BookmarksTab> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _BookmarksSideTabButton(
          label: l10n.bookmarksTabAll,
          tab: BookmarksTab.all,
          selectedTab: selectedTab,
          onSelect: onSelect,
          compact: compact,
        ),
        _BookmarksSideTabButton(
          label: l10n.bookmarksTabDrug,
          tab: BookmarksTab.drug,
          selectedTab: selectedTab,
          onSelect: onSelect,
          compact: compact,
        ),
        _BookmarksSideTabButton(
          label: l10n.bookmarksTabDisease,
          tab: BookmarksTab.disease,
          selectedTab: selectedTab,
          onSelect: onSelect,
          compact: compact,
        ),
      ],
    );
  }
}

class _BookmarksTabButton extends StatelessWidget {
  const _BookmarksTabButton({
    required this.label,
    required this.tab,
    required this.selectedTab,
    required this.onSelect,
  });

  final String label;
  final BookmarksTab tab;
  final BookmarksTab selectedTab;
  final ValueChanged<BookmarksTab> onSelect;

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

class _BookmarksSideTabButton extends StatelessWidget {
  const _BookmarksSideTabButton({
    required this.label,
    required this.tab,
    required this.selectedTab,
    required this.onSelect,
    required this.compact,
  });

  final String label;
  final BookmarksTab tab;
  final BookmarksTab selectedTab;
  final ValueChanged<BookmarksTab> onSelect;
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
          constraints: BoxConstraints(minHeight: compact ? 48 : 56),
          padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 16),
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

class _BookmarksRowsList extends StatelessWidget {
  const _BookmarksRowsList({
    required this.rows,
    required this.drugImageCacheManager,
    required this.onDelete,
    required this.debugSwipeRevealRowId,
  });

  final List<BookmarksRow> rows;
  final BaseCacheManager drugImageCacheManager;
  final Future<void> Function(String id) onDelete;
  final String? debugSwipeRevealRowId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final row = rows[index];
        return SwipeDeleteBookmarkRow(
          key: ValueKey('bookmarks-row-${row.id}'),
          row: row,
          drugImageCacheManager: drugImageCacheManager,
          onDelete: onDelete,
          revealForTesting: row.id == debugSwipeRevealRowId,
        );
      },
    );
  }
}

class _BookmarksEmptyState extends StatelessWidget {
  const _BookmarksEmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _BookmarksEmptyMessage(
      title: l10n.bookmarksEmptyTitle,
      body: l10n.bookmarksEmptyBody,
      ctaLabel: l10n.bookmarksEmptyCta,
      ctaKey: const ValueKey('bookmarks-empty-cta'),
      onPressed: () => context.go(AppRoutes.search),
    );
  }
}

class _BookmarksSearchZeroState extends StatelessWidget {
  const _BookmarksSearchZeroState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _BookmarksEmptyMessage(
      title: l10n.bookmarksSearchZeroTitle,
      body: l10n.bookmarksSearchZeroBody,
      ctaLabel: l10n.bookmarksEmptyCta,
      ctaKey: const ValueKey('bookmarks-search-zero-cta'),
      onPressed: () => context.go(AppRoutes.search),
    );
  }
}

class _BookmarksErrorState extends StatelessWidget {
  const _BookmarksErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _BookmarksEmptyMessage(
      title: l10n.bookmarksErrorTitle,
      body: l10n.bookmarksErrorBody,
      ctaLabel: l10n.bookmarksErrorRetry,
      ctaKey: const ValueKey('bookmarks-error-retry'),
      onPressed: onRetry,
      art: const _BookmarksErrorArt(),
    );
  }
}

class _BookmarksEmptyMessage extends StatelessWidget {
  const _BookmarksEmptyMessage({
    required this.title,
    required this.body,
    required this.ctaLabel,
    required this.ctaKey,
    required this.onPressed,
    this.art,
  });

  final String title;
  final String body;
  final String ctaLabel;
  final Key ctaKey;
  final VoidCallback onPressed;
  final Widget? art;

  @override
  Widget build(BuildContext context) {
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
                    art ?? _BookmarksEmptyArt(palette: palette),
                    const SizedBox(height: 16),
                    Text(
                      title,
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
                        body,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: palette.ink2,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      key: ctaKey,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: const StadiumBorder(),
                        backgroundColor: palette.searchPrimaryActionBg,
                        foregroundColor: palette.searchPrimaryActionFg,
                      ),
                      onPressed: onPressed,
                      child: Text(ctaLabel),
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

class _BookmarksEmptyArt extends StatelessWidget {
  const _BookmarksEmptyArt({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('bookmarks-empty-art'),
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: palette.surface,
        border: Border.all(color: palette.hairline2),
      ),
      child: CustomPaint(
        size: const Size.square(56),
        painter: _BookmarksEmptyArtPainter(color: palette.ink2),
      ),
    );
  }
}

class _BookmarksEmptyArtPainter extends CustomPainter {
  const _BookmarksEmptyArtPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / 64;
    canvas
      ..save()
      ..translate((size.width - size.shortestSide) / 2, 0)
      ..scale(scale);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final bookmark = Path()
      ..moveTo(20, 12)
      ..lineTo(44, 12)
      ..quadraticBezierTo(48, 12, 48, 16)
      ..lineTo(48, 52)
      ..lineTo(32, 42)
      ..lineTo(16, 52)
      ..lineTo(16, 16)
      ..quadraticBezierTo(16, 12, 20, 12)
      ..close();
    canvas
      ..drawPath(bookmark, paint)
      ..drawLine(const Offset(25, 24), const Offset(39, 24), paint)
      ..drawLine(const Offset(25, 32), const Offset(35, 32), paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_BookmarksEmptyArtPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _BookmarksErrorArt extends StatelessWidget {
  const _BookmarksErrorArt();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey('bookmarks-error-art'),
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: palette.surface,
        border: Border.all(color: palette.hairline2),
      ),
      child: CustomPaint(
        size: const Size.square(56),
        painter: _BookmarksErrorArtPainter(color: palette.ink2),
      ),
    );
  }
}

class _BookmarksErrorArtPainter extends CustomPainter {
  const _BookmarksErrorArtPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / 64;
    canvas
      ..save()
      ..translate((size.width - size.shortestSide) / 2, 0)
      ..scale(scale);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas
      ..drawCircle(const Offset(32, 32), 22, paint)
      ..drawLine(const Offset(32, 18), const Offset(32, 36), paint)
      ..drawCircle(const Offset(32, 45), 0.5, paint)
      ..restore();
  }

  @override
  bool shouldRepaint(_BookmarksErrorArtPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class _BookmarksLoadingState extends StatelessWidget {
  const _BookmarksLoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => const _BookmarksSkeletonRow(),
    );
  }
}

class _BookmarksSkeletonRow extends StatelessWidget {
  const _BookmarksSkeletonRow();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return DecoratedBox(
      key: const ValueKey('bookmarks-skeleton-row'),
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
