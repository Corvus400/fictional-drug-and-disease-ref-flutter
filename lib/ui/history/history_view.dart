import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Browsing history tab placeholder.
class HistoryView extends StatelessWidget {
  /// Creates a history view.
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabHistory)),
      body: Center(child: Text(l10n.historyPlaceholder)),
    );
  }
}
