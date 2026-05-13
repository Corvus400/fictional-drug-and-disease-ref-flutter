import 'package:fictional_drug_and_disease_ref/application/usecases/record_calculation_history_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/calculation_history_repository.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/calc_type.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_inputs_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/codecs/calc_result_codec.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/crcl.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/sex.dart';
import 'package:fictional_drug_and_disease_ref/domain/calculation_history/calculation_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_notifier.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_screen_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

    testWidgets('renders input range placeholders from field specs', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      expect(find.text('50.0〜250.0'), findsOneWidget);
      expect(find.text('1.0〜300.0'), findsOneWidget);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('18〜120'), findsOneWidget);
      expect(find.text('0.10〜20.00'), findsOneWidget);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('18〜120'), findsOneWidget);
      expect(find.text('1.0〜300.0'), findsOneWidget);
      expect(find.text('0.10〜20.00'), findsOneWidget);
    });

    testWidgets('filters calc inputs by each field numeric grammar', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-heightCm'), '170.5');

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-heightCm'), '170.5');

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-weightKg'), isEmpty);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-weightKg'), isEmpty);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-ageYears'), isEmpty);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-ageYears'), '120');

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      expect(_inputText(tester, 'calc-input-serumCreatinineMgDl'), '1.23');

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      expect(_inputText(tester, 'calc-input-serumCreatinineMgDl'), '1.23');

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      expect(_inputText(tester, 'calc-input-serumCreatinineMgDl'), '1.23');
    });

    testWidgets(
      'shows a field range error as soon as one value is out of range',
      (
        tester,
      ) async {
        await tester.pumpWidget(_testApp(db));
        await tester.pump();

        await tester.tap(_inputField('calc-input-heightCm'));
        await tester.pump();
        await tester.enterText(_inputField('calc-input-heightCm'), '9');
        await tester.pump();

        expect(find.text('50.0-250.0 cm'), findsOneWidget);
        expect(
          _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
          isTrue,
        );
        expect(find.text('すべての項目を入力してください'), findsOneWidget);
        expect(find.text('22.5'), findsNothing);
      },
    );

    testWidgets('uses next actions before the last field and done at the end', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      expect(
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      );
      expect(
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      );

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      );
      expect(
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      );
      expect(
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      );
    });

    testWidgets('keeps iPad layout when the software keyboard reduces height', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _testApp(
          db,
          home: const MediaQuery(
            data: MediaQueryData(
              size: Size(834, 1194),
              viewInsets: EdgeInsets.only(bottom: 804),
            ),
            child: CalcView(),
          ),
        ),
      );
      await tester.pump();

      expect(
        find.byKey(const ValueKey<String>('calc-layout-ipad-portrait')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsNothing,
      );
    });

    testWidgets(
      'keeps iPad landscape layout when the shell body is keyboard-reduced',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1194, 834));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          _testApp(
            db,
            platform: TargetPlatform.iOS,
            home: const MediaQuery(
              data: MediaQueryData(
                size: Size(1194, 834),
                viewInsets: EdgeInsets.only(bottom: 414),
              ),
              child: Scaffold(
                body: CalcView(),
                bottomNavigationBar: SizedBox(height: 114),
              ),
            ),
          ),
        );
        await tester.pump();

        expect(
          find.byKey(const ValueKey<String>('calc-layout-ipad-landscape')),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
          findsNothing,
        );
      },
    );

    testWidgets(
      'uses numbers-first full keyboard for numeric fields on iPad iOS',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(834, 1194));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          _testApp(
            db,
            platform: TargetPlatform.iOS,
            home: const MediaQuery(
              data: MediaQueryData(size: Size(834, 1194)),
              child: CalcView(),
            ),
          ),
        );
        await tester.pump();

        expect(
          _editableText(tester, 'calc-input-heightCm').keyboardType,
          TextInputType.datetime,
        );
        expect(
          _editableText(tester, 'calc-input-weightKg').keyboardType,
          TextInputType.datetime,
        );
      },
    );

    testWidgets('shows iOS input toolbar and moves focus with it', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _testApp(
          db,
          platform: TargetPlatform.iOS,
          home: const MediaQuery(
            data: MediaQueryData(size: Size(390, 844)),
            child: CalcView(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
      );
      await tester.pumpAndSettle();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
      );
      await tester.pumpAndSettle();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      );
    });

    testWidgets('does not show custom input toolbar on iPad landscape', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1194, 834));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _testApp(
          db,
          platform: TargetPlatform.iOS,
          home: const MediaQuery(
            data: MediaQueryData(size: Size(1194, 834)),
            child: CalcView(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsNothing,
      );
    });

    testWidgets('does not show custom input toolbar on iPad portrait', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(834, 1194));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _testApp(
          db,
          platform: TargetPlatform.iOS,
          home: const MediaQuery(
            data: MediaQueryData(size: Size(834, 1194)),
            child: CalcView(),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsNothing,
      );
    });

    testWidgets('moves focus through calc fields with keyboard actions', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      expect(
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      );

      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pump();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      );

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      );
    });

    testWidgets('does not render undefined app bar action buttons', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(find.text('計算ツール'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.byIcon(Icons.history), findsNothing);
    });

    testWidgets('aligns the calc title to the same leading edge as search', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(1194, 834));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      final titleTopLeft = tester.getTopLeft(find.text('計算ツール'));
      expect(titleTopLeft.dx, lessThan(80));
    });

    testWidgets('does not toggle history when there are no rows', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Icons.history_toggle_off), findsOneWidget);
      expect(find.byIcon(Icons.expand_less), findsNothing);
      expect(find.byIcon(Icons.expand_more), findsNothing);

      await tester.tap(find.text('履歴 (0)'));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Icons.history_toggle_off), findsOneWidget);
      expect(_richTextContaining('BMI 22.5'), findsNothing);
    });

    testWidgets('history error renders the same empty history surface', (
      tester,
    ) async {
      final errorState = CalcScreenState.initial().copyWith(
        historyExpanded: true,
        history: const <CalculationHistoryEntry>[],
        historyPhase: CalcHistoryPhase.error,
      );

      await tester.pumpWidget(_testApp(db, calcState: errorState));
      await tester.pumpAndSettle();

      expect(find.text('履歴 (0)'), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(_historyHeaderIcon(Icons.history_toggle_off), findsOneWidget);
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

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
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

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
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

    testWidgets('keeps CrCl form values when editing after an error', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '1');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1',
      );
      await tester.pump();

      expect(find.text('18-120 years'), findsOneWidget);

      await tester.enterText(_inputField('calc-input-ageYears'), '-');
      await tester.pump();

      expect(_inputText(tester, 'calc-input-ageYears'), '1');
      expect(_inputText(tester, 'calc-input-weightKg'), '1');
      expect(_inputText(tester, 'calc-input-serumCreatinineMgDl'), '1');
    });

    testWidgets('renders every simultaneous BMI field error', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '49.9');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '300.1');
      await tester.pump();

      expect(find.text('50.0-250.0 cm'), findsOneWidget);
      expect(find.text('1.0-300.0 kg'), findsOneWidget);
      expect(find.text('22.5'), findsNothing);
    });

    testWidgets('renders every simultaneous eGFR field error', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.enterText(_inputField('calc-input-ageYears'), '17');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '20.1',
      );
      await tester.pump();

      expect(find.text('18-120 years'), findsOneWidget);
      expect(find.text('0.10-20.00 mg/dL'), findsOneWidget);
      expect(find.text('63.1'), findsNothing);
    });

    testWidgets('renders every simultaneous CrCl field error', (tester) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();
      await tester.enterText(_inputField('calc-input-ageYears'), '17');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '0.9');
      await tester.pump();
      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '20.1',
      );
      await tester.pump();

      expect(find.text('18-120 years'), findsOneWidget);
      expect(find.text('1.0-300.0 kg'), findsOneWidget);
      expect(find.text('0.10-20.00 mg/dL'), findsOneWidget);
      expect(find.text('81.3'), findsNothing);
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

    testWidgets('rounds only exposed right edges in history rows', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(1)),
      );
      await tester.pumpAndSettle();

      final singleRadius = _borderRadiusAt(
        tester,
        find.byKey(const ValueKey<String>('history-row-clip')),
        0,
      );
      expect(singleRadius.topRight.x, greaterThan(0));
      expect(singleRadius.bottomRight.x, greaterThan(0));
      expect(singleRadius.topLeft, Radius.zero);
      expect(singleRadius.bottomLeft, Radius.zero);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      expect(rowClips, findsNWidgets(3));

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      expect(firstRadius.topRight.x, greaterThan(0));
      expect(firstRadius.bottomRight, Radius.zero);
      expect(firstRadius.topLeft, Radius.zero);
      expect(firstRadius.bottomLeft, Radius.zero);

      expect(middleRadius, BorderRadius.zero);

      expect(lastRadius.topRight, Radius.zero);
      expect(lastRadius.bottomRight.x, greaterThan(0));
      expect(lastRadius.topLeft, Radius.zero);
      expect(lastRadius.bottomLeft, Radius.zero);
    });

    testWidgets(
      'keeps other revealed delete actions visible after deleting one row',
      (
        tester,
      ) async {
        await _seedBmiHistory(db, count: 3);
        await tester.pumpWidget(_testApp(db));
        await tester.pumpAndSettle();

        await tester.tap(find.text('履歴 (3)'));
        await tester.pumpAndSettle();

        await tester.drag(
          find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();
        await tester.drag(
          find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
          const Offset(-140, 0),
        );
        await tester.pumpAndSettle();

        expect(_deleteRevealWidthAt(tester, 0), 72);
        expect(_deleteRevealWidthAt(tester, 1), 72);

        await tester.tap(
          find.byKey(const ValueKey<String>('history-delete')).first,
        );
        await tester.pumpAndSettle();

        expect(find.text('履歴 (2)'), findsOneWidget);
        expect(
          find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
          findsNothing,
        );
        expect(
          find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
          findsOneWidget,
        );
        expect(_deleteRevealWidthAt(tester, 0), 72);
      },
    );

    testWidgets('keeps history content alive while collapse animation runs', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pump();
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 160));
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsNothing);
    });

    testWidgets('restores a history row without artificial delay', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-heightCm'), '180');
      await tester.pump();
      expect(find.text('20.1'), findsWidgets);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();
      await tester.tap(_richTextContaining('BMI 22.5 (普通体重)'));
      await tester.pump();

      expect(find.text('復元中…'), findsNothing);
      final resultValue = tester.widget<Text>(
        find.byKey(const ValueKey<String>('calc-result-value')),
      );
      expect(resultValue.data, '22.5');
      final heightInput = tester.widget<EditableText>(
        find.descendant(
          of: _inputField('calc-input-heightCm'),
          matching: find.byType(EditableText),
        ),
      );
      expect(heightInput.controller.text, '170');
    });

    testWidgets('disables calc tool switching while history is restoring', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          db,
          home: const CalcView(
            debugRestoringHistory: true,
            debugRestoringProgressValue: 0.65,
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pump();

      expect(
        find.byKey(const ValueKey<String>('calc-input-heightCm')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('calc-input-ageYears')),
        findsNothing,
      );
    });

    testWidgets('does not call setState after unmount during history restore', (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();
      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      await tester.tap(_richTextContaining('BMI 22.5 (普通体重)'));
      await tester.pump();
      expect(find.text('復元中…'), findsNothing);

      await tester.pumpWidget(_testApp(db, home: const SizedBox.shrink()));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'places restoring indicator in the result card for every tool',
      (
        tester,
      ) async {
        const tools = [CalcType.bmi, CalcType.egfr, CalcType.crcl];

        for (final tool in tools) {
          await tester.pumpWidget(
            _testApp(
              db,
              calcState: _restoringState(tool),
              home: const CalcView(
                debugRestoringHistory: true,
                debugRestoringProgressValue: 0.65,
              ),
            ),
          );
          await tester.pump();

          final resultPane = tester.getRect(
            find.byKey(const ValueKey<String>('calc-result-pane')),
          );
          final indicator = tester.getRect(
            find.byKey(
              const ValueKey<String>('calc-history-restoring-indicator'),
            ),
          );

          expect(resultPane.contains(indicator.center), isTrue);
          expect(
            (indicator.center.dx - resultPane.center.dx).abs(),
            lessThan(2),
          );
        }
      },
    );
  });
}

