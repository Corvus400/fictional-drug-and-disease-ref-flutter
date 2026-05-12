import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Top-level shell destinations shared by tab chrome and bottom navigation.
enum AppShellTab {
  /// Search tab.
  search(icon: Icons.search),

  /// Bookmarks tab.
  bookmarks(icon: Icons.bookmark_outline),

  /// Browsing history tab.
  history(icon: Icons.history),

  /// Calculation tools tab.
  calc(icon: Icons.calculate_outlined)
  ;

  const AppShellTab({required this.icon});

  /// Icon used by the bottom navigation destination.
  final IconData icon;

  /// Localized label shared by the bottom navigation and tab header.
  String label(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      AppShellTab.search => l10n.tabSearch,
      AppShellTab.bookmarks => l10n.tabBookmarks,
      AppShellTab.history => l10n.tabHistory,
      AppShellTab.calc => l10n.tabCalc,
    };
  }
}
