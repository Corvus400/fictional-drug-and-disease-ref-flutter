import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

const _phoneIntroIconSize = 96.0;
const _tabletIntroIconSize = 120.0;
const _phoneIntroIconGlyphSize = 46.0;
const _tabletIntroIconGlyphSize = 58.0;
const _phonePortraitTextWidth = 360.0;
const _phonePortraitBodyMaxWidth = 320.0;
const _wideIntroTextMaxWidth = 420.0;

/// A single intro-carousel page for onboarding.
class OnboardingPage extends StatelessWidget {
  /// Creates an onboarding intro page.
  const OnboardingPage({
    required this.pageNumber,
    required this.icon,
    required this.title,
    required this.body,
    this.features = const [],
    this.showDisclaimer = false,
    super.key,
  });

  /// One-based page number.
  final int pageNumber;

  /// Primary icon.
  final IconData icon;

  /// Page title.
  final String title;

  /// Page body.
  final String body;

  /// Optional feature list rows.
  final List<OnboardingFeature> features;

  /// Whether to show the fictional-data disclaimer.
  final bool showDisclaimer;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;

    return LayoutBuilder(
      key: ValueKey<String>('onboarding-page-$pageNumber'),
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: isTablet
                  ? _TabletIntroBody(
                      icon: icon,
                      title: title,
                      body: body,
                      features: features,
                      showDisclaimer: showDisclaimer,
                    )
                  : isLandscape && features.isNotEmpty
                  ? _PhoneLandscapeFeatureIntroBody(
                      icon: icon,
                      title: title,
                      body: body,
                      features: features,
                    )
                  : _PhoneIntroBody(
                      icon: icon,
                      title: title,
                      body: body,
                      features: features,
                      showDisclaimer: showDisclaimer,
                      preferJapanesePhraseWrap:
                          pageNumber == 3 || features.isNotEmpty,
                    ),
            ),
          ),
        );
      },
    );
  }
}

final class _PhoneIntroBody extends StatelessWidget {
  const _PhoneIntroBody({
    required this.icon,
    required this.title,
    required this.body,
    required this.features,
    required this.showDisclaimer,
    required this.preferJapanesePhraseWrap,
  });

  final IconData icon;
  final String title;
  final String body;
  final List<OnboardingFeature> features;
  final bool showDisclaimer;
  final bool preferJapanesePhraseWrap;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.s2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IntroIcon(icon: icon, tablet: false),
          SizedBox(height: spacing.s4),
          _IntroTextColumn(
            title: title,
            body: body,
            features: features,
            showDisclaimer: showDisclaimer,
            textAlign: TextAlign.center,
            tablet: false,
            textWidth: _phonePortraitTextWidth,
            preferJapanesePhraseWrap: preferJapanesePhraseWrap,
          ),
        ],
      ),
    );
  }
}

final class _TabletIntroBody extends StatelessWidget {
  const _TabletIntroBody({
    required this.icon,
    required this.title,
    required this.body,
    required this.features,
    required this.showDisclaimer,
  });

  final IconData icon;
  final String title;
  final String body;
  final List<OnboardingFeature> features;
  final bool showDisclaimer;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IntroIcon(icon: icon, tablet: true),
        SizedBox(width: spacing.s10),
        _IntroTextColumn(
          title: title,
          body: body,
          features: features,
          showDisclaimer: showDisclaimer,
          textAlign: TextAlign.left,
          tablet: true,
          textWidth: _wideIntroTextMaxWidth,
          preferJapanesePhraseWrap: false,
        ),
      ],
    );
  }
}

final class _PhoneLandscapeFeatureIntroBody extends StatelessWidget {
  const _PhoneLandscapeFeatureIntroBody({
    required this.icon,
    required this.title,
    required this.body,
    required this.features,
  });

  final IconData icon;
  final String title;
  final String body;
  final List<OnboardingFeature> features;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final featureListWidth =
        _phoneIntroIconSize + spacing.s10 + _phonePortraitTextWidth;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _IntroIcon(icon: icon, tablet: false),
            SizedBox(width: spacing.s10),
            _IntroTextColumn(
              title: title,
              body: body,
              features: const [],
              showDisclaimer: false,
              textAlign: TextAlign.left,
              tablet: false,
              textWidth: _phonePortraitTextWidth,
              preferJapanesePhraseWrap: true,
            ),
          ],
        ),
        SizedBox(height: spacing.s4),
        _FeatureList(
          key: const ValueKey<String>('onboarding-feature-list'),
          features: features,
          tablet: false,
          textWidth: featureListWidth,
        ),
      ],
    );
  }
}

