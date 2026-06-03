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
        final isPhoneLandscape =
            !isTablet && constraints.maxWidth > constraints.maxHeight;

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
                  : isPhoneLandscape
                  ? _PhoneLandscapeIntroBody(
                      icon: icon,
                      title: title,
                      body: body,
                      features: features,
                      showDisclaimer: showDisclaimer,
                    )
                  : _PhoneIntroBody(
                      icon: icon,
                      title: title,
                      body: body,
                      features: features,
                      showDisclaimer: showDisclaimer,
                    ),
            ),
          ),
        );
      },
    );
  }
}

final class _PhoneLandscapeIntroBody extends StatelessWidget {
  const _PhoneLandscapeIntroBody({
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidth =
            (constraints.maxWidth -
                    _phoneIntroIconSize -
                    spacing.s6 -
                    spacing.s4)
                .clamp(_phonePortraitBodyMaxWidth, _wideIntroTextMaxWidth);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing.s2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: features.isNotEmpty
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              _IntroIcon(icon: icon, tablet: false),
              SizedBox(width: spacing.s6),
              _IntroTextColumn(
                title: title,
                body: body,
                features: features,
                showDisclaimer: showDisclaimer,
                textAlign: TextAlign.left,
                tablet: false,
                widePhone: true,
                textWidth: textWidth,
              ),
            ],
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
  });

  final IconData icon;
  final String title;
  final String body;
  final List<OnboardingFeature> features;
  final bool showDisclaimer;

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
    this.widePhone = false,
  });

  final String title;
  final String body;
  final List<OnboardingFeature> features;
  final bool showDisclaimer;
  final TextAlign textAlign;
  final bool tablet;
  final double textWidth;
  final bool widePhone;

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
        crossAxisAlignment: tablet || widePhone
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
              maxWidth: tablet || widePhone
                  ? textWidth
                  : _phonePortraitBodyMaxWidth,
            ),
            child: Text(
              body,
              textAlign: textAlign,
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
              features: features,
              tablet: tablet,
              widePhone: widePhone,
              textWidth: textWidth,
            ),
          ],
        ],
      ),
    );
  }
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
    required this.widePhone,
    required this.textWidth,
  });

  final List<OnboardingFeature> features;
  final bool tablet;
  final bool widePhone;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).extension<AppSpacing>()!;

    return SizedBox(
      width: tablet || widePhone ? textWidth : _phonePortraitTextWidth,
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
