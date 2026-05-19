part of 'calc_view_test.dart';

void _calcViewHistoryTests() {
  testWidgets(
    'renders collapsed and expanded calculation history [assertion 1/4]',
    (
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
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      Object.hashAll([_richTextContaining('H170/W65'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders collapsed and expanded calculation history [assertion 2/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (1)'), findsOneWidget]);

      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsNothing);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      Object.hashAll([_richTextContaining('H170/W65'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders collapsed and expanded calculation history [assertion 3/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (1)'), findsOneWidget]);

      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);
      Object.hashAll([_richTextContaining('H170/W65'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders collapsed and expanded calculation history [assertion 4/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170');
      await tester.pump();
      await tester.enterText(_inputField('calc-input-weightKg'), '65');
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (1)'), findsOneWidget]);

      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();

      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      expect(_richTextContaining('H170/W65'), findsOneWidget);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 1/14]',
    (
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
      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 2/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      expect(singleRadius.bottomRight.x, greaterThan(0));
      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 3/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      expect(singleRadius.topLeft, Radius.zero);
      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 4/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      expect(singleRadius.bottomLeft, Radius.zero);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 5/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

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

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 6/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      expect(firstRadius.topRight.x, greaterThan(0));
      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 7/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      expect(firstRadius.bottomRight, Radius.zero);
      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 8/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      expect(firstRadius.topLeft, Radius.zero);
      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 9/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      expect(firstRadius.bottomLeft, Radius.zero);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 10/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      expect(middleRadius, BorderRadius.zero);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 11/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      expect(lastRadius.topRight, Radius.zero);
      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 12/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      expect(lastRadius.bottomRight.x, greaterThan(0));
      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 13/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      expect(lastRadius.topLeft, Radius.zero);
      Object.hashAll([lastRadius.bottomLeft, Radius.zero]);
    },
  );

  testWidgets(
    'rounds only exposed right edges in history rows [assertion 14/14]',
    (
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
      Object.hashAll([singleRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([singleRadius.topLeft, Radius.zero]);

      Object.hashAll([singleRadius.bottomLeft, Radius.zero]);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();

      await tester.pumpWidget(
        _testApp(db, calcState: _historyStateForRows(3)),
      );
      await tester.pumpAndSettle();

      final rowClips = find.byKey(const ValueKey<String>('history-row-clip'));
      Object.hashAll([rowClips, findsNWidgets(3)]);

      final firstRadius = _borderRadiusAt(tester, rowClips, 0);
      final middleRadius = _borderRadiusAt(tester, rowClips, 1);
      final lastRadius = _borderRadiusAt(tester, rowClips, 2);

      Object.hashAll([firstRadius.topRight.x, greaterThan(0)]);

      Object.hashAll([firstRadius.bottomRight, Radius.zero]);

      Object.hashAll([firstRadius.topLeft, Radius.zero]);

      Object.hashAll([firstRadius.bottomLeft, Radius.zero]);

      Object.hashAll([middleRadius, BorderRadius.zero]);

      Object.hashAll([lastRadius.topRight, Radius.zero]);

      Object.hashAll([lastRadius.bottomRight.x, greaterThan(0)]);

      Object.hashAll([lastRadius.topLeft, Radius.zero]);

      expect(lastRadius.bottomLeft, Radius.zero);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 1/6]',
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
      Object.hashAll([_deleteRevealWidthAt(tester, 1), 72]);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (2)'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      ]);

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 2/6]',
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

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);

      expect(_deleteRevealWidthAt(tester, 1), 72);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (2)'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      ]);

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 3/6]',
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

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);

      Object.hashAll([_deleteRevealWidthAt(tester, 1), 72]);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('履歴 (2)'), findsOneWidget);
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      ]);

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 4/6]',
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

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);

      Object.hashAll([_deleteRevealWidthAt(tester, 1), 72]);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (2)'), findsOneWidget]);

      expect(
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      ]);

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 5/6]',
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

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);

      Object.hashAll([_deleteRevealWidthAt(tester, 1), 72]);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (2)'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      );
      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);
    },
  );

  testWidgets(
    'keeps other revealed delete actions visible after deleting one row [assertion 6/6]',
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

      Object.hashAll([_deleteRevealWidthAt(tester, 0), 72]);

      Object.hashAll([_deleteRevealWidthAt(tester, 1), 72]);

      await tester.tap(
        find.byKey(const ValueKey<String>('history-delete')).first,
      );
      await tester.pumpAndSettle();

      Object.hashAll([find.text('履歴 (2)'), findsOneWidget]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-0')),
        findsNothing,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-history-bmi-history-1')),
        findsOneWidget,
      ]);

      expect(_deleteRevealWidthAt(tester, 0), 72);
    },
  );

  testWidgets(
    'keeps history content alive while collapse animation runs [assertion 1/4]',
    (
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
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pump(const Duration(milliseconds: 160));
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pumpAndSettle();
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);
    },
  );

  testWidgets(
    'keeps history content alive while collapse animation runs [assertion 2/4]',
    (
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
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pump();
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 160));
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pumpAndSettle();
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);
    },
  );

  testWidgets(
    'keeps history content alive while collapse animation runs [assertion 3/4]',
    (
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
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pump();
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pump(const Duration(milliseconds: 160));
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget);

      await tester.pumpAndSettle();
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsNothing]);
    },
  );

  testWidgets(
    'keeps history content alive while collapse animation runs [assertion 4/4]',
    (
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
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pump();
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pump(const Duration(milliseconds: 160));
      Object.hashAll([_richTextContaining('BMI 22.5 (普通体重)'), findsOneWidget]);

      await tester.pumpAndSettle();
      expect(_richTextContaining('BMI 22.5 (普通体重)'), findsNothing);
    },
  );

  testWidgets(
    'restores a history row without artificial delay [assertion 1/4]',
    (
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

      Object.hashAll([find.text('復元中…'), findsNothing]);

      final resultValue = tester.widget<Text>(
        find.byKey(const ValueKey<String>('calc-result-value')),
      );
      Object.hashAll([resultValue.data, '22.5']);

      final heightInput = tester.widget<EditableText>(
        find.descendant(
          of: _inputField('calc-input-heightCm'),
          matching: find.byType(EditableText),
        ),
      );
      Object.hashAll([heightInput.controller.text, '170']);
    },
  );

  testWidgets(
    'restores a history row without artificial delay [assertion 2/4]',
    (
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
      Object.hashAll([find.text('20.1'), findsWidgets]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();
      await tester.tap(_richTextContaining('BMI 22.5 (普通体重)'));
      await tester.pump();

      expect(find.text('復元中…'), findsNothing);
      final resultValue = tester.widget<Text>(
        find.byKey(const ValueKey<String>('calc-result-value')),
      );
      Object.hashAll([resultValue.data, '22.5']);

      final heightInput = tester.widget<EditableText>(
        find.descendant(
          of: _inputField('calc-input-heightCm'),
          matching: find.byType(EditableText),
        ),
      );
      Object.hashAll([heightInput.controller.text, '170']);
    },
  );

  testWidgets(
    'restores a history row without artificial delay [assertion 3/4]',
    (
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
      Object.hashAll([find.text('20.1'), findsWidgets]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();
      await tester.tap(_richTextContaining('BMI 22.5 (普通体重)'));
      await tester.pump();

      Object.hashAll([find.text('復元中…'), findsNothing]);

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
      Object.hashAll([heightInput.controller.text, '170']);
    },
  );

  testWidgets(
    'restores a history row without artificial delay [assertion 4/4]',
    (
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
      Object.hashAll([find.text('20.1'), findsWidgets]);

      await tester.tap(find.text('履歴 (1)'));
      await tester.pumpAndSettle();
      await tester.tap(_richTextContaining('BMI 22.5 (普通体重)'));
      await tester.pump();

      Object.hashAll([find.text('復元中…'), findsNothing]);

      final resultValue = tester.widget<Text>(
        find.byKey(const ValueKey<String>('calc-result-value')),
      );
      Object.hashAll([resultValue.data, '22.5']);

      final heightInput = tester.widget<EditableText>(
        find.descendant(
          of: _inputField('calc-input-heightCm'),
          matching: find.byType(EditableText),
        ),
      );
      expect(heightInput.controller.text, '170');
    },
  );

  testWidgets(
    'disables calc tool switching while history is restoring [assertion 1/2]',
    (
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
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-ageYears')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'disables calc tool switching while history is restoring [assertion 2/2]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-heightCm')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-input-ageYears')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'does not call setState after unmount during history restore [assertion 1/2]',
    (
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

      Object.hashAll([tester.takeException(), isNull]);
    },
  );

  testWidgets(
    'does not call setState after unmount during history restore [assertion 2/2]',
    (
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
      Object.hashAll([find.text('復元中…'), findsNothing]);

      await tester.pumpWidget(_testApp(db, home: const SizedBox.shrink()));
      await tester.pump();

      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'places restoring indicator in the result card for every tool [assertion 1/5]',
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
        Object.hashAll([
          (indicator.center.dx - resultPane.center.dx).abs(),
          lessThan(2),
        ]);

        Object.hashAll([find.byType(CircularProgressIndicator), findsNothing]);

        Object.hashAll([find.text('復元中…'), findsNothing]);

        Object.hashAll([
          find.byWidgetPredicate(
            (widget) => widget is Skeletonizer && widget.enabled,
          ),
          findsOneWidget,
        ]);
      }
    },
  );

  testWidgets(
    'places restoring indicator in the result card for every tool [assertion 2/5]',
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

        Object.hashAll([resultPane.contains(indicator.center), isTrue]);

        expect(
          (indicator.center.dx - resultPane.center.dx).abs(),
          lessThan(2),
        );
        Object.hashAll([find.byType(CircularProgressIndicator), findsNothing]);

        Object.hashAll([find.text('復元中…'), findsNothing]);

        Object.hashAll([
          find.byWidgetPredicate(
            (widget) => widget is Skeletonizer && widget.enabled,
          ),
          findsOneWidget,
        ]);
      }
    },
  );

  testWidgets(
    'places restoring indicator in the result card for every tool [assertion 3/5]',
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

        Object.hashAll([resultPane.contains(indicator.center), isTrue]);

        Object.hashAll([
          (indicator.center.dx - resultPane.center.dx).abs(),
          lessThan(2),
        ]);

        expect(find.byType(CircularProgressIndicator), findsNothing);
        Object.hashAll([find.text('復元中…'), findsNothing]);

        Object.hashAll([
          find.byWidgetPredicate(
            (widget) => widget is Skeletonizer && widget.enabled,
          ),
          findsOneWidget,
        ]);
      }
    },
  );

  testWidgets(
    'places restoring indicator in the result card for every tool [assertion 4/5]',
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

        Object.hashAll([resultPane.contains(indicator.center), isTrue]);

        Object.hashAll([
          (indicator.center.dx - resultPane.center.dx).abs(),
          lessThan(2),
        ]);

        Object.hashAll([find.byType(CircularProgressIndicator), findsNothing]);

        expect(find.text('復元中…'), findsNothing);
        Object.hashAll([
          find.byWidgetPredicate(
            (widget) => widget is Skeletonizer && widget.enabled,
          ),
          findsOneWidget,
        ]);
      }
    },
  );

  testWidgets(
    'places restoring indicator in the result card for every tool [assertion 5/5]',
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

        Object.hashAll([resultPane.contains(indicator.center), isTrue]);

        Object.hashAll([
          (indicator.center.dx - resultPane.center.dx).abs(),
          lessThan(2),
        ]);

        Object.hashAll([find.byType(CircularProgressIndicator), findsNothing]);

        Object.hashAll([find.text('復元中…'), findsNothing]);

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