final class _IntroIcon extends StatelessWidget {
  const _IntroIcon({required this.icon, required this.tablet});

  final IconData icon;
  final bool tablet;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.primarySoft,
        borderRadius: BorderRadius.circular(radii.fab),
      ),
      child: SizedBox.square(
        dimension: tablet ? _tabletIntroIconSize : _phoneIntroIconSize,
        child: Icon(
          icon,
          size: tablet ? _tabletIntroIconGlyphSize : _phoneIntroIconGlyphSize,
          color: palette.primary,
        ),
      ),
    );
  }
}

final class _IntroTextColumn extends StatelessWidget {
  const _IntroTextColumn({
    required this.title,
    required this.body,
    required this.features,
    required this.showDisclaimer,
    required this.textAlign,
    required this.tablet,
    required this.textWidth,
    required this.preferJapanesePhraseWrap,
  });

  final String title;
  final String body;
  final List<OnboardingFeature> features;
  final bool showDisclaimer;
  final TextAlign textAlign;
  final bool tablet;
  final double textWidth;
  final bool preferJapanesePhraseWrap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: textWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: textAlign == TextAlign.left
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: textAlign,
            style: (tablet ? typography.displayM : typography.titleL).copyWith(
              color: palette.ink,
              fontSize: tablet ? 28 : 22,
              height: 1.3,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: spacing.s4),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: tablet || textAlign == TextAlign.left
                  ? textWidth
                  : _phonePortraitBodyMaxWidth,
            ),
            child: _IntroBodyText(
              text: body,
              textAlign: textAlign,
              maxWidth: tablet || textAlign == TextAlign.left
                  ? textWidth
                  : _phonePortraitBodyMaxWidth,
              preferJapanesePhraseWrap: !tablet && preferJapanesePhraseWrap,
              style: typography.bodyM.copyWith(
                color: palette.ink2,
                fontSize: tablet ? 16 : 14,
                height: 1.7,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          if (showDisclaimer) ...[
            SizedBox(height: spacing.s4),
            _Disclaimer(text: l10n.disclaimerRibbonText),
          ] else if (features.isNotEmpty) ...[
            SizedBox(height: spacing.s4),
            _FeatureList(
              key: const ValueKey<String>('onboarding-feature-list'),
              features: features,
              tablet: tablet,
              textWidth: textWidth,
            ),
          ],
        ],
      ),
    );
  }
}

final class _IntroBodyText extends StatelessWidget {
  const _IntroBodyText({
    required this.text,
    required this.textAlign,
    required this.maxWidth,
    required this.preferJapanesePhraseWrap,
    required this.style,
  });

  final String text;
  final TextAlign textAlign;
  final double maxWidth;
  final bool preferJapanesePhraseWrap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (!preferJapanesePhraseWrap) {
      return Text(
        text,
        textAlign: textAlign,
        style: style,
      );
    }

    final lines = _japanesePhraseLines(
      text: text,
      style: style,
      maxWidth: maxWidth,
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
    );

    return Column(
      key: const ValueKey<String>('onboarding-intro-body-phrase-lines'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: textAlign == TextAlign.left
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: lines
          .map((line) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: line
                  .map((segment) {
                    return Text(segment, style: style);
                  })
                  .toList(growable: false),
            );
          })
          .toList(growable: false),
    );
  }
}

List<List<String>> _japanesePhraseLines({
  required String text,
  required TextStyle style,
  required double maxWidth,
  required TextDirection textDirection,
  required TextScaler textScaler,
}) {
  final segments = _japanesePhraseSegments(text);
  if (segments.isEmpty) {
    return const [];
  }

  final widths = segments
      .map((segment) {
        final painter = TextPainter(
          text: TextSpan(text: segment, style: style),
          textDirection: textDirection,
          textScaler: textScaler,
        )..layout();
        return painter.width;
      })
      .toList(growable: false);

  if (segments.length > 1) {
    final leadingWidth = widths
        .take(segments.length - 1)
        .fold<double>(
          0,
          (sum, width) => sum + width,
        );
    final trailingWidth = widths.last;
    if (leadingWidth <= maxWidth && trailingWidth <= maxWidth) {
      return [
        segments.sublist(0, segments.length - 1),
        [segments.last],
      ];
    }
  }

  final best = List<double>.filled(segments.length + 1, double.infinity);
  final next = List<int>.filled(segments.length, segments.length);
  best[segments.length] = 0;

  for (var index = segments.length - 1; index >= 0; index -= 1) {
    var lineWidth = 0.0;
    for (var end = index; end < segments.length; end += 1) {
      lineWidth += widths[end];
      if (lineWidth > maxWidth && end > index) {
        break;
      }

      final overflow = lineWidth > maxWidth ? lineWidth - maxWidth : 0.0;
      final leftover = lineWidth > maxWidth ? 0.0 : maxWidth - lineWidth;
      final penalty = overflow * overflow * 100 + leftover * leftover;
      final score = penalty + best[end + 1];
      if (score < best[index]) {
        best[index] = score;
        next[index] = end + 1;
      }
    }
  }

  final lines = <List<String>>[];
  var index = 0;
  while (index < segments.length) {
    final end = next[index];
    lines.add(segments.sublist(index, end));
    index = end;
  }
  return lines;
}

