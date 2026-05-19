part of 'calc_view_test.dart';

void _calcViewResultsPartialTests() {
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
}
