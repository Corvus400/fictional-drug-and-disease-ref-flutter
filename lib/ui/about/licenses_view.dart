import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stub licenses screen. Implemented in Phase 4.
class LicensesView extends ConsumerWidget {
  /// Creates a licenses screen.
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final version = ref.watch(packageInfoProvider).value?.version ?? '--';

    return LicensePage(
      applicationName: l10n.appTitle,
      applicationVersion: version,
      applicationLegalese: l10n.aboutAppLegalese,
    );
  }
}
