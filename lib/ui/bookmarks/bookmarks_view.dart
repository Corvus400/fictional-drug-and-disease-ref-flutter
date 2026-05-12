import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/format/bookmark_saved_at.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/widgets/bookmark_search_box.dart';
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
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final state = ref.watch(bookmarksScreenProvider);
    final notifier = ref.read(bookmarksScreenProvider.notifier);
    final drugImageCacheManager = ref.watch(drugCardImageCacheManagerProvider);
    final selectedTab = state.selectedTab;
    final countLabel = switch (state) {
      BookmarksLoading() || BookmarksError() => AppLocalizations.of(
        context,
      )!.bookmarksResultCountUnknown,
      BookmarksEmpty() => AppLocalizations.of(context)!.bookmarksResultCount(0),
      BookmarksLoaded(:final visibleCount) => AppLocalizations.of(
        context,
      )!.bookmarksResultCount(visibleCount),
    };
    final body = switch (state) {
      BookmarksEmpty() => const _BookmarksEmptyState(),
      BookmarksLoaded(:final isSearchZero) when isSearchZero =>
        const _BookmarksSearchZeroState(),
      BookmarksLoaded(:final visibleRows) => _BookmarksRowsList(
        rows: visibleRows,
        drugImageCacheManager: drugImageCacheManager,
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
  });

  final List<BookmarksRow> rows;
  final BaseCacheManager drugImageCacheManager;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final row = rows[index];
        return _BookmarkRowTile(
          key: ValueKey('bookmark-row-${row.id}'),
          row: row,
          drugImageCacheManager: drugImageCacheManager,
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
      ctaKey: const ValueKey('bookmarks-empty-cta'),
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
      ctaKey: const ValueKey('bookmarks-search-zero-cta'),
    );
  }
}

class _BookmarksEmptyMessage extends StatelessWidget {
  const _BookmarksEmptyMessage({
    required this.title,
    required this.body,
    required this.ctaKey,
  });

  final String title;
  final String body;
  final Key ctaKey;

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
                    _BookmarksEmptyArt(palette: palette),
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
                      onPressed: () => context.go(AppRoutes.search),
                      child: Text(l10n.bookmarksEmptyCta),
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

class _BookmarkRowTile extends StatelessWidget {
  const _BookmarkRowTile({
    required this.row,
    required this.drugImageCacheManager,
    super.key,
  });

  final BookmarksRow row;
  final BaseCacheManager drugImageCacheManager;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (row) {
      BookmarksDrugRow(:final summary) => Semantics(
        label: l10n.bookmarksRowDrugSemantics,
        child: DrugResultCard(
          item: summary,
          cacheManager: drugImageCacheManager,
          trailingTime: _BookmarksSavedAt(bookmarkedAt: row.bookmarkedAt),
          onTap: () => context.push(AppRoutes.drugDetail(row.id)),
        ),
      ),
      BookmarksDiseaseRow(:final summary) => Semantics(
        label: l10n.bookmarksRowDiseaseSemantics,
        child: DiseaseResultCard(
          item: summary,
          trailingTime: _BookmarksSavedAt(bookmarkedAt: row.bookmarkedAt),
          showNonInfectiousBadge: false,
          onTap: () => context.push(AppRoutes.diseaseDetail(row.id)),
        ),
      ),
    };
  }
}

class _BookmarksSavedAt extends StatelessWidget {
  const _BookmarksSavedAt({required this.bookmarkedAt});

  final DateTime bookmarkedAt;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Text(
      l10n.bookmarksRowSavedAt(formatBookmarkSavedAt(bookmarkedAt)),
      key: ValueKey('bookmark-saved-at-${bookmarkedAt.toIso8601String()}'),
      maxLines: 1,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: palette.muted,
        fontWeight: FontWeight.w700,
      ),
    );
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
