import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailPanel matches panel spacing and divider tokens', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailPanel(
            sectionIndex: 'D1',
            title: '基本情報',
            subtitle: '剤形・投与経路',
            child: Text('content'),
          ),
        ),
      ),
    );

    final panel = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-panel')),
    );
    final decoration = panel.decoration! as BoxDecoration;
    final colors = AppTheme.light().extension<DetailColorExtension>()!;

    expect(panel.padding, const EdgeInsets.fromLTRB(16, 14, 16, 14));
    expect(
      decoration.border?.bottom,
      BorderSide(color: colors.outlineVariant),
    );
    expect(find.text('D1'), findsOneWidget);
    expect(find.text('基本情報'), findsOneWidget);
    expect(find.text('剤形・投与経路'), findsOneWidget);
    expect(find.text('content'), findsOneWidget);
  });

  testWidgets('DetailPanel suppresses divider for the final panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailPanel(
            sectionIndex: 'D2',
            title: '最終セクション',
            showBottomDivider: false,
            child: Text('content'),
          ),
        ),
      ),
    );

    final panel = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-panel')),
    );
    final decoration = panel.decoration! as BoxDecoration;

    expect(decoration.border, isNull);
  });

  testWidgets('DetailPanel section index and title use h-section styles', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailPanel(
            sectionIndex: 'D3',
            subIndex: 'RX',
            title: '警告',
            child: Text('content'),
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    final indexBox = tester.widget<DecoratedBox>(
      find.byKey(const ValueKey<String>('detail-panel-index-box')),
    );
    final indexDecoration = indexBox.decoration as BoxDecoration;
    final indexText = tester.widget<Text>(find.text('D3'));
    final subIndexText = tester.widget<Text>(find.text('RX'));
    final titleText = tester.widget<Text>(find.text('警告'));

    expect(indexDecoration.color, colors.surfaceContainerHigh);
    expect(indexDecoration.borderRadius, BorderRadius.circular(3));
    expect(indexText.style?.fontSize, 9);
    expect(indexText.style?.fontWeight, FontWeight.w700);
    expect(indexText.style?.color, colors.onSurfaceVariant);
    expect(subIndexText.style?.fontSize, 10);
    expect(subIndexText.style?.fontWeight, FontWeight.w600);
    expect(subIndexText.style?.color, colors.onSurfaceVariant);
    expect(titleText.style?.fontSize, 14);
    expect(titleText.style?.fontWeight, FontWeight.w700);
    expect(titleText.style?.color, colors.onSurface);
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_panel',
    description: 'DetailPanel follows Detail Spec panel CSS',
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
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 390,
                    child: DetailPanel(
                      sectionIndex: 'D1',
                      subIndex: 'RX',
                      title: '基本情報',
                      subtitle: '剤形・投与経路・規制区分',
                      child: Text('タブレット / 経口 / 処方箋医薬品'),
                    ),
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
