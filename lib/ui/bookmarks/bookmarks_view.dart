import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Bookmarks tab placeholder.
class BookmarksView extends StatelessWidget {
  /// Creates a bookmarks view.
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabBookmarks)),
      body: Center(child: Text(l10n.bookmarksPlaceholder)),
    );
  }
}
