import 'package:fictional_drug_and_disease_ref/main_dev.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('searches and opens a drug detail with hero image area', (
    tester,
  ) async {
    debugPrint('[app_smoke_test] start app.main');
    app.main();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(MaterialApp), findsOneWidget);
    debugPrint('[app_smoke_test] MaterialApp found');

    final searchField = find.byKey(const ValueKey<String>('search-field'));
    expect(searchField, findsOneWidget);
    debugPrint('[app_smoke_test] entering query');
    await tester.enterText(
      searchField,
      'トレデキム',
    );
    await tester.pump();
    expect(find.text('トレデキム'), findsOneWidget);
    debugPrint('[app_smoke_test] tapping search');
    await tester.tap(
      find.byKey(const ValueKey<String>('search-submit-button')),
    );

    debugPrint('[app_smoke_test] waiting for drug_0080 card');
    await _pumpUntil(
      tester,
      find.byKey(const ValueKey<String>('drug-card-drug_0080')),
    );
    debugPrint('[app_smoke_test] opening drug detail');
    await tester.tap(find.byKey(const ValueKey<String>('drug-card-drug_0080')));

    debugPrint('[app_smoke_test] waiting for drug detail');
    await _pumpUntil(tester, find.text('医薬品詳細'));
    expect(find.text('トレデキム'), findsWidgets);
    expect(
      find.byKey(
        const ValueKey<String>('drug-detail-hero-image-area-drug_0080'),
      ),
      findsOneWidget,
    );
    debugPrint('[app_smoke_test] completed');
  });
}

Future<void> _pumpUntil(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) {
      return;
    }
  }
  expect(finder, findsWidgets);
}
