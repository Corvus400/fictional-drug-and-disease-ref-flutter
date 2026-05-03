import 'package:fictional_drug_and_disease_ref/data/services/health_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Search tab placeholder.
class SearchView extends StatefulWidget {
  /// Creates a search view.
  const SearchView({super.key, this.healthCheck});

  /// Optional health check future for tests.
  final Future<String>? healthCheck;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final Future<String> _healthCheck =
      widget.healthCheck ?? HealthService.fromConfig().ping();

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
            FutureBuilder<String>(
              future: _healthCheck,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 8),
                      Text(l10n.healthLoading),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text(l10n.healthError('${snapshot.error}'));
                }
                return Text(l10n.healthValue(snapshot.data ?? ''));
              },
            ),
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
