import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
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
    super.key,
  });

  /// Whether the current detail is bookmarked.
  final bool isBookmarked;

  /// Whether a bookmark mutation is running.
  final bool isBusy;

  /// Last bookmark mutation error.
  final AppException? bookmarkError;

  /// Called when the bookmark button is tapped.
  final VoidCallback onToggleBookmark;

  /// Called when the inline error is dismissed.
  final VoidCallback onClearBookmarkError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SizedBox(
      height: DetailConstants.footerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bookmarkError != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.detailBookmarkErrorMessage),
                IconButton(
                  onPressed: onClearBookmarkError,
                  icon: const Icon(Icons.close),
                ),
                const SizedBox(width: DetailConstants.gapS),
              ],
            ),
          FilledButton.icon(
            onPressed: isBusy ? null : onToggleBookmark,
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            label: Text(
              isBookmarked ? l10n.detailBookmarkRemove : l10n.detailBookmarkAdd,
            ),
          ),
        ],
      ),
    );
  }
}
