part of 'calc_view_test.dart';

void _calcViewHistoryTests() {
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
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('復元中…'), findsNothing);
        expect(
          find.byWidgetPredicate(
            (widget) => widget is Skeletonizer && widget.enabled,
          ),
          findsOneWidget,
        );
      }
    },
  );
}