Finder _inputField(String key) {
  return find.descendant(
    of: find.byKey(ValueKey<String>(key)),
    matching: find.byType(TextFormField),
  );
}

String _inputText(WidgetTester tester, String key) {
  return tester.widget<TextFormField>(_inputField(key)).controller!.text;
}

EditableText _editableText(WidgetTester tester, String key) {
  return tester.widget<EditableText>(
    find.descendant(
      of: find.byKey(ValueKey<String>(key)),
      matching: find.byType(EditableText),
    ),
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

BorderRadius _borderRadiusAt(WidgetTester tester, Finder finder, int index) {
  return tester.widget<ClipRRect>(finder.at(index)).borderRadius
      as BorderRadius;
}

double _deleteRevealWidthAt(WidgetTester tester, int index) {
  return tester
      .getSize(
        find.byKey(const ValueKey<String>('history-delete-reveal')).at(index),
      )
      .width;
}

CalcScreenState _historyStateForRows(int count) {
  return CalcScreenState.initial().copyWith(
    historyExpanded: true,
    historyPhase: CalcHistoryPhase.loaded,
    history: List<CalculationHistoryEntry>.generate(count, _bmiHistoryEntry),
  );
}

CalculationHistoryEntry _bmiHistoryEntry(int index) {
  const inputsCodec = CalculationInputsCodec();
  const resultCodec = CalculationResultCodec();
  final inputs = BmiInputs(
    heightCm: 170.0 + index,
    weightKg: 65.0 + index,
  );
  final result = Bmi.calculate(inputs);

  return CalculationHistoryEntry(
    id: 'history-radius-$index',
    calcType: CalcType.bmi.storageKey,
    inputsJson: inputsCodec.encode(inputs),
    resultJson: resultCodec.encode(result),
    calculatedAt: DateTime.utc(2026, 5, 10 - index),
  );
}

Future<void> _seedBmiHistory(AppDatabase db, {required int count}) async {
  final repository = CalculationHistoryRepository(db.calculationHistoriesDao);
  final samples = <({double heightCm, double weightKg, BmiCategory category})>[
    (heightCm: 170, weightKg: 65, category: BmiCategory.normal),
    (heightCm: 172, weightKg: 72, category: BmiCategory.normal),
    (heightCm: 168, weightKg: 74, category: BmiCategory.overweight),
  ];

  for (var index = 0; index < count; index += 1) {
    final sample = samples[index % samples.length];
    final inputs = BmiInputs(
      heightCm: sample.heightCm,
      weightKg: sample.weightKg,
    );
    final bmi =
        sample.weightKg / ((sample.heightCm / 100) * (sample.heightCm / 100));
    final usecase = RecordCalculationHistoryUsecase(
      calculationHistoryRepository: repository,
      clock: () => DateTime.utc(2026, 5, 10 - index),
      idFactory: () => 'bmi-history-$index',
    );
    await usecase.execute(
      CalcType.bmi,
      inputs,
      BmiResult(bmi: bmi, category: sample.category),
    );
  }
}

Future<void> _tapSex(WidgetTester tester, String label) async {
  final finder = find.text(label);
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Widget _testApp(
  AppDatabase db, {
  TextScaler? textScaler,
  TargetPlatform? platform,
  CalcScreenState? calcState,
  Widget home = const CalcView(),
}) {
  final theme = AppTheme.light();
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      if (calcState != null)
        calcScreenProvider.overrideWithBuild((ref, notifier) => calcState),
    ],
    child: MaterialApp(
      theme: platform == null ? theme : theme.copyWith(platform: platform),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: textScaler == null
          ? null
          : (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: textScaler),
              child: child!,
            ),
      home: home,
    ),
  );
}

