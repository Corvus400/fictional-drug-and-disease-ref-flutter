import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Drug detail placeholder.
class DrugDetailView extends StatelessWidget {
  /// Creates a drug detail view.
  const DrugDetailView({required this.id, super.key});

  /// Drug identifier.
  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.drugDetailTitle)),
      body: Center(child: Text(l10n.detailId(id))),
    );
  }
}
