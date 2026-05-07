import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('DetailCarousel matches horizontal scroll padding and gap', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailCarousel(
            children: [
              DetailCarouselCard(title: '薬剤A', subtitle: 'drug_0001'),
              DetailCarouselCard(title: '薬剤B', subtitle: 'drug_0002'),
            ],
          ),
        ),
      ),
    );

    final scroll = tester.widget<SingleChildScrollView>(
      find.byKey(const ValueKey<String>('detail-carousel-scroll')),
    );
    final padding = tester.widget<Padding>(
      find.byKey(const ValueKey<String>('detail-carousel-padding')),
    );
    final gap = tester.widget<SizedBox>(
      find.byKey(const ValueKey<String>('detail-carousel-gap-0')),
    );

    expect(scroll.scrollDirection, Axis.horizontal);
    expect(padding.padding, const EdgeInsets.fromLTRB(16, 4, 16, 8));
    expect(gap.width, 10);
  });

  testWidgets('DetailCarouselCard matches card image and text tokens', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: const Scaffold(
          body: DetailCarouselCard(
            title: '長い関連薬剤名',
            subtitle: 'drug_0001',
            badges: ['同効薬'],
          ),
        ),
      ),
    );

    final colors = AppTheme.light().extension<DetailColorExtension>()!;
    const palette = AppPalette.light;
    final card = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-carousel-card')),
    );
    final cardDecoration = card.decoration! as BoxDecoration;
    final image = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-carousel-card-image')),
    );
    final imageDecoration = image.decoration! as BoxDecoration;
    final title = tester.widget<Text>(find.text('長い関連薬剤名'));
    final subtitle = tester.widget<Text>(find.text('drug_0001'));
    final badge = tester.widget<Container>(
      find.byKey(const ValueKey<String>('detail-carousel-card-badge')),
    );
    final badgeDecoration = badge.decoration! as BoxDecoration;

    expect(card.constraints?.minWidth, 184);
    expect(card.constraints?.maxWidth, 184);
    expect(card.padding, const EdgeInsets.all(12));
    expect(cardDecoration.color, colors.surfaceContainerLow);
    expect(cardDecoration.border, Border.all(color: colors.outlineVariant));
    expect(cardDecoration.borderRadius, BorderRadius.circular(12));
    expect(image.constraints?.minHeight, 64);
    expect(imageDecoration.borderRadius, BorderRadius.circular(8));
    expect(imageDecoration.gradient, isA<LinearGradient>());
    expect(title.style?.fontSize, 12.5);
    expect(title.style?.fontWeight, FontWeight.w700);
    expect(title.style?.height, 1.35);
    expect(title.style?.color, colors.onSurface);
    expect(subtitle.style?.fontSize, 11);
    expect(subtitle.style?.color, colors.onSurfaceVariant);
    expect(
      badge.padding,
      const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    );
    expect(badgeDecoration.color, palette.surface3);
    expect(badgeDecoration.borderRadius, BorderRadius.circular(6));
  });

  runGoldenMatrix(
    fileNamePrefix: 'detail_carousel',
    description: 'DetailCarousel follows Detail Spec carousel CSS',
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
                child: const DetailCarousel(
                  children: [
                    DetailCarouselCard(
                      title: '関連薬剤A',
                      subtitle: 'drug_0001',
                      badges: ['同効薬', '注意'],
                    ),
                    DetailCarouselCard(
                      title: '関連疾患B',
                      subtitle: 'disease_0002',
                      badges: ['関連'],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
