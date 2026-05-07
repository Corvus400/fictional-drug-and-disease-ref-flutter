import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.carousel` horizontal list.
class DetailCarousel extends StatelessWidget {
  /// Creates a detail carousel.
  const DetailCarousel({
    required this.children,
    super.key,
  });

  /// Carousel cards.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey<String>('detail-carousel-scroll'),
      scrollDirection: Axis.horizontal,
      child: Padding(
        key: const ValueKey<String>('detail-carousel-padding'),
        padding: const EdgeInsets.fromLTRB(
          DetailConstants.carouselPaddingLeft,
          DetailConstants.carouselPaddingTop,
          DetailConstants.carouselPaddingRight,
          DetailConstants.carouselPaddingBottom,
        ),
        child: Row(
          children: [
            for (var index = 0; index < children.length; index += 1) ...[
              if (index > 0)
                SizedBox(
                  key: ValueKey<String>('detail-carousel-gap-${index - 1}'),
                  width: DetailConstants.carouselGap,
                ),
              children[index],
            ],
          ],
        ),
      ),
    );
  }
}

/// Detail Spec `.ccard` carousel card.
class DetailCarouselCard extends StatelessWidget {
  /// Creates a carousel card.
  const DetailCarouselCard({
    required this.title,
    required this.subtitle,
    this.badges = const [],
    super.key,
  });

  /// Card title.
  final String title;

  /// Card subtitle.
  final String subtitle;

  /// Small badge labels.
  final List<String> badges;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('detail-carousel-card'),
      constraints: const BoxConstraints.tightFor(
        width: DetailConstants.carouselCardWidth,
      ),
      padding: const EdgeInsets.all(DetailConstants.carouselCardPadding),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(DetailConstants.carouselCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            softWrap: true,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: DetailConstants.carouselCardTitleFontSize,
              fontWeight: FontWeight.w700,
              height: DetailConstants.carouselCardTitleLineHeight,
            ),
          ),
          const SizedBox(height: DetailConstants.carouselCardGap),
          Text(
            subtitle,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: DetailConstants.carouselCardSubtitleFontSize,
            ),
          ),
          if (badges.isNotEmpty) ...[
            const SizedBox(height: DetailConstants.carouselBadgeTopMargin),
            Wrap(
              spacing: DetailConstants.carouselBadgeGap,
              runSpacing: DetailConstants.carouselBadgeGap,
              children: [
                for (final badge in badges) _CarouselBadge(label: badge),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _CarouselBadge extends StatelessWidget {
  const _CarouselBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey<String>('detail-carousel-card-badge'),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.carouselBadgePaddingHorizontal,
        vertical: DetailConstants.carouselBadgePaddingVertical,
      ),
      decoration: BoxDecoration(
        color: palette.surface3,
        borderRadius: BorderRadius.circular(
          DetailConstants.carouselBadgeRadius,
        ),
      ),
      child: Text(
        label,
        softWrap: true,
        style: TextStyle(
          color: palette.ink2,
          fontSize: DetailConstants.carouselBadgeFontSize,
          height: DetailConstants.carouselCardTitleLineHeight,
        ),
      ),
    );
  }
}
