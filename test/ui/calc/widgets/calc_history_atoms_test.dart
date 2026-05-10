import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_empty_state.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calc history atoms', () {
    testWidgets('CalcHistoryRow renders date, result, summary, and restore', (
      tester,
    ) async {
      var restored = false;
      await tester.pumpWidget(
        _widgetTestApp(
          child: CalcHistoryRow(
            dateText: '2026/05/10',
            resultText: 'BMI 22.5 (普通体重)',
            summaryText: 'H170/W65',
            onRestore: () => restored = true,
          ),
        ),
      );

      final richText = tester.widget<RichText>(
        find
            .descendant(
              of: find.byType(CalcHistoryRow),
              matching: find.byType(RichText),
            )
            .first,
      );
      expect(richText.text.toPlainText(), contains('2026/05/10'));
      expect(richText.text.toPlainText(), contains('BMI 22.5 (普通体重)'));
      expect(richText.text.toPlainText(), contains('H170/W65'));
      expect(find.byIcon(Icons.refresh), findsOneWidget);

      await tester.tap(find.byType(CalcHistoryRow));
      expect(restored, isTrue);
    });

    testWidgets('CalcHistoryRow delete-revealed state matches dimensions', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(
            width: 240,
            child: CalcHistoryRow(
              dateText: '2026/05/10',
              resultText: 'BMI 22.5 (普通体重)',
              summaryText: 'H170/W65',
              deleteLabel: '削除',
              deleteRevealed: true,
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(CalcHistoryRow)),
        const Size(240, 38),
      );
      expect(
        tester
            .getSize(
              find.byKey(const ValueKey<String>('history-delete')),
            )
            .width,
        72,
      );
      final deleteBox = tester.widget<DecoratedBox>(
        find
            .descendant(
              of: find.byKey(const ValueKey<String>('history-delete')),
              matching: find.byType(DecoratedBox),
            )
            .first,
      );
      final palette = Theme.of(
        tester.element(find.byType(CalcHistoryRow)),
      ).extension<AppPalette>()!;
      final decoration = deleteBox.decoration as BoxDecoration;
      expect(decoration.color, palette.calcError);
    });

    testWidgets('CalcHistoryEmptyState renders icon and message', (
      tester,
    ) async {
      await tester.pumpWidget(
        _widgetTestApp(
          child: const SizedBox(
            width: 240,
            child: CalcHistoryEmptyState(message: '履歴はありません'),
          ),
        ),
      );

      expect(find.byIcon(Icons.history_toggle_off), findsOneWidget);
      expect(find.text('履歴はありません'), findsOneWidget);
      expect(
        tester.getSize(find.byType(CalcHistoryEmptyState)),
        const Size(240, 115),
      );
    });
  });
}

Widget _widgetTestApp({required Widget child}) {
  return MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(
      body: Align(alignment: Alignment.topLeft, child: child),
    ),
  );
}
