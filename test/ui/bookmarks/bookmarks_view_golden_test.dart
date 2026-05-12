import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  runHistoryGoldenMatrix(
    fileNamePrefix: 'bookmarks_view',
    description: 'Bookmarks view',
    builder: (theme, size, deviceName, textScaler, textScalerName) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BookmarksView(),
      );
    },
  );
}
