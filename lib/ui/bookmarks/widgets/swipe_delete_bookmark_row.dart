import 'dart:async';

import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/format/bookmark_saved_at.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

const _bookmarksSwipeDeleteExtent = 72.0;
const _bookmarksSwipeDeleteBg = Color(0xFFD62A2A);
const _bookmarksSwipeDeleteFg = Color(0xFFFFFFFF);
const _bookmarksCardTopMargin = 8.0;

/// Swipe-delete wrapper for a bookmark row.
class SwipeDeleteBookmarkRow extends StatefulWidget {
  /// Creates a swipe-delete bookmark row.
  const SwipeDeleteBookmarkRow({
    required this.row,
    required this.drugImageCacheManager,
    required this.onDelete,
    super.key,
    this.revealForTesting = false,
  });

  /// Row view model.
  final BookmarksRow row;

  /// Cache manager for drug card images.
  final BaseCacheManager drugImageCacheManager;

  /// Deletes the row.
  final Future<void> Function(String id) onDelete;

  /// Forces the 72dp reveal state for golden tests.
  final bool revealForTesting;

  @override
  State<SwipeDeleteBookmarkRow> createState() => _SwipeDeleteBookmarkRowState();
}

class _SwipeDeleteBookmarkRowState extends State<SwipeDeleteBookmarkRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      value: widget.revealForTesting ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(covariant SwipeDeleteBookmarkRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.revealForTesting == oldWidget.revealForTesting) {
      return;
    }
    _controller.value = widget.revealForTesting ? 1 : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _settleDeleteReveal() {
    final shouldReveal = _controller.value >= 0.4;
    unawaited(
      _controller.animateTo(
        shouldReveal ? 1 : 0,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) {
        final delta = details.primaryDelta ?? 0;
        final nextValue =
            (_controller.value - delta / _bookmarksSwipeDeleteExtent).clamp(
              0.0,
              1.0,
            );
        _controller.value = nextValue;
      },
      onHorizontalDragEnd: (_) => _settleDeleteReveal(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final revealValue = _controller.value;
          return _RevealedSwipeDeleteRow(
            row: widget.row,
            revealValue: revealValue,
            onDelete: () => unawaited(widget.onDelete(widget.row.id)),
            child: _BookmarkRowTile(
              row: widget.row,
              drugImageCacheManager: widget.drugImageCacheManager,
              tapEnabled: revealValue <= 0.001,
              swipeRevealed: revealValue > 0.001,
            ),
          );
        },
      ),
    );
  }
}

class _RevealedSwipeDeleteRow extends StatelessWidget {
  const _RevealedSwipeDeleteRow({
    required this.row,
    required this.revealValue,
    required this.onDelete,
    required this.child,
  });

  final BookmarksRow row;
  final double revealValue;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: const _BookmarksSwipeClipper(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: _bookmarksCardTopMargin,
            right: 0,
            bottom: 0,
            child: ClipRect(
              key: ValueKey('bookmarks-row-swipe-reveal-${row.id}'),
              child: Align(
                alignment: Alignment.centerRight,
                widthFactor: revealValue,
                child: _SwipeDeleteAction(row: row, onDelete: onDelete),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-_bookmarksSwipeDeleteExtent * revealValue, 0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _SwipeDeleteAction extends StatelessWidget {
  const _SwipeDeleteAction({required this.row, required this.onDelete});

  final BookmarksRow row;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const actionBorderRadius = BorderRadius.only(
      topRight: Radius.circular(SearchConstants.searchCardRadius),
      bottomRight: Radius.circular(SearchConstants.searchCardRadius),
    );
    return Semantics(
      button: true,
      label: '${_rowLabel(row)} を削除',
      child: ClipRRect(
        key: ValueKey('bookmarks-row-swipe-action-clip-${row.id}'),
        borderRadius: actionBorderRadius,
        child: Material(
          key: ValueKey('bookmarks-row-swipe-action-material-${row.id}'),
          type: MaterialType.transparency,
          borderRadius: actionBorderRadius,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: _bookmarksSwipeDeleteExtent,
            child: GestureDetector(
              onTap: onDelete,
              child: DecoratedBox(
                key: ValueKey('bookmarks-row-swipe-action-${row.id}'),
                decoration: const BoxDecoration(color: _bookmarksSwipeDeleteBg),
                child: Center(
                  child: Text(
                    l10n.bookmarksSwipeDeleteAction,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _bookmarksSwipeDeleteFg,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BookmarkRowTile extends StatelessWidget {
  const _BookmarkRowTile({
    required this.row,
    required this.drugImageCacheManager,
    this.tapEnabled = true,
    this.swipeRevealed = false,
  });

  final BookmarksRow row;
  final BaseCacheManager drugImageCacheManager;
  final bool tapEnabled;
  final bool swipeRevealed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cardBorderRadius = _bookmarkRowCardRadius(swipeRevealed);
    return switch (row) {
      BookmarksDrugRow(:final summary) => Semantics(
        label: l10n.bookmarksRowDrugSemantics,
        child: DrugResultCard(
          item: summary,
          cacheManager: drugImageCacheManager,
          trailingTime: _BookmarksSavedAt(bookmarkedAt: row.bookmarkedAt),
          borderRadius: cardBorderRadius,
          onTap: tapEnabled
              ? () => context.push(AppRoutes.drugDetail(row.id))
              : null,
        ),
      ),
      BookmarksDiseaseRow(:final summary) => Semantics(
        label: l10n.bookmarksRowDiseaseSemantics,
        child: DiseaseResultCard(
          item: summary,
          trailingTime: _BookmarksSavedAt(bookmarkedAt: row.bookmarkedAt),
          borderRadius: cardBorderRadius,
          showNonInfectiousBadge: false,
          onTap: tapEnabled
              ? () => context.push(AppRoutes.diseaseDetail(row.id))
              : null,
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

class _BookmarksSwipeClipper extends CustomClipper<Rect> {
  const _BookmarksSwipeClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, -8, size.width, size.height + 8);
  }

  @override
  bool shouldReclip(covariant _BookmarksSwipeClipper oldClipper) => false;
}

BorderRadius _bookmarkRowCardRadius(bool swipeRevealed) {
  const radius = Radius.circular(SearchConstants.searchCardRadius);
  if (!swipeRevealed) {
    return const BorderRadius.all(radius);
  }
  return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
}

String _rowLabel(BookmarksRow row) {
  return switch (row) {
    BookmarksDrugRow(:final summary) => summary.brandName,
    BookmarksDiseaseRow(:final summary) => summary.name,
  };
}
