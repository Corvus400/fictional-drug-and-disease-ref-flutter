import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('CalcView', () {
    late AppDatabase db;

    setUpAll(() {
      db = createTestAppDatabase();
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
    });

    tearDownAll(() async {
      await db.close();
    });

    testWidgets('renders BMI form instead of placeholder', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(find.text('計算ツール画面（プレースホルダー）'), findsNothing);
      expect(find.text('BMI'), findsWidgets);
      expect(find.text('eGFR'), findsOneWidget);
      expect(find.text('CrCl'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('calc-input-heightCm')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-input-weightKg')),
        findsOneWidget,
      );
      expect(find.text('すべての項目を入力してください'), findsOneWidget);
      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
    });

    testWidgets('does not render undefined app bar action buttons', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(find.text('計算ツール'), findsOneWidget);
      expect(find.byIcon(Symbols.menu), findsNothing);
      expect(find.byIcon(Symbols.history), findsNothing);
    });

    testWidgets('does not toggle history when there are no rows', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Symbols.history_toggle_off), findsOneWidget);
      expect(find.byIcon(Symbols.expand_less), findsNothing);
      expect(find.byIcon(Symbols.expand_more), findsNothing);

      await tester.tap(find.text('履歴 (0)'));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Symbols.history_toggle_off), findsOneWidget);
      expect(_richTextContaining('BMI 22.5'), findsNothing);
    });

    testWidgets('updates BMI result while values are entered', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump();

      expect(find.text('22.5'), findsWidgets);
      expect(find.text('普通体重'), findsOneWidget);
      expect(find.text('すべての項目を入力してください'), findsNothing);
    });

    testWidgets('switches to eGFR form with sex selector', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-input-ageYears')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-input-serumCreatinineMgDl')),
        findsOneWidget,
      );
      expect(find.text('男性'), findsOneWidget);
      expect(find.text('女性'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('calc-input-heightCm')),
        findsNothing,
      );
    });

    testWidgets('keeps every incomplete numeric subset in partial state', (
      tester,
    ) async {
      final cases =
          <
            ({
              String name,
              String toolLabel,
              Map<String, String> fields,
            })
          >[
            (
              name: 'bmi height only',
              toolLabel: 'BMI',
              fields: {'calc-input-heightCm': '170'},
            ),
            (
              name: 'bmi weight only',
              toolLabel: 'BMI',
              fields: {'calc-input-weightKg': '65'},
            ),
            (
              name: 'egfr age only',
              toolLabel: 'eGFR',
              fields: {'calc-input-ageYears': '50'},
            ),
            (
              name: 'egfr creatinine only',
              toolLabel: 'eGFR',
              fields: {'calc-input-serumCreatinineMgDl': '1.0'},
            ),
            (
              name: 'crcl age only',
              toolLabel: 'CrCl',
              fields: {'calc-input-ageYears': '50'},
            ),
            (
              name: 'crcl weight only',
              toolLabel: 'CrCl',
              fields: {'calc-input-weightKg': '65'},
            ),
            (
              name: 'crcl creatinine only',
              toolLabel: 'CrCl',
              fields: {'calc-input-serumCreatinineMgDl': '1.0'},
            ),
            (
              name: 'crcl age weight',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-weightKg': '65',
              },
            ),
            (
              name: 'crcl age creatinine',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
            ),
            (
              name: 'crcl weight creatinine',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-weightKg': '65',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
            ),
          ];

      for (final partialCase in cases) {
        await tester.pumpWidget(_testApp(db));
        await tester.pumpAndSettle();
        if (partialCase.toolLabel != 'BMI') {
          await tester.tap(find.text(partialCase.toolLabel));
          await tester.pumpAndSettle();
        }
        for (final entry in partialCase.fields.entries) {
          await tester.enterText(_inputField(entry.key), entry.value);
          await tester.pump();
        }

        expect(
          find.text('すべての項目を入力してください'),
          findsOneWidget,
          reason: partialCase.name,
        );
        expect(find.text('22.5'), findsNothing, reason: partialCase.name);
        expect(find.text('63.1'), findsNothing, reason: partialCase.name);
        expect(find.text('81.3'), findsNothing, reason: partialCase.name);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });

    testWidgets('renders eGFR CKD stage label after calculation', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();
      await tester.enterText(_inputField('calc-input-ageYears'), '50');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.0',
      );
      await tester.pump();

      expect(find.text('G2 軽度低下'), findsOneWidget);
    });

    testWidgets('renders female eGFR result with selected sex', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();
      await _tapSex(tester, '女性');
      await tester.enterText(_inputField('calc-input-ageYears'), '50');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.0',
      );
      await tester.pump();

      expect(find.text('46.6'), findsWidgets);
      expect(find.text('G3a 軽度〜中等度低下'), findsOneWidget);
    });

    testWidgets('keeps eGFR badge separate from chart marker label', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();
      await tester.enterText(_inputField('calc-input-ageYears'), '50');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.0',
      );
      await tester.pump();

      final badgeRect = tester.getRect(find.text('G2 軽度低下'));
      final markerLabelRect = tester.getRect(find.text('63.1').last);

      expect(
        markerLabelRect.top - badgeRect.bottom,
        greaterThanOrEqualTo(12),
      );
    });

    testWidgets('keeps low eGFR badge separate from chart marker label', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'));
      await tester.pumpAndSettle();
      await tester.enterText(_inputField('calc-input-ageYears'), '80');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '2.0',
      );
      await tester.pump();

      final badgeRect = tester.getRect(find.text('G4 高度低下'));
      final markerLabelRect = tester.getRect(find.text('25.8').last);

      expect(markerLabelRect.top - badgeRect.bottom, greaterThanOrEqualTo(12));
    });

    testWidgets(
      'keeps underweight BMI badge separate from chart marker label',
      (
        tester,
      ) async {
        await tester.pumpWidget(_testApp(db));
        await tester.pump();

        await tester.enterText(_inputField('calc-input-heightCm'), '170');
        await tester.pump();
        await tester.enterText(_inputField('calc-input-weightKg'), '52');
        await tester.pump();

        final badgeRect = tester.getRect(find.text('低体重'));
        final markerLabelRect = tester.getRect(find.text('18.0').last);

        expect(
          markerLabelRect.top - badgeRect.bottom,
          greaterThanOrEqualTo(12),
        );
      },
    );

    testWidgets('shows field error for out-of-range BMI value', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '400');
      await tester.pump();

      expect(find.text('1.0-300.0 kg'), findsOneWidget);
      expect(find.text('--'), findsWidgets);
    });

    testWidgets('renders every input lower and upper boundary error', (
      tester,
    ) async {
      final cases =
          <
            ({
              String name,
              String toolLabel,
              Map<String, String> fields,
              String errorText,
            })
          >[
            (
              name: 'bmi height low',
              toolLabel: 'BMI',
              fields: {
                'calc-input-heightCm': '49.9',
                'calc-input-weightKg': '65',
              },
              errorText: '50.0-250.0 cm',
            ),
            (
              name: 'bmi height high',
              toolLabel: 'BMI',
              fields: {
                'calc-input-heightCm': '250.1',
                'calc-input-weightKg': '65',
              },
              errorText: '50.0-250.0 cm',
            ),
            (
              name: 'bmi weight low',
              toolLabel: 'BMI',
              fields: {
                'calc-input-heightCm': '170',
                'calc-input-weightKg': '0.9',
              },
              errorText: '1.0-300.0 kg',
            ),
            (
              name: 'bmi weight high',
              toolLabel: 'BMI',
              fields: {
                'calc-input-heightCm': '170',
                'calc-input-weightKg': '300.1',
              },
              errorText: '1.0-300.0 kg',
            ),
            (
              name: 'egfr age low',
              toolLabel: 'eGFR',
              fields: {
                'calc-input-ageYears': '17',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '18-120 years',
            ),
            (
              name: 'egfr age high',
              toolLabel: 'eGFR',
              fields: {
                'calc-input-ageYears': '121',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '18-120 years',
            ),
            (
              name: 'egfr creatinine low',
              toolLabel: 'eGFR',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-serumCreatinineMgDl': '0.09',
              },
              errorText: '0.10-20.00 mg/dL',
            ),
            (
              name: 'egfr creatinine high',
              toolLabel: 'eGFR',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-serumCreatinineMgDl': '20.1',
              },
              errorText: '0.10-20.00 mg/dL',
            ),
            (
              name: 'crcl age low',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '17',
                'calc-input-weightKg': '65',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '18-120 years',
            ),
            (
              name: 'crcl age high',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '121',
                'calc-input-weightKg': '65',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '18-120 years',
            ),
            (
              name: 'crcl weight low',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-weightKg': '0.9',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '1.0-300.0 kg',
            ),
            (
              name: 'crcl weight high',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-weightKg': '300.1',
                'calc-input-serumCreatinineMgDl': '1.0',
              },
              errorText: '1.0-300.0 kg',
            ),
            (
              name: 'crcl creatinine low',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-weightKg': '65',
                'calc-input-serumCreatinineMgDl': '0.09',
              },
              errorText: '0.10-20.00 mg/dL',
            ),
            (
              name: 'crcl creatinine high',
              toolLabel: 'CrCl',
              fields: {
                'calc-input-ageYears': '50',
                'calc-input-weightKg': '65',
                'calc-input-serumCreatinineMgDl': '20.1',
              },
              errorText: '0.10-20.00 mg/dL',
            ),
          ];

      for (final boundaryCase in cases) {
        await tester.pumpWidget(_testApp(db));
        await tester.pumpAndSettle();
        if (boundaryCase.toolLabel != 'BMI') {
          await tester.tap(find.text(boundaryCase.toolLabel));
          await tester.pumpAndSettle();
        }
        for (final entry in boundaryCase.fields.entries) {
          await tester.enterText(_inputField(entry.key), entry.value);
          await tester.pump();
        }

        expect(
          find.text(boundaryCase.errorText),
          findsOneWidget,
          reason: boundaryCase.name,
        );
        expect(find.text('22.5'), findsNothing, reason: boundaryCase.name);
        expect(find.text('63.1'), findsNothing, reason: boundaryCase.name);
        expect(find.text('81.3'), findsNothing, reason: boundaryCase.name);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });

    testWidgets('uses two-pane layout in iPhone landscape', (tester) async {
      await tester.binding.setSurfaceSize(const Size(844, 390));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-selector-landscape')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-selector-bottom')),
        findsNothing,
      );

      final formLeft = tester
          .getTopLeft(find.byKey(const ValueKey<String>('calc-form-pane')))
          .dx;
      final resultLeft = tester
          .getTopLeft(find.byKey(const ValueKey<String>('calc-result-pane')))
          .dx;
      expect(formLeft, lessThan(resultLeft));
    });

    testWidgets('uses two-pane tool-list layout on iPad portrait', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-layout-ipad-portrait')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-list')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-selector-bottom')),
        findsNothing,
      );

      final formLeft = tester
          .getTopLeft(find.byKey(const ValueKey<String>('calc-form-pane')))
          .dx;
      final resultLeft = tester
          .getTopLeft(find.byKey(const ValueKey<String>('calc-result-pane')))
          .dx;
      expect(formLeft, lessThan(resultLeft));
    });

    testWidgets('stacks tool list above form on iPad landscape', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1194, 834));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-layout-ipad-landscape')),
        findsOneWidget,
      );

      final toolListFinder = find.byKey(
        const ValueKey<String>('calc-tool-list'),
      );
      final formFinder = find.byKey(const ValueKey<String>('calc-form-pane'));
      final resultFinder = find.byKey(
        const ValueKey<String>('calc-result-pane'),
      );
      final toolListLeft = tester.getTopLeft(toolListFinder).dx;
      final formLeft = tester.getTopLeft(formFinder).dx;
      final resultLeft = tester.getTopLeft(resultFinder).dx;
      final toolListBottom = tester.getBottomLeft(toolListFinder).dy;
      final formTop = tester.getTopLeft(formFinder).dy;
      final toolListHeight = tester
          .getSize(find.byKey(const ValueKey<String>('calc-tool-list')))
          .height;
      final toolListWidth = tester.getSize(toolListFinder).width;
      final egfrFormula = tester.widget<Text>(
        find.descendant(
          of: toolListFinder,
          matching: find.text(
            'eGFR = 194 × Cr⁻¹·⁰⁹⁴ × age⁻⁰·²⁸⁷ ×(0.739 if F)',
          ),
        ),
      );

      expect(toolListLeft, formLeft);
      expect(toolListBottom, lessThan(formTop));
      expect(formLeft, lessThan(resultLeft));
      expect(toolListHeight, lessThan(260));
      expect(toolListWidth, greaterThanOrEqualTo(400));
      expect(egfrFormula.overflow, isNot(TextOverflow.ellipsis));
    });

    testWidgets('falls back to compact layout at split-view width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(480, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-layout-compact')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-selector-bottom')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-tool-list')),
        findsNothing,
      );
    });

    testWidgets('uses large text dimensions when text scaler is large', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _testApp(db, textScaler: const TextScaler.linear(2)),
      );
      await tester.pumpAndSettle();

      expect(
        tester
            .getSize(
              find.byKey(const ValueKey<String>('calc-input-heightCm-box')),
            )
            .height,
        56,
      );
      final resultValue = tester.widget<Text>(
        find.byKey(const ValueKey<String>('calc-result-value')),
      );
      expect(resultValue.style?.fontSize, 54);
    });

    testWidgets('renders female CrCl result with selected sex', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('CrCl'));
      await tester.pumpAndSettle();
      await _tapSex(tester, '女性');
      await tester.enterText(_inputField('calc-input-ageYears'), '50');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.0',
      );
      await tester.pump();

      expect(find.text('69.1'), findsOneWidget);
    });

    testWidgets('renders collapsed and expanded calculation history', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (1)'), findsOneWidget);
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsNothing);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);
      expect(_richTextContaining('H170/W65'), findsOneWidget);
    });
  });
}

Finder _inputField(String key) {
  return find.descendant(
    of: find.byKey(ValueKey<String>(key)),
    matching: find.byType(TextFormField),
  );
}

Finder _richTextContaining(String text) {
  return find.byWidgetPredicate(
    (widget) => widget is RichText && widget.text.toPlainText().contains(text),
  );
}

Finder _historyHeaderIcon(IconData icon) {
  return find.byWidgetPredicate(
    (widget) =>
        widget is Icon &&
        widget.key == const ValueKey<String>('calc-history-header-icon') &&
        widget.icon == icon,
  );
}

Future<void> _tapSex(WidgetTester tester, String label) async {
  final finder = find.text(label);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Widget _testApp(AppDatabase db, {TextScaler? textScaler}) {
  return ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: textScaler == null
          ? null
          : (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: textScaler),
              child: child!,
            ),
      home: const CalcView(),
    ),
  );
}
