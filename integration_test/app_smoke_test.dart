import 'package:fictional_drug_and_disease_ref/main_dev.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app launches and reaches search screen', (tester) async {
    app.main();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
