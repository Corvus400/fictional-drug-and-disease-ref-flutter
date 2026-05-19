part of 'calc_view_test.dart';

void _calcViewValidationResponsiveTests() {
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
}
