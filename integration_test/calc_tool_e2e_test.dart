import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'completes BMI, eGFR, CrCl, restore, and delete flow',
    (
      tester,
    ) async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      ApiConfig.initialize(
        const FlavorConfig(
          flavor: Flavor.dev,
          apiBaseUrl: 'http://localhost:8080',
        ),
      );
      runApp(
        ProviderScope(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
          child: App(),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(MaterialApp), findsOneWidget);
      await _pumpUntil(tester, find.byType(DisclaimerRibbon));
      expect(find.byType(DisclaimerRibbon), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(
        tester.getBottomLeft(find.byType(DisclaimerRibbon)).dy,
        lessThanOrEqualTo(tester.getTopLeft(find.byType(NavigationBar)).dy),
      );

      await tester.tap(find.text('計算ツール').last);
      await _pumpUntil(
        tester,
        find.byKey(const ValueKey<String>('calc-input-heightCm')),
      );
      await _pumpUntil(tester, find.textContaining('履歴 ('));

      expect(_visibleHistoryCount(tester), 0);

      await _enterInput(tester, 'calc-input-heightCm', '170');
      expect(_textFieldValue(tester, 'calc-input-heightCm'), '170');
      await _enterInput(tester, 'calc-input-weightKg', '65');
      expect(_textFieldValue(tester, 'calc-input-weightKg'), '65');
      await _pumpUntilResult(tester, '22.5');
      expect(find.text('普通体重'), findsWidgets);
      await _pumpUntilHistoryCount(tester, 1);

      await _selectTool(tester, 'eGFR');
      await _pumpUntilHistoryCount(tester, 0);
      await _enterInput(tester, 'calc-input-ageYears', '45');
      await _enterInput(tester, 'calc-input-serumCreatinineMgDl', '0.9');
      await _pumpUntilResultNotPlaceholder(tester);
      expect(find.text('G2 軽度低下'), findsWidgets);
      await _pumpUntilHistoryCount(tester, 1);

      await _selectTool(tester, 'CrCl');
      await _pumpUntilHistoryCount(tester, 0);
      await _enterInput(tester, 'calc-input-ageYears', '45');
      await _enterInput(tester, 'calc-input-weightKg', '65');
      await _enterInput(tester, 'calc-input-serumCreatinineMgDl', '0.9');
      await _pumpUntilResultNotPlaceholder(tester);
      await _pumpUntilHistoryCount(tester, 1);

      await _selectTool(tester, 'BMI');
      await _pumpUntilHistoryCount(tester, 1);

      await _expandHistoryIfNeeded(tester);
      final bmiRow = _richTextContaining('BMI 22.5').first;
      await _pumpUntil(tester, bmiRow);
      await tester.ensureVisible(bmiRow);
      await tester.tap(bmiRow);
      await _pumpUntilResult(tester, '22.5');
      expect(_textFieldValue(tester, 'calc-input-heightCm'), '170');
      expect(_textFieldValue(tester, 'calc-input-weightKg'), '65');

      await _expandHistoryIfNeeded(tester);
      final restoredBmiRow = _richTextContaining('BMI 22.5').first;
      await _pumpUntil(tester, restoredBmiRow);
      await tester.ensureVisible(restoredBmiRow);
      await tester.drag(restoredBmiRow, const Offset(-320, 0));
      await _pumpShort(tester);
      await tester.tap(find.text('削除').first);
      await _pumpUntilHistoryCount(tester, 0);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

Future<void> _selectTool(WidgetTester tester, String label) async {
  final target = find.text(label).first;
  await tester.ensureVisible(target);
  await tester.tap(target);
  await _pumpShort(tester);
}

Future<void> _enterInput(
  WidgetTester tester,
  String key,
  String value,
) async {
  final target = _inputField(key);
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.enterText(target, value);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await _pumpShort(tester);
}

Finder _inputField(String key) {
  return find.descendant(
    of: find.byKey(ValueKey<String>(key)),
    matching: find.byType(EditableText),
  );
}

String _textFieldValue(WidgetTester tester, String key) {
  return tester.widget<EditableText>(_inputField(key)).controller.text;
}

Finder _richTextContaining(String text) {
  return find.byWidgetPredicate(
    (widget) => widget is RichText && widget.text.toPlainText().contains(text),
  );
}

Future<void> _expandHistoryIfNeeded(WidgetTester tester) async {
  if (_richTextContaining('BMI 22.5').evaluate().isNotEmpty) {
    return;
  }

  final header = find.textContaining('履歴 (').first;
  await tester.ensureVisible(header);
  await tester.tap(header);
  await _pumpShort(tester);
}

Future<void> _pumpShort(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

Future<void> _pumpUntilResult(WidgetTester tester, String value) async {
  final end = DateTime.now().add(const Duration(seconds: 8));
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (_resultValue(tester) == value) {
      return;
    }
  }
  expect(_resultValue(tester), value);
}

Future<void> _pumpUntilResultNotPlaceholder(WidgetTester tester) async {
  final end = DateTime.now().add(const Duration(seconds: 8));
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    final result = _resultValue(tester);
    if (result != null && result != '--') {
      return;
    }
  }
  expect(_resultValue(tester), isNot('--'));
}

String? _resultValue(WidgetTester tester) {
  return tester
      .widget<Text>(find.byKey(const ValueKey<String>('calc-result-value')))
      .data;
}

Future<void> _pumpUntilHistoryCount(
  WidgetTester tester,
  int expected,
) async {
  final end = DateTime.now().add(const Duration(seconds: 8));
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (_visibleHistoryCount(tester) == expected) {
      return;
    }
  }
  expect(_visibleHistoryCount(tester), expected);
}

int _visibleHistoryCount(WidgetTester tester) {
  for (final element in find.textContaining('履歴 (').evaluate()) {
    final widget = element.widget;
    if (widget is Text) {
      final text = widget.data;
      final match = text == null
          ? null
          : RegExp(r'履歴 \((\d+)\)').firstMatch(text);
      if (match != null) {
        return int.parse(match.group(1)!);
      }
    }
  }
  return 0;
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
