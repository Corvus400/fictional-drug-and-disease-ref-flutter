/// Shared constants for detail screens.
abstract final class DetailConstants {
  /// Width at which the detail layout switches to tablet two-pane.
  static const tabletBreakpoint = 600.0;

  /// Phone and tablet app bar height.
  static const appBarHeight = 40.0;

  /// Phone horizontal tab bar height.
  static const tabBarHeight = 40.0;

  /// Fixed bookmark footer height.
  static const footerHeight = 64.0;

  /// Tablet vertical tab navigation width.
  static const tabletNavWidth = 200.0;

  /// Standard content padding inside detail views.
  static const contentPadding = 16.0;

  /// Small gap between compact elements.
  static const gapXs = 4.0;

  /// Standard gap between related elements.
  static const gapS = 8.0;

  /// Standard section gap.
  static const gapM = 16.0;

  /// Large error-state gap.
  static const gapL = 24.0;

  /// Active tab switch animation duration.
  static const tabSwitchDuration = Duration(milliseconds: 200);

  /// Inner tab switch animation duration.
  static const innerTabSwitchDuration = Duration(milliseconds: 150);

  /// Error-state icon size.
  static const errorIconSize = 64.0;

  /// Error retry button width.
  static const retryButtonWidth = 280.0;

  /// Related carousel height.
  static const relatedCarouselHeight = 96.0;

  /// Related carousel item width.
  static const relatedCarouselItemWidth = 160.0;

  /// Detail chip host border width.
  static const chipHostBorderWidth = 0.5;

  /// Detail chip host border radius.
  static const chipHostRadius = 10.0;

  /// Minimum detail chip height.
  static const chipMinHeight = 30.0;

  /// Detail chip text line height.
  static const chipTextHeight = 1.35;
}
