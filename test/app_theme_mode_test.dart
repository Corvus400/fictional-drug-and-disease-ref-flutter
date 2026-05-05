import 'package:fictional_drug_and_disease_ref/app.dart';
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
}
