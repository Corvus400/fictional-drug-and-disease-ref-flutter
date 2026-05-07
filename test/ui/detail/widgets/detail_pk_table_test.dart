import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_pk_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailPkTable matches exam table CSS for PK parameters', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailPkTable(
            itemHeader: 'item',
            valueHeader: 'value',
            rows: [
              DetailPkParameter(name: 'AUC0-inf', value: '234.5 ng.h/mL'),
              DetailPkParameter(name: 'Cmax', value: '5.5 ng/mL'),
            ],
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final table = tester.widget<Table>(
      find.byKey(const ValueKey<String>('detail-pk-table')),
    );
    final headerItem = tester.widget<Text>(find.text('ITEM'));
    final headerValue = tester.widget<Text>(find.text('VALUE'));
    final firstNameCell = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-pk-cell-name-0')),
    );
    final firstValueCell = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-pk-cell-value-0')),
    );
    final firstRow = table.children[1];

    expect(table.defaultVerticalAlignment, TableCellVerticalAlignment.top);
    expect(firstNameCell.padding, const EdgeInsets.all(6));
    expect(firstValueCell.padding, const EdgeInsets.all(6));
    expect(
      firstRow.decoration,
      BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
    );
    expect(headerItem.style?.fontSize, 10.5);
    expect(headerItem.style?.letterSpacing, 0.42);
    expect(headerItem.style?.fontWeight, FontWeight.w700);
    expect(headerItem.style?.color, colors.onSurfaceVariant);
    expect(headerValue.style?.fontSize, 10.5);
    expect(find.text('AUC0-inf'), findsOneWidget);
    expect(
      tester.widget<Text>(find.text('AUC0-inf')).style?.fontSize,
      11.5,
    );
    expect(
      tester.widget<Text>(find.text('Cmax')).style?.color,
      colors.onSurface,
    );
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_pk_table',
    description: 'DetailPkTable follows Detail Spec exam table CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final colors = Theme.of(
                context,
              ).extension<DetailColorExtension>()!;
              return ColoredBox(
                color: colors.surface,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: DetailPkTable(
                    itemHeader: '項目',
                    valueHeader: '値（健康成人 5 mg）',
                    rows: [
                      DetailPkParameter(
                        name: 'AUC0-inf',
                        value: '234.5 ng.h/mL',
                      ),
                      DetailPkParameter(name: 'Cmax', value: '5.5 ng/mL'),
                      DetailPkParameter(name: 't1/2', value: '35 h'),
                      DetailPkParameter(name: 'CL/F', value: '21.3 L/h'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
