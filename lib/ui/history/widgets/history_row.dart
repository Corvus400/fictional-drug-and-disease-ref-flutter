import 'dart:async';

import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/format/relative_viewed_at.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:go_router/go_router.dart';

const _historySwipeDeleteExtent = 72.0;
const _historySwipeDeleteBg = Color(0xFFD62A2A);
const _historySwipeDeleteFg = Color(0xFFFFFFFF);
const _historyCardTopMargin = 8.0;

/// Swipe-delete wrapper for a browsing-history row.
class SwipeDeleteHistoryRow extends StatefulWidget {
  /// Creates a swipe-delete history row.
  const SwipeDeleteHistoryRow({
    required this.row,
    required this.now,
    required this.drugImageCacheManager,
    required this.onDelete,
    super.key,
    this.revealForTesting = false,
  });

  /// Row view model.
  final HistoryRow row;

  /// Reference time used to format [HistoryRow.viewedAt].
  final DateTime now;

  /// Cache manager for drug card images.
  final BaseCacheManager drugImageCacheManager;

  /// Deletes the row.
  final Future<void> Function(String id) onDelete;

  /// Forces the 72dp reveal state for golden tests.
  final bool revealForTesting;

  @override
  State<SwipeDeleteHistoryRow> createState() => _SwipeDeleteHistoryRowState();
}

class _SwipeDeleteHistoryRowState extends State<SwipeDeleteHistoryRow>
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
  void didUpdateWidget(covariant SwipeDeleteHistoryRow oldWidget) {
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
            (_controller.value - delta / _historySwipeDeleteExtent).clamp(
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
            child: HistoryRowTile(
              row: widget.row,
              now: widget.now,
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

  final HistoryRow row;
  final double revealValue;
  final VoidCallback onDelete;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: const _HistorySwipeClipper(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: _historyCardTopMargin,
            right: 0,
            bottom: 0,
            child: ClipRect(
              key: ValueKey('history-row-swipe-reveal-${row.id}'),
              child: Align(
                alignment: Alignment.centerRight,
                widthFactor: revealValue,
                child: _SwipeDeleteAction(row: row, onDelete: onDelete),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-_historySwipeDeleteExtent * revealValue, 0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _SwipeDeleteAction extends StatelessWidget {
  const _SwipeDeleteAction({required this.row, required this.onDelete});

  final HistoryRow row;
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
        key: ValueKey('history-row-swipe-action-clip-${row.id}'),
        borderRadius: actionBorderRadius,
        child: Material(
          key: ValueKey('history-row-swipe-action-material-${row.id}'),
          type: MaterialType.transparency,
          borderRadius: actionBorderRadius,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: _historySwipeDeleteExtent,
            child: GestureDetector(
              onTap: onDelete,
              child: DecoratedBox(
                key: ValueKey('history-row-swipe-action-${row.id}'),
                decoration: const BoxDecoration(color: _historySwipeDeleteBg),
                child: Center(
                  child: Text(
                    l10n.historySwipeDeleteAction,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _historySwipeDeleteFg,
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

/// Browsing-history row rendered with the shared result-card visuals.
class HistoryRowTile extends StatelessWidget {
  /// Creates a history row tile.
  const HistoryRowTile({
    required this.row,
    required this.now,
    required this.drugImageCacheManager,
    super.key,
    this.tapEnabled = true,
    this.swipeRevealed = false,
  });

  /// Row view model.
  final HistoryRow row;

  /// Reference time used to format [HistoryRow.viewedAt].
  final DateTime now;

  /// Cache manager for drug card images.
  final BaseCacheManager drugImageCacheManager;

  /// Whether tapping the row should navigate to detail.
  final bool tapEnabled;

  /// Whether the row is currently translated to reveal the delete action.
  final bool swipeRevealed;

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius = _historyRowCardRadius(swipeRevealed);
    return switch (row) {
      HistoryDrugRow(:final summary) => Semantics(
        label: '薬品の閲覧履歴',
        child: DrugResultCard(
          item: summary,
          cacheManager: drugImageCacheManager,
          trailingTime: _HistoryRowTime(now: now, row: row),
          borderRadius: cardBorderRadius,
          onTap: tapEnabled
              ? () => context.push(AppRoutes.drugDetail(row.id))
              : null,
        ),
      ),
      HistoryDiseaseRow(:final summary) => Semantics(
        label: '疾患の閲覧履歴',
        child: DiseaseResultCard(
          item: summary,
          trailingTime: _HistoryRowTime(now: now, row: row),
          borderRadius: cardBorderRadius,
          onTap: tapEnabled
              ? () => context.push(AppRoutes.diseaseDetail(row.id))
              : null,
        ),
      ),
      HistoryUnresolvedRow() => _UnresolvedHistoryCard(
        row: row as HistoryUnresolvedRow,
        now: now,
        borderRadius: cardBorderRadius,
      ),
    };
  }
}

class _UnresolvedHistoryCard extends StatelessWidget {
  const _UnresolvedHistoryCard({
    required this.row,
    required this.now,
    required this.borderRadius,
  });

  final HistoryUnresolvedRow row;
  final DateTime now;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final isDrug = row.id.startsWith('drug_');
    return Semantics(
      label: l10n.historyNameResolutionFailedPlaceholder,
      child: Card(
        key: ValueKey('history-unresolved-card-${row.id}'),
        margin: const EdgeInsets.only(top: _historyCardTopMargin),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: palette.hairline),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (isDrug) ...[
                _UnresolvedDrugImage(palette: palette),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.historyNameResolutionFailedPlaceholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: palette.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _HistoryRowTime(now: now, row: row),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UnresolvedDrugImage extends StatelessWidget {
  const _UnresolvedDrugImage({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final imageSize =
        MediaQuery.sizeOf(context).width >=
            SearchConstants.searchTabletBreakpoint
        ? SearchConstants.searchTabletDrugImageSize
        : SearchConstants.searchPhoneDrugImageSize;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: imageSize,
        height: imageSize / SearchConstants.searchDrugCardImageAspectRatio,
        child: DecoratedBox(
          decoration: BoxDecoration(color: palette.surface2),
          child: Icon(
            Icons.medication_outlined,
            color: palette.muted,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _HistorySwipeClipper extends CustomClipper<Rect> {
  const _HistorySwipeClipper();

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, -8, size.width, size.height + 8);
  }

  @override
  bool shouldReclip(covariant _HistorySwipeClipper oldClipper) => false;
}

BorderRadius _historyRowCardRadius(bool swipeRevealed) {
  const radius = Radius.circular(SearchConstants.searchCardRadius);
  if (!swipeRevealed) {
    return const BorderRadius.all(radius);
  }
  return const BorderRadius.only(topLeft: radius, bottomLeft: radius);
}

String _rowLabel(HistoryRow row) {
  return switch (row) {
    HistoryDrugRow(:final summary) => summary.brandName,
    HistoryDiseaseRow(:final summary) => summary.name,
    HistoryUnresolvedRow(:final id) => id,
  };
}

class _HistoryRowTime extends StatelessWidget {
  const _HistoryRowTime({required this.now, required this.row});

  final DateTime now;
  final HistoryRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Text(
      formatRelativeViewedAt(now, row.viewedAt, l10n),
      key: ValueKey('history-row-time-${row.id}'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: palette.muted,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
