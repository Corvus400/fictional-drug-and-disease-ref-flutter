import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// App information screen.
class AboutView extends ConsumerWidget {
  /// Creates an about screen.
  const AboutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final spacing = theme.extension<AppSpacing>()!;
    final typography = theme.extension<AppTypography>()!;
    final version = ref.watch(packageInfoProvider).value?.version ?? '--';

    return Scaffold(
      backgroundColor: palette.bg,
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(spacing.s4),
          children: [
            ListTile(
              enabled: false,
              title: Text(
                l10n.aboutAppVersionLabel(version),
                style: typography.bodyM.copyWith(color: palette.ink),
              ),
            ),
            ListTile(
              title: Text(
                l10n.aboutLicensesTitle,
                style: typography.bodyM.copyWith(color: palette.ink),
              ),
              subtitle: Text(
                l10n.aboutLicensesSubtitle,
                style: typography.bodyS.copyWith(color: palette.muted),
              ),
              trailing: Icon(Icons.chevron_right, color: palette.muted),
              onTap: () => context.push(AppRoutes.aboutLicenses),
            ),
          ],
        ),
      ),
    );
  }
}
