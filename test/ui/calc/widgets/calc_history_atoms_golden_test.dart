import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_empty_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('Calc history atoms match wide spec references', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1432, 1020));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: Material(
          child: RepaintBoundary(
            key: const ValueKey<String>('history-atoms-reference-boundary'),
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox(
                width: 1432,
                height: 1020,
                child: Transform.scale(
                  scale: 4,
                  alignment: Alignment.topLeft,
                  child: const UnconstrainedBox(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 358,
                      height: 255,
                      child: _HistoryAtomsWideReference(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byKey(const ValueKey<String>('history-atoms-reference-boundary')),
      matchesGoldenFile('goldens/macos/calc_history_atoms_light.png'),
    );
  }, tags: const ['golden']);

  runGoldenMatrix(
    fileNamePrefix: 'calc_swipe_to_delete',
    description: 'Calc swipe to delete',
    sizes: const ['history_row'],
    customSizes: const {'history_row': Size(320, 80)},
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      darkTheme: theme,
      home: const Material(
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 320,
            child: CalcHistoryRow(
              dateText: '2026/05/10',
              resultText: 'BMI 22.5 (普通体重)',
              summaryText: 'H170/W65',
              deleteLabel: '削除',
              deleteRevealed: true,
              showBottomBorder: false,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _HistoryAtomsWideReference extends StatelessWidget {
  const _HistoryAtomsWideReference();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HistoryListFrame(
          child: CalcHistoryRow(
            dateText: '2026/05/10',
            resultText: 'BMI 22.5 (普通体重)',
            summaryText: 'H170/W65',
            showBottomBorder: false,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),
        _HistoryListFrame(
          height: 38,
          child: CalcHistoryRow(
            dateText: '2026/05/10',
            resultText: 'BMI 22.5 (普通体重)',
            summaryText: 'H170/W65',
            deleteLabel: '削除',
            deleteRevealed: true,
            showBottomBorder: false,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 16),
        CalcHistoryEmptyState(message: '履歴はありません'),
      ],
    );
  }
}

class _HistoryListFrame extends StatelessWidget {
  const _HistoryListFrame({required this.child, this.height});

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;

    final framed = DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcSurface,
        border: Border.all(color: palette.calcHairline),
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radii.card),
        child: child,
      ),
    );

    if (height == null) {
      return framed;
    }
    return SizedBox(height: height, child: framed);
  }
}
