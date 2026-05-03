import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Disease detail placeholder.
class DiseaseDetailView extends StatelessWidget {
  /// Creates a disease detail view.
  const DiseaseDetailView({required this.id, super.key});

  /// Disease identifier.
  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.diseaseDetailTitle)),
      body: Center(child: Text(l10n.detailId(id))),
    );
  }
}
