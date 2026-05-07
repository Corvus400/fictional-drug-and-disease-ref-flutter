import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_serious_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailSeriousCard matches serious-card CSS', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailSeriousCard(
            name: '肝機能障害・黄疸',
            description: 'AST/ALT 上昇を伴う肝機能障害が現れることがある。',
            meta: ['初期症状 倦怠感', '対応 投与中止'],
          ),
        ),
      ),
    );

    const palette = AppPalette.light;
    final card = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-serious-card')),
    );
    final decoration = card.decoration! as BoxDecoration;
    final name = tester.widget<Text>(find.text('肝機能障害・黄疸'));
    final description = tester.widget<Text>(
      find.text('AST/ALT 上昇を伴う肝機能障害が現れることがある。'),
    );
    final meta = tester.widget<Wrap>(
      find.byKey(const ValueKey<String>('detail-serious-card-meta')),
    );
    final metaText = tester.widget<Text>(find.text('初期症状 倦怠感'));

    expect(
      card.padding,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
    expect(card.margin, const EdgeInsets.only(bottom: 8));
    expect(decoration.color, palette.dangerCont);
    expect(
      decoration.border,
      Border(left: BorderSide(color: palette.danger, width: 3)),
    );
    expect(decoration.borderRadius, BorderRadius.circular(8));
    expect(name.style?.fontSize, 13);
    expect(name.style?.fontWeight, FontWeight.w700);
    expect(name.style?.color, palette.danger);
    expect(description.style?.color, palette.danger);
    expect(meta.spacing, 8);
    expect(meta.runSpacing, 8);
    expect(metaText.style?.fontSize, 11);
    expect(metaText.style?.color?.a, lessThan(palette.danger.a));
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_serious_card',
    description: 'DetailSeriousCard follows Detail Spec serious-card CSS',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, textScaler) {
      return MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final palette = Theme.of(context).extension<AppPalette>()!;
              return ColoredBox(
                color: palette.bg,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailSeriousCard(
                        name: '肝機能障害・黄疸',
                        description: 'AST/ALT 上昇を伴う肝機能障害、黄疸。',
                        meta: ['初期症状 倦怠感', '対応 投与中止'],
                      ),
                      DetailSeriousCard(
                        name: '無顆粒球症・白血球減少',
                        description: '定期的に血液検査を実施する。',
                      ),
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
