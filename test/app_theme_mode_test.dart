import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUpAll(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDownAll(() async {
    await db.close();
  });

  testWidgets('app_uses_themeMode_from_settings_provider_(T01)', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: App(),
      ),
    );
    await tester.pumpAndSettle();

    final material = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(material.themeMode, ThemeMode.dark);
  });

  testWidgets('app overlays DisclaimerRibbon above the NavigationBar', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DisclaimerRibbon), findsOneWidget);
    final semantics = tester.widget<Semantics>(
      find.descendant(
        of: find.byType(DisclaimerRibbon),
        matching: find.byType(Semantics),
      ),
    );
    expect(
      semantics.properties.label,
      '免責: 架空データ・医療判断には使用しないでください',
    );
    expect(
      find.ancestor(
        of: find.byType(DisclaimerRibbon),
        matching: find.byType(Positioned),
      ),
      findsNothing,
    );
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      tester.getBottomLeft(find.byType(DisclaimerRibbon)).dy,
      lessThanOrEqualTo(tester.getTopLeft(find.byType(NavigationBar)).dy),
    );
  });
}
