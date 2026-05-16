import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/about_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'about_normal',
    description: 'About normal state',
    builder: (theme, size, textScaler) {
      return ProviderScope(
        overrides: [
          packageInfoProvider.overrideWith(
            (ref) async => const AppPackageInfo(
              version: '1.0.0',
              buildNumber: '1',
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const AboutView(),
        ),
      );
    },
  );
}
