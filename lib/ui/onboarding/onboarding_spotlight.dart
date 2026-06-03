import 'dart:async';

import 'package:fictional_drug_and_disease_ref/application/providers/onboarding_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/onboarding/onboarding_state.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_target_keys.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

const _coachCardPhoneWidth = 268.0;
const _coachCardTabletWidth = 320.0;
const _coachCardTabletShortestSide = 600.0;
const _coachCardPaddingVertical = 14.0;
const _coachCardBorderWidth = 0.5;
const _coachCardShadowBlur = 32.0;
const _coachCardShadowOffsetY = 12.0;

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
  bool _reflowing = false;
  bool _reflowQueued = false;
  int _currentStep = 0;
  Orientation? _shownOrientation;

  @override
  void dispose() {
    _disposing = true;
    _tutorial?.skip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);
    final onboarding = ref.watch(onboardingControllerProvider).value;
    if (onboarding?.phase == OnboardingPhase.spotlight && !_startQueued) {
      _startQueued = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _showIfReady());
    }
    if (onboarding?.phase == OnboardingPhase.spotlight &&
        _tutorial?.isShowing == true &&
        _shownOrientation != null &&
        _shownOrientation != orientation &&
        !_reflowQueued) {
      _reflowQueued = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _reflowIfReady(orientation),
      );
    }
    if (onboarding?.phase != OnboardingPhase.spotlight) {
      _startQueued = false;
      _currentStep = 0;
      _shownOrientation = null;
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

    final overlayTarget = _targetOverlay();
    if (overlayTarget == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showIfReady());
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    _showTutorial(l10n: l10n, initialFocus: _currentStep);
  }

  void _showTutorial({
    required AppLocalizations l10n,
    required int initialFocus,
  }) {
    final overlayTarget = _targetOverlay();
    if (overlayTarget == null) {
      return;
    }
    _shownOrientation = MediaQuery.orientationOf(context);
    _tutorial =
        TutorialCoachMark(
          targets: _targets(context, l10n),
          initialFocus: initialFocus,
          pulseEnable: false,
          focusAnimationDuration: Duration.zero,
          unFocusAnimationDuration: Duration.zero,
          hideSkip: true,
          onClickTarget: (target) {
            final index = _targetIndex(target.identify);
            if (index != null) {
              _currentStep = (index + 1).clamp(0, 2);
            }
          },
          onSkip: () {
            if (_reflowing) {
              return true;
            }
            if (_disposing || !mounted) {
              return true;
            }
            unawaited(ref.read(onboardingControllerProvider.notifier).skip());
            return true;
          },
          onFinish: () {
            if (_reflowing) {
              return;
            }
            if (_disposing || !mounted) {
              return;
            }
            unawaited(
              ref.read(onboardingControllerProvider.notifier).complete(),
            );
          },
        )..showWithOverlayState(
          overlay: overlayTarget.overlay,
          rootOverlay: overlayTarget.rootOverlay,
        );
  }

  void _reflowIfReady(Orientation orientation) {
    if (!mounted) {
      _reflowQueued = false;
      return;
    }
    final onboarding = ref.read(onboardingControllerProvider).value;
    if (onboarding?.phase != OnboardingPhase.spotlight) {
      _reflowQueued = false;
      return;
    }
    if (!_targetsAreMounted() || _targetOverlay() == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _reflowIfReady(orientation),
      );
      return;
    }

    _reflowing = true;
    _tutorial?.skip();
    _reflowing = false;

    final l10n = AppLocalizations.of(context)!;
    _showTutorial(l10n: l10n, initialFocus: _currentStep);
    _shownOrientation = orientation;
    _reflowQueued = false;
  }

  int? _targetIndex(Object? identify) {
    return switch (identify) {
      'search-field' => 0,
      'navigation-tabs' => 1,
      'about-button' => 2,
      _ => null,
    };
  }

  bool _targetsAreMounted() {
    return OnboardingTargetKeys.searchField.currentContext != null &&
        OnboardingTargetKeys.navigationTabs.currentContext != null &&
        OnboardingTargetKeys.aboutButton.currentContext != null;
  }

  ({OverlayState overlay, bool rootOverlay})? _targetOverlay() {
    for (final targetContext in [
      OnboardingTargetKeys.searchField.currentContext,
      OnboardingTargetKeys.navigationTabs.currentContext,
      OnboardingTargetKeys.aboutButton.currentContext,
      context,
    ]) {
      if (targetContext == null) {
        continue;
      }
      final rootOverlay = Overlay.maybeOf(targetContext, rootOverlay: true);
      if (rootOverlay != null) {
        return (overlay: rootOverlay, rootOverlay: true);
      }
      final navigatorOverlay = Navigator.maybeOf(targetContext)?.overlay;
      if (navigatorOverlay != null) {
        return (overlay: navigatorOverlay, rootOverlay: false);
      }
    }
    return null;
  }

  List<TargetFocus> _targets(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final spacing = theme.extension<AppSpacing>()!;
    final size = MediaQuery.sizeOf(context);
    final navUsesRail = size.width > size.height;
    final railWidth = size.height >= 600
        ? appShellRegularRailWidth
        : appShellCompactRailWidth;
    return [
      _target(
        identify: 'search-field',
        key: OnboardingTargetKeys.searchField,
        theme: theme,
        title: l10n.onboardingSpotlightSearchTitle,
        body: l10n.onboardingSpotlightSearchBody,
        align: ContentAlign.bottom,
        stepLabel: '1 / 3',
        leadLabel: l10n.onboardingCoachLead,
        skipLabel: l10n.onboardingSkip,
        actionLabel: l10n.onboardingNext,
        actionKey: const ValueKey<String>(
          'onboarding-spotlight-action-search-field',
        ),
        onSkip: () => _tutorial?.skip(),
        onAction: () {
          _currentStep = 1;
          _tutorial?.next();
        },
      ),
      _target(
        identify: 'navigation-tabs',
        key: OnboardingTargetKeys.navigationTabs,
        theme: theme,
        title: l10n.onboardingSpotlightNavTitle,
        body: l10n.onboardingSpotlightNavBody,
        align: navUsesRail ? ContentAlign.custom : ContentAlign.top,
        customPosition: navUsesRail
            ? CustomTargetContentPosition(
                top: spacing.s4,
                left: railWidth + spacing.s4,
                right: spacing.s4,
              )
            : null,
        stepLabel: '2 / 3',
        leadLabel: l10n.onboardingCoachLead,
        skipLabel: l10n.onboardingSkip,
        actionLabel: l10n.onboardingNext,
        actionKey: const ValueKey<String>(
          'onboarding-spotlight-action-navigation-tabs',
        ),
        onSkip: () => _tutorial?.skip(),
        onAction: () {
          _currentStep = 2;
          _tutorial?.next();
        },
      ),
      _target(
        identify: 'about-button',
        key: OnboardingTargetKeys.aboutButton,
        theme: theme,
        title: l10n.onboardingSpotlightAboutTitle,
        body: l10n.onboardingSpotlightAboutBody,
        align: ContentAlign.bottom,
        stepLabel: '3 / 3',
        leadLabel: l10n.onboardingCoachLead,
        skipLabel: l10n.onboardingSkip,
        actionLabel: l10n.onboardingDone,
        actionKey: const ValueKey<String>(
          'onboarding-spotlight-action-about-button',
        ),
        onSkip: () => _tutorial?.skip(),
        onAction: () {
          _currentStep = 2;
          _tutorial?.finish();
        },
      ),
    ];
  }

  TargetFocus _target({
    required String identify,
    required GlobalKey key,
    required ThemeData theme,
    required String title,
    required String body,
    required ContentAlign align,
    required String stepLabel,
    required String leadLabel,
    required String skipLabel,
    required String actionLabel,
    required Key actionKey,
    required VoidCallback onSkip,
    required VoidCallback onAction,
    CustomTargetContentPosition? customPosition,
  }) {
    return TargetFocus(
      identify: identify,
      keyTarget: key,
      shape: ShapeLightFocus.RRect,
      contents: [
        TargetContent(
          align: align,
          customPosition: customPosition,
          child: Theme(
            data: theme,
            child: _SpotlightCard(
              stepLabel: stepLabel,
              title: title,
              leadLabel: leadLabel,
              body: body,
              skipLabel: skipLabel,
              actionLabel: actionLabel,
              actionKey: actionKey,
              onSkip: onSkip,
              onAction: onAction,
            ),
          ),
        ),
      ],
    );
  }
}