CalcScreenState _restoringState(CalcType tool) {
  return switch (tool) {
    CalcType.bmi => _bmiRestoringState(),
    CalcType.egfr => _egfrRestoringState(),
    CalcType.crcl => _crclRestoringState(),
  };
}

CalcScreenState _bmiRestoringState() {
  const inputs = BmiInputs(heightCm: 170, weightKg: 65);
  final result = BmiResult(
    bmi: inputs.weightKg / ((inputs.heightCm / 100) * (inputs.heightCm / 100)),
    category: BmiCategory.normal,
  );
  return CalcScreenState(
    activeTool: CalcType.bmi,
    phase: CalcPhase.resultWithClassification(
      CalcType.bmi,
      inputs,
      result,
      result.category,
    ),
    historyExpanded: false,
    history: const [],
    historyPhase: CalcHistoryPhase.loaded,
  );
}

CalcScreenState _egfrRestoringState() {
  const inputs = EgfrInputs(
    ageYears: 50,
    sex: Sex.male,
    serumCreatinineMgDl: 1,
  );
  const result = EgfrResult(eGfrMlMin173m2: 63.1, stage: CkdStage.g2);
  return CalcScreenState(
    activeTool: CalcType.egfr,
    phase: CalcPhase.resultWithClassification(
      CalcType.egfr,
      inputs,
      result,
      result.stage,
    ),
    historyExpanded: false,
    history: const [],
    historyPhase: CalcHistoryPhase.loaded,
  );
}

CalcScreenState _crclRestoringState() {
  const inputs = CrClInputs(
    ageYears: 50,
    sex: Sex.male,
    weightKg: 65,
    serumCreatinineMgDl: 1,
  );
  const result = CrClResult(crClMlMin: 81.3);
  return const CalcScreenState(
    activeTool: CalcType.crcl,
    phase: CalcPhase.validInput(CalcType.crcl, inputs, result),
    historyExpanded: false,
    history: [],
    historyPhase: CalcHistoryPhase.loaded,
  );
}
