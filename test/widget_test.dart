import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Search view renders health smoke result', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SearchView(healthCheck: Future.value('OK')),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('検索画面（プレースホルダー）'), findsOneWidget);
    expect(find.text('Health: OK'), findsOneWidget);
  });
}
