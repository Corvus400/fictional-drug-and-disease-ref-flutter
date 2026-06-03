import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// Starts the spotlight onboarding tour when the controller enters spotlight.
final class OnboardingSpotlight extends ConsumerStatefulWidget {
  /// Creates a spotlight trigger wrapper.
  const OnboardingSpotlight({required this.child, super.key});

  /// Application content containing spotlight targets.
  final Widget child;

  @override
  ConsumerState<OnboardingSpotlight> createState() =>
      _OnboardingSpotlightState();
}

final class _OnboardingSpotlightState
    extends ConsumerState<OnboardingSpotlight> {
  TutorialCoachMark? _tutorial;
  bool _startQueued = false;
  bool _disposing = false;

  @override
  void dispose() {
    _disposing = true;
    _tutorial?.skip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboarding = ref.watch(onboardingControllerProvider).value;
    if (onboarding?.phase == OnboardingPhase.spotlight && !_startQueued) {
      _startQueued = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _showIfReady());
    }
    if (onboarding?.phase != OnboardingPhase.spotlight) {
      _startQueued = false;
    }
    return widget.child;
  }

  void _showIfReady() {
    if (!mounted) {
      return;
    }
    final onboarding = ref.read(onboardingControllerProvider).value;
    if (onboarding?.phase != OnboardingPhase.spotlight) {
      _startQueued = false;
      return;
    }
    if (!_targetsAreMounted()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showIfReady());
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final typography = theme.extension<AppTypography>()!;
    _tutorial = TutorialCoachMark(
      targets: _targets(context, l10n),
      pulseEnable: false,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      textSkip: l10n.onboardingSkip,
      textStyleSkip: typography.labelM.copyWith(color: Colors.white),
      onSkip: () {
        if (_disposing || !mounted) {
          return true;
        }
        unawaited(ref.read(onboardingControllerProvider.notifier).skip());
        return true;
      },
      onFinish: () {
        if (_disposing || !mounted) {
          return;
        }
        unawaited(ref.read(onboardingControllerProvider.notifier).complete());
      },
    )..showWithOverlayState(overlay: Navigator.of(context).overlay!);
  }

  bool _targetsAreMounted() {
    return OnboardingTargetKeys.searchField.currentContext != null &&
        OnboardingTargetKeys.navigationTabs.currentContext != null &&
        OnboardingTargetKeys.aboutButton.currentContext != null;
  }

  List<TargetFocus> _targets(BuildContext context, AppLocalizations l10n) {
    return [
      _target(
        identify: 'search-field',
        key: OnboardingTargetKeys.searchField,
        title: l10n.onboardingSpotlightSearchTitle,
        body: l10n.onboardingSpotlightSearchBody,
        align: ContentAlign.bottom,
        actionLabel: l10n.onboardingNext,
        onAction: () => _tutorial?.next(),
      ),
      _target(
        identify: 'navigation-tabs',
        key: OnboardingTargetKeys.navigationTabs,
        title: l10n.onboardingSpotlightNavTitle,
        body: l10n.onboardingSpotlightNavBody,
        align: ContentAlign.top,
        actionLabel: l10n.onboardingNext,
        onAction: () => _tutorial?.next(),
      ),
      _target(
        identify: 'about-button',
        key: OnboardingTargetKeys.aboutButton,
        title: l10n.onboardingSpotlightAboutTitle,
        body: l10n.onboardingSpotlightAboutBody,
        align: ContentAlign.bottom,
        actionLabel: l10n.onboardingDone,
        onAction: () => _tutorial?.finish(),
      ),
    ];
  }

  TargetFocus _target({
    required String identify,
    required GlobalKey key,
    required String title,
    required String body,
    required ContentAlign align,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return TargetFocus(
      identify: identify,
      keyTarget: key,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: align,
          child: _SpotlightCard(
            title: title,
            body: body,
            actionLabel: actionLabel,
            onAction: onAction,
          ),
        ),
      ],
    );
  }
}

final class _SpotlightCard extends StatelessWidget {
  const _SpotlightCard({
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String body;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final spacing = theme.extension<AppSpacing>()!;
    final radii = theme.extension<AppRadii>()!;
    final typography = theme.extension<AppTypography>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(radii.card),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: typography.titleM
                  .copyWith(color: palette.ink)
                  .withVariableWeight(FontWeight.w700),
            ),
            SizedBox(height: spacing.s2),
            Text(
              body,
              style: typography.bodyS.copyWith(color: palette.muted),
            ),
            SizedBox(height: spacing.s3),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: onAction,
                child: Text(actionLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
