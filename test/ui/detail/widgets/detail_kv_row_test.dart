import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailKvRow matches kv grid columns borders and text styles', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailKvRow(
            label: '投与経路',
            value: '経口',
            showTopBorder: true,
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final row = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-kv-row')),
    );
    final labelBox = tester.widget<SizedBox>(
      find.byKey(const ValueKey<String>('detail-kv-label-box')),
    );
    final labelCell = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-kv-label-cell')),
    );
    final valueCell = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-kv-value-cell')),
    );
    final decoration = row.decoration! as BoxDecoration;
    final label = tester.widget<Text>(find.text('投与経路'));
    final value = tester.widget<Text>(find.text('経口'));

    expect(labelBox.width, 96);
    expect(labelCell.padding, const EdgeInsets.symmetric(vertical: 8));
    expect(valueCell.padding, const EdgeInsets.symmetric(vertical: 8));
    expect(
      decoration.border,
      Border(
        top: BorderSide(color: colors.outlineVariant),
        bottom: BorderSide(color: colors.outlineVariant),
      ),
    );
    expect(label.style?.fontSize, 12.5);
    expect(label.style?.color, colors.onSurfaceVariant);
    expect(value.style?.fontSize, 12.5);
    expect(value.style?.color, colors.onSurface);
  });

  testWidgets('DetailKvRow omits the top border for following rows', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailKvRow(label: '剤形', value: '錠剤'),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final row = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-kv-row')),
    );
    final decoration = row.decoration! as BoxDecoration;

    expect(
      decoration.border,
      Border(bottom: BorderSide(color: colors.outlineVariant)),
    );
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_kv_row',
    description: 'DetailKvRow follows Detail Spec kv CSS',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailKvRow(
                        label: '剤形',
                        value: '錠剤',
                        showTopBorder: true,
                      ),
                      DetailKvRow(label: '投与経路', value: '経口'),
                      DetailKvRow(label: '規制区分', value: '処方箋医薬品'),
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
