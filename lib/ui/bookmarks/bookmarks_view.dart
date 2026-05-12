import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';

/// Bookmarks tab placeholder.
class BookmarksView extends StatelessWidget {
  /// Creates a bookmarks view.
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final toolbarHeight = MediaQuery.sizeOf(context).shortestSide >= 600
        ? 64.0
        : 56.0;
    return Scaffold(
      appBar: AppTabHeader(
        tab: AppShellTab.bookmarks,
        toolbarHeight: toolbarHeight,
      ),
      body: Center(child: Text(l10n.bookmarksPlaceholder)),
    );
  }
}
