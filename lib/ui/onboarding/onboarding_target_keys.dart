import 'package:flutter/widgets.dart';

/// GlobalKey registry for onboarding spotlight targets.
final class OnboardingTargetKeys {
  const OnboardingTargetKeys._();

  /// Search field target.
  static final GlobalKey searchField = GlobalKey(
    debugLabel: 'onboarding-search-field',
  );

  /// App shell navigation target.
  static final GlobalKey navigationTabs = GlobalKey(
    debugLabel: 'onboarding-navigation-tabs',
  );

  /// About entry point target.
  static final GlobalKey aboutButton = GlobalKey(
    debugLabel: 'onboarding-about-button',
  );
}
