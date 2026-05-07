import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Fixed bookmark footer for detail screens.
class DetailBookmarkFooter extends StatelessWidget {
  /// Creates a bookmark footer.
  const DetailBookmarkFooter({
    required this.isBookmarked,
    required this.isBusy,
    required this.bookmarkError,
    required this.onToggleBookmark,
    required this.onClearBookmarkError,
    this.trailing,
    super.key,
  });

  /// Whether the current detail is bookmarked.
  final bool isBookmarked;

  /// Whether a bookmark mutation is running.
  final bool isBusy;

  /// Last bookmark mutation error. The design keeps errors in the content area.
  final AppException? bookmarkError;

  /// Called when the bookmark button is tapped.
  final VoidCallback onToggleBookmark;

  /// Called when a caller-owned bookmark error surface is dismissed.
  final VoidCallback onClearBookmarkError;

  /// Optional trailing footer action. Dose calculation wiring is added in A7.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('detail-bookmark-footer'),
      constraints: const BoxConstraints.tightFor(
        height: DetailConstants.footerHeight,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.footerPaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            offset: const Offset(0, DetailConstants.footerShadowDy),
            blurRadius: DetailConstants.footerShadowBlurRadius,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _BookmarkButton(
              isBookmarked: isBookmarked,
              isBusy: isBusy,
              onToggleBookmark: onToggleBookmark,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: DetailConstants.footerGap),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class _BookmarkButton extends StatelessWidget {
  const _BookmarkButton({
    required this.isBookmarked,
    required this.isBusy,
    required this.onToggleBookmark,
  });

  final bool isBookmarked;
  final bool isBusy;
  final VoidCallback onToggleBookmark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final foreground = isBookmarked
        ? colors.onPrimaryContainer
        : colors.onSurface;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isBusy ? null : onToggleBookmark,
      child: Container(
        key: const ValueKey<String>('detail-bookmark-button'),
        constraints: const BoxConstraints.tightFor(
          height: DetailConstants.footerActionHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: DetailConstants.footerActionPaddingHorizontal,
        ),
        decoration: BoxDecoration(
          color: isBookmarked
              ? colors.primaryContainer
              : colors.surfaceContainer,
          borderRadius: BorderRadius.circular(
            DetailConstants.footerActionRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: foreground,
              size: DetailConstants.footerActionIconSize,
            ),
            const SizedBox(width: DetailConstants.bookmarkActionGap),
            Text(
              isBookmarked
                  ? l10n.detailBookmarkedLabel
                  : l10n.detailBookmarkLabel,
              style: TextStyle(
                color: foreground,
                fontSize: DetailConstants.footerActionFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
