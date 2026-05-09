import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app_uses_themeMode_from_settings_provider_(T01)', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});

    await tester.pumpWidget(ProviderScope(child: App()));
    await tester.pumpAndSettle();

    final material = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(material.themeMode, ThemeMode.dark);
  });

  testWidgets('app overlays DisclaimerRibbon above the NavigationBar', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(ProviderScope(child: App()));
    await tester.pumpAndSettle();

    expect(find.byType(DisclaimerRibbon), findsOneWidget);
    final positioned = tester.widget<Positioned>(
      find.ancestor(
        of: find.byType(DisclaimerRibbon),
        matching: find.byType(Positioned),
      ),
    );
    expect(positioned.bottom, 80);
    expect(positioned.left, 0);
    expect(positioned.right, 0);
  });
}
