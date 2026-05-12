import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';

/// Search field for filtering bookmark rows by display name.
class BookmarkSearchBox extends StatelessWidget {
  /// Creates a bookmark search box.
  const BookmarkSearchBox({
    required this.onChanged,
    super.key,
    this.enabled = true,
  });

  /// Called when the query changes.
  final ValueChanged<String> onChanged;

  /// Whether the search field is interactive.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final borderRadius = BorderRadius.circular(
      SearchConstants.searchCardRadius,
    );
    return SizedBox(
      height: 36,
      child: TextField(
        key: const ValueKey('bookmarks-search-box'),
        enabled: enabled,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: l10n.bookmarksSearchHint,
          prefixIcon: const Icon(Icons.search, size: 20),
          prefixIconConstraints: const BoxConstraints.tightFor(
            width: 40,
            height: 36,
          ),
          filled: true,
          fillColor: palette.searchFieldBg,
          isDense: true,
          contentPadding: const EdgeInsets.only(right: 12),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