final class _SpotlightCard extends StatelessWidget {
  const _SpotlightCard({
    required this.stepLabel,
    required this.title,
    required this.leadLabel,
    required this.body,
    required this.skipLabel,
    required this.actionLabel,
    required this.actionKey,
    required this.onSkip,
    required this.onAction,
  });

  final String stepLabel;
  final String title;
  final String leadLabel;
  final String body;
  final String skipLabel;
  final String actionLabel;
  final Key actionKey;
  final VoidCallback onSkip;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final spacing = theme.extension<AppSpacing>()!;
    final radii = theme.extension<AppRadii>()!;
    final typography = theme.extension<AppTypography>()!;

    final width =
        MediaQuery.sizeOf(context).shortestSide >= _coachCardTabletShortestSide
        ? _coachCardTabletWidth
        : _coachCardPhoneWidth;
    final radius = BorderRadius.circular(radii.sheetCard);

    return UnconstrainedBox(
      constrainedAxis: Axis.vertical,
      child: SizedBox(
        key: const ValueKey<String>('onboarding-spotlight-card'),
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: palette.surface,
            border: Border.all(
              color: palette.hairline,
              width: _coachCardBorderWidth,
            ),
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.28),
                blurRadius: _coachCardShadowBlur,
                offset: const Offset(0, _coachCardShadowOffsetY),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: _coachCardPaddingVertical,
              horizontal: spacing.s4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  stepLabel,
                  style: typography.monoS
                      .copyWith(
                        color: palette.primary,
                        decoration: TextDecoration.none,
                      )
                      .withVariableWeight(FontWeight.w600),
                ),
                SizedBox(height: spacing.s2),
                Text(
                  title,
                  style: typography.titleM
                      .copyWith(
                        color: palette.ink,
                        decoration: TextDecoration.none,
                      )
                      .withVariableWeight(FontWeight.w700),
                ),
                SizedBox(height: spacing.s2),
                Text(
                  leadLabel,
                  style: typography.monoS
                      .copyWith(
                        color: palette.muted,
                        decoration: TextDecoration.none,
                      )
                      .withVariableWeight(FontWeight.w700),
                ),
                SizedBox(height: spacing.s1),
                Text(
                  body,
                  style: typography.bodyS.copyWith(
                    color: palette.ink2,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: spacing.s3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      key: const ValueKey<String>('onboarding-spotlight-skip'),
                      style: TextButton.styleFrom(
                        foregroundColor: palette.muted,
                        minimumSize: Size(0, spacing.s10),
                        padding: EdgeInsets.symmetric(horizontal: spacing.s2),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: typography.labelM.copyWith(
                          decoration: TextDecoration.none,
                        ),
                      ),
                      onPressed: onSkip,
                      child: Text(
                        skipLabel,
                        style: const TextStyle(decoration: TextDecoration.none),
                      ),
                    ),
                    FilledButton(
                      key: actionKey,
                      style: FilledButton.styleFrom(
                        backgroundColor: palette.primary,
                        foregroundColor: palette.onPrimary,
                        minimumSize: Size(0, spacing.s10),
                        padding: EdgeInsets.symmetric(horizontal: spacing.s4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radii.pill),
                        ),
                        textStyle: typography.bodyS
                            .copyWith(decoration: TextDecoration.none)
                            .withVariableWeight(FontWeight.w700),
                      ),
                      onPressed: onAction,
                      child: Text(
                        actionLabel,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
