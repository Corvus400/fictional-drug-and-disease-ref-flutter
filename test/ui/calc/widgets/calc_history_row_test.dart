import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/widgets/calc_history_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcHistoryRow swipe-to-delete', () {
    testWidgets('uses 0.4 end-to-start threshold and reveals delete action', (
      tester,
    ) async {
      var deleted = false;
      await tester.pumpWidget(
        _widgetTestApp(
          child: SizedBox(
            width: 240,
            child: CalcHistoryRow(
              dateText: '2026/05/10',
              resultText: 'BMI 22.5 (普通体重)',
              summaryText: 'H170/W65',
              deleteLabel: '削除',
              onDelete: () => deleted = true,
            ),
          ),
        ),
      );

      final dismissible = tester.widget<Dismissible>(
        find.byType(Dismissible),
      );
      expect(
        dismissible.dismissThresholds[DismissDirection.endToStart],
        0.4,
      );

      await tester.drag(find.byType(CalcHistoryRow), const Offset(-140, 0));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey<String>('history-delete')), findsOne);
      expect(
        tester
            .getSize(find.byKey(const ValueKey<String>('history-delete')))
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

      await tester.tap(find.byKey(const ValueKey<String>('history-delete')));
      expect(deleted, isTrue);
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
