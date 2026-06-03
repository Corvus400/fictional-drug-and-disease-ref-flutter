import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final spacing = theme.extension<AppSpacing>()!;
    final radii = theme.extension<AppRadii>()!;
    final typography = theme.extension<AppTypography>()!;
    final isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;

    return SingleChildScrollView(
      key: ValueKey<String>('onboarding-page-$pageNumber'),
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? spacing.s8 : spacing.s5,
        vertical: isTablet ? spacing.s10 : spacing.s7,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: palette.primarySoft,
                borderRadius: BorderRadius.circular(radii.pill),
              ),
              child: Padding(
                padding: EdgeInsets.all(spacing.s4),
                child: Icon(
                  icon,
                  size: isTablet ? 48 : 40,
                  color: palette.primary,
                ),
              ),
            ),
            SizedBox(height: spacing.s6),
            Text(
              title,
              style: (isTablet ? typography.displayM : typography.titleL)
                  .copyWith(color: palette.ink),
            ),
            SizedBox(height: spacing.s3),
            Text(body, style: typography.bodyM.copyWith(color: palette.ink2)),
            if (features.isNotEmpty) ...[
              SizedBox(height: spacing.s5),
              ...features.map((feature) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spacing.s3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(feature.icon, color: palette.primary, size: 20),
                      SizedBox(width: spacing.s3),
                      Expanded(
                        child: Text(
                          feature.label,
                          style: typography.bodyS.copyWith(color: palette.ink),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            if (showDisclaimer) ...[
              SizedBox(height: spacing.s6),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.ink,
                  borderRadius: BorderRadius.circular(radii.tile),
                ),
                child: Padding(
                  padding: EdgeInsets.all(spacing.s3),
                  child: Text(
                    l10n.disclaimerRibbonText,
                    style: typography.labelM.copyWith(color: palette.onPrimary),
                  ),
                ),
              ),
            ],
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
}
