import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Search tab placeholder.
class SearchView extends StatelessWidget {
  /// Creates a search view.
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabSearch)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.searchPlaceholder),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(AppRoutes.drugDetail('drug_0001')),
              child: Text(l10n.openDrugDetail),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => context.go(
                AppRoutes.diseaseDetail('disease_0001'),
              ),
              child: Text(l10n.openDiseaseDetail),
            ),
          ],
        ),
      ),
    );
  }
}
