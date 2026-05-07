import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Detail Spec `.serious-card` for serious adverse events.
class DetailSeriousCard extends StatelessWidget {
  /// Creates a serious adverse event card.
  const DetailSeriousCard({
    required this.name,
    required this.description,
    this.meta = const [],
    super.key,
  });

  /// Event name.
  final String name;

  /// Event description.
  final String description;

  /// Optional metadata chips rendered as text spans.
  final List<String> meta;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return Container(
      key: const ValueKey<String>('detail-serious-card'),
      margin: const EdgeInsets.only(
        bottom: DetailConstants.seriousCardBottomMargin,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DetailConstants.seriousCardPaddingHorizontal,
        vertical: DetailConstants.seriousCardPaddingVertical,
      ),
      decoration: BoxDecoration(
        color: palette.dangerCont,
        border: Border(
          left: BorderSide(
            color: palette.danger,
            width: DetailConstants.seriousCardLeftBorderWidth,
          ),
        ),
        borderRadius: BorderRadius.circular(DetailConstants.seriousCardRadius),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.danger),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: DetailConstants.seriousCardNameBottomMargin,
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: palette.danger,
                  fontSize: DetailConstants.seriousCardNameFontSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(description, style: TextStyle(color: palette.danger)),
            if (meta.isNotEmpty) ...[
              const SizedBox(height: DetailConstants.seriousCardMetaTopMargin),
              Wrap(
                key: const ValueKey<String>('detail-serious-card-meta'),
                spacing: DetailConstants.seriousCardMetaGap,
                runSpacing: DetailConstants.seriousCardMetaGap,
                children: [
                  for (final item in meta)
                    Text(
                      item,
                      style: TextStyle(
                        color: palette.danger.withValues(
                          alpha: DetailConstants.seriousCardMetaOpacity,
                        ),
                        fontSize: DetailConstants.seriousCardMetaFontSize,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
