part of 'calc_view_test.dart';

void _calcViewInputKeyboardTests() {
  testWidgets('renders BMI form instead of placeholder [assertion 1/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    expect(find.text('計算ツール画面（プレースホルダー）'), findsNothing);
    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 2/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    expect(find.text('BMI'), findsWidgets);
    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 3/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    expect(find.text('eGFR'), findsOneWidget);
    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 4/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    expect(find.text('CrCl'), findsOneWidget);
    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 5/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    expect(
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    );
    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 6/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    expect(
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    );
    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 7/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    expect(find.text('すべての項目を入力してください'), findsOneWidget);
    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 8/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    expect(find.text('履歴 (0)'), findsOneWidget);
    Object.hashAll([find.text('履歴はありません'), findsOneWidget]);
  });

  testWidgets('renders BMI form instead of placeholder [assertion 9/9]', (
    tester,
  ) async {
    await tester.pumpWidget(_testApp(db));
    await tester.pumpAndSettle();

    Object.hashAll([find.text('計算ツール画面（プレースホルダー）'), findsNothing]);

    Object.hashAll([find.text('BMI'), findsWidgets]);

    Object.hashAll([find.text('eGFR'), findsOneWidget]);

    Object.hashAll([find.text('CrCl'), findsOneWidget]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-heightCm')),
      findsOneWidget,
    ]);

    Object.hashAll([
      find.byKey(const ValueKey<String>('calc-input-weightKg')),
      findsOneWidget,
    ]);

    Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

    Object.hashAll([find.text('履歴 (0)'), findsOneWidget]);

    expect(find.text('履歴はありません'), findsOneWidget);
  });

  testWidgets(
    'renders input range placeholders from field specs [assertion 1/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      expect(find.text('50.0〜250.0'), findsOneWidget);
      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 2/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      expect(find.text('1.0〜300.0'), findsOneWidget);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 3/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('18〜120'), findsOneWidget);
      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 4/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      expect(find.text('0.10〜20.00'), findsOneWidget);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 5/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.text('18〜120'), findsOneWidget);
      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 6/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      expect(find.text('1.0〜300.0'), findsOneWidget);
      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);
    },
  );

  testWidgets(
    'renders input range placeholders from field specs [assertion 7/7]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([find.text('50.0〜250.0'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('0.10〜20.00'), findsOneWidget]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([find.text('18〜120'), findsOneWidget]);

      Object.hashAll([find.text('1.0〜300.0'), findsOneWidget]);

      expect(find.text('0.10〜20.00'), findsOneWidget);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 1/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-heightCm'), '170.5');

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 2/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-heightCm'), '170.5');

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 3/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-weightKg'), isEmpty);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 4/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-weightKg'), isEmpty);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 5/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-ageYears'), isEmpty);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 6/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      expect(_inputText(tester, 'calc-input-ageYears'), '120');

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 7/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

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
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 8/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

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
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);
    },
  );

  testWidgets(
    'filters calc inputs by each field numeric grammar [assertion 9/9]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.enterText(_inputField('calc-input-heightCm'), '170.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-heightCm'), '170.55');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-heightCm'), '170.5']);

      await tester.enterText(_inputField('calc-input-weightKg'), '.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.enterText(_inputField('calc-input-weightKg'), '1..5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-weightKg'), isEmpty]);

      await tester.tap(find.text('eGFR'), warnIfMissed: false);
      await tester.pumpAndSettle();

      await tester.enterText(_inputField('calc-input-ageYears'), '1.5');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), isEmpty]);

      await tester.enterText(_inputField('calc-input-ageYears'), '120');
      await tester.pump();
      Object.hashAll([_inputText(tester, 'calc-input-ageYears'), '120']);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.23',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '1.234',
      );
      await tester.pump();
      Object.hashAll([
        _inputText(tester, 'calc-input-serumCreatinineMgDl'),
        '1.23',
      ]);

      await tester.enterText(
        _inputField('calc-input-serumCreatinineMgDl'),
        '%@#',
      );
      await tester.pump();
      expect(_inputText(tester, 'calc-input-serumCreatinineMgDl'), '1.23');
    },
  );

  testWidgets(
    'shows a field range error as soon as one value is out of range [assertion 1/4]',
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
      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      ]);

      Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

      Object.hashAll([find.text('22.5'), findsNothing]);
    },
  );

  testWidgets(
    'shows a field range error as soon as one value is out of range [assertion 2/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      await tester.enterText(_inputField('calc-input-heightCm'), '9');
      await tester.pump();

      Object.hashAll([find.text('50.0-250.0 cm'), findsOneWidget]);

      expect(
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      );
      Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

      Object.hashAll([find.text('22.5'), findsNothing]);
    },
  );

  testWidgets(
    'shows a field range error as soon as one value is out of range [assertion 3/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      await tester.enterText(_inputField('calc-input-heightCm'), '9');
      await tester.pump();

      Object.hashAll([find.text('50.0-250.0 cm'), findsOneWidget]);

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      ]);

      expect(find.text('すべての項目を入力してください'), findsOneWidget);
      Object.hashAll([find.text('22.5'), findsNothing]);
    },
  );

  testWidgets(
    'shows a field range error as soon as one value is out of range [assertion 4/4]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      await tester.enterText(_inputField('calc-input-heightCm'), '9');
      await tester.pump();

      Object.hashAll([find.text('50.0-250.0 cm'), findsOneWidget]);

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      ]);

      Object.hashAll([find.text('すべての項目を入力してください'), findsOneWidget]);

      expect(find.text('22.5'), findsNothing);
    },
  );

  testWidgets(
    'uses next actions before the last field and done at the end [assertion 1/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      expect(
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      );
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      ]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      ]);
    },
  );

  testWidgets(
    'uses next actions before the last field and done at the end [assertion 2/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      ]);

      expect(
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      );

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      ]);
    },
  );

  testWidgets(
    'uses next actions before the last field and done at the end [assertion 3/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      ]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      );
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      ]);
    },
  );

  testWidgets(
    'uses next actions before the last field and done at the end [assertion 4/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      ]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      ]);

      expect(
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      );
      Object.hashAll([
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      ]);
    },
  );

  testWidgets(
    'uses next actions before the last field and done at the end [assertion 5/5]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.done,
      ]);

      await tester.tap(find.text('CrCl'), warnIfMissed: false);
      await tester.pumpAndSettle();

      Object.hashAll([
        _editableText(tester, 'calc-input-ageYears').textInputAction,
        TextInputAction.next,
      ]);

      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').textInputAction,
        TextInputAction.next,
      ]);

      expect(
        _editableText(
          tester,
          'calc-input-serumCreatinineMgDl',
        ).textInputAction,
        TextInputAction.done,
      );
    },
  );

  testWidgets(
    'keeps iPad layout when the software keyboard reduces height [assertion 1/2]',
    (
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
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'keeps iPad layout when the software keyboard reduces height [assertion 2/2]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-layout-ipad-portrait')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'keeps iPad landscape layout when the shell body is keyboard-reduced [assertion 1/2]',
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
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsNothing,
      ]);
    },
  );

  testWidgets(
    'keeps iPad landscape layout when the shell body is keyboard-reduced [assertion 2/2]',
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-layout-ipad-landscape')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-layout-landscape-phone')),
        findsNothing,
      );
    },
  );

  testWidgets(
    'uses numbers-first full keyboard for numeric fields on iPad iOS [assertion 1/2]',
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
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').keyboardType,
        TextInputType.datetime,
      ]);
    },
  );

  testWidgets(
    'uses numbers-first full keyboard for numeric fields on iPad iOS [assertion 2/2]',
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

      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').keyboardType,
        TextInputType.datetime,
      ]);

      expect(
        _editableText(tester, 'calc-input-weightKg').keyboardType,
        TextInputType.datetime,
      );
    },
  );

  testWidgets(
    'shows iOS input toolbar and moves focus with it [assertion 1/5]',
    (
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
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'shows iOS input toolbar and moves focus with it [assertion 2/5]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      );
      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'shows iOS input toolbar and moves focus with it [assertion 3/5]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      ]);

      expect(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'shows iOS input toolbar and moves focus with it [assertion 4/5]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      ]);

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
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'shows iOS input toolbar and moves focus with it [assertion 5/5]',
    (
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

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
        findsOneWidget,
      ]);

      Object.hashAll([
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
        findsOneWidget,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-next')),
      );
      await tester.pumpAndSettle();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.tap(
        find.byKey(const ValueKey<String>('calc-input-toolbar-done')),
      );
      await tester.pumpAndSettle();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      );
    },
  );

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

  testWidgets(
    'moves focus through calc fields with keyboard actions [assertion 1/3]',
    (
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
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'moves focus through calc fields with keyboard actions [assertion 2/3]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pump();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      );

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      ]);
    },
  );

  testWidgets(
    'moves focus through calc fields with keyboard actions [assertion 3/3]',
    (
      tester,
    ) async {
      await tester.pumpWidget(_testApp(db));
      await tester.pump();

      await tester.tap(_inputField('calc-input-heightCm'));
      await tester.pump();
      Object.hashAll([
        _editableText(tester, 'calc-input-heightCm').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pump();
      Object.hashAll([
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isTrue,
      ]);

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      expect(
        _editableText(tester, 'calc-input-weightKg').focusNode.hasFocus,
        isFalse,
      );
    },
  );
}