List<String> _japanesePhraseSegments(String text) {
  final segments = <String>[];
  final buffer = StringBuffer();

  void flush() {
    if (buffer.isEmpty) {
      return;
    }
    final value = buffer.toString();
    final aggregateBreak = value.indexOf('を1つ');
    if (aggregateBreak == -1) {
      if (value == '実画面上で主要な操作位置を順に案内します。') {
        segments
          ..add('実画面上で')
          ..add('主要な操作位置を')
          ..add('順に')
          ..add('案内します。');
      } else {
        segments.add(value);
      }
    } else {
      segments
        ..add(value.substring(0, aggregateBreak + 1))
        ..add(value.substring(aggregateBreak + 1));
    }
    buffer.clear();
  }

  for (final rune in text.runes) {
    final char = String.fromCharCode(rune);
    buffer.write(char);
    if (char == '・' || char == '、') {
      flush();
    }
  }
  flush();

  return segments;
}

final class _Disclaimer extends StatelessWidget {
  const _Disclaimer({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    final displayText = text.replaceFirst(' / ', '\n');

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.calcRibbonBg,
        borderRadius: BorderRadius.circular(radii.tile),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.s3, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '·',
              style: typography.titleM.copyWith(
                color: palette.calcRibbonAccent,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(width: spacing.s2),
            Flexible(
              child: Text(
                displayText,
                textAlign: TextAlign.center,
                semanticsLabel: text,
                style: typography.labelS.copyWith(
                  color: palette.calcRibbonFg,
                  letterSpacing: 0.3,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _FeatureList extends StatelessWidget {
  const _FeatureList({
    required this.features,
    required this.tablet,
    required this.textWidth,
    super.key,
  });

  final List<OnboardingFeature> features;
  final bool tablet;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return SizedBox(
      width: textWidth,
      child: Column(
        children: features.map((feature) {
          return Padding(
            padding: EdgeInsets.only(bottom: spacing.s2),
            child: _FeatureCard(feature: feature),
          );
        }).toList(),
      ),
    );
  }
}

final class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final OnboardingFeature feature;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final title = feature.title;
    final support = feature.supportingText;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surface,
        border: Border.all(color: palette.hairline, width: 0.5),
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.s3, vertical: 10),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: palette.primarySoft,
                borderRadius: BorderRadius.circular(radii.tile),
              ),
              child: SizedBox.square(
                dimension: 36,
                child: Icon(feature.icon, color: palette.primary, size: 20),
              ),
            ),
            SizedBox(width: spacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: typography.bodyS
                        .copyWith(
                          color: palette.ink,
                          decoration: TextDecoration.none,
                        )
                        .withVariableWeight(FontWeight.w700),
                  ),
                  if (support.isNotEmpty)
                    Text(
                      support,
                      style: typography.labelS
                          .copyWith(
                            color: palette.muted,
                            fontSize: 11.5,
                            height: 1.4,
                            decoration: TextDecoration.none,
                          )
                          .withVariableWeight(FontWeight.w400),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A feature row shown on the second onboarding page.
final class OnboardingFeature {
  /// Creates an onboarding feature row.
  const OnboardingFeature({required this.icon, required this.label});

  /// Feature icon.
  final IconData icon;

  /// Localized feature label.
  final String label;

  /// Feature title before the localized delimiter.
  String get title => _parts.$1;

  /// Feature supporting text after the localized delimiter.
  String get supportingText => _parts.$2;

  (String, String) get _parts {
    final split = label.split(' — ');
    if (split.length < 2) {
      return (label, '');
    }
    return (split.first, split.skip(1).join(' — '));
  }
}
