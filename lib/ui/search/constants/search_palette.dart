import 'package:flutter/material.dart';

/// Disease card badge category.
enum DiseaseBadgeCategory {
  /// Disease chronicity.
  chronicity,

  /// Infectious flag.
  infectious,

  /// Medical department.
  department,
}

/// Round6 search color tokens.
final class SearchPalette extends ThemeExtension<SearchPalette> {
  /// Creates a palette.
  const SearchPalette({
    required this.brightness,
    required this.bg,
    required this.surface,
    required this.surface2,
    required this.surface3,
    required this.surface4,
    required this.ink,
    required this.ink2,
    required this.muted,
    required this.muted2,
    required this.background,
    required this.surfaceSubtle,
    required this.hairline,
    required this.hairline2,
    required this.primary,
    required this.onPrimary,
    required this.searchPrimaryActionBg,
    required this.searchPrimaryActionFg,
    required this.primarySoft,
    required this.primaryRing,
    required this.danger,
    required this.dangerCont,
    required this.scrim,
    required this.searchFieldBg,
    required this.rxTint,
    required this.rxInk,
    required this.dxTint,
    required this.dxInk,
    required this.drugTint,
    required this.drugInk,
    required this.diseaseTint,
    required this.diseaseInk,
  });

  /// Light Round6 palette.
  static const light = SearchPalette(
    brightness: Brightness.light,
    bg: Color(0xFFF2F2F7),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFF7F7FA),
    surface3: Color(0xFFEFEFF4),
    surface4: Color(0xFFE5E5EA),
    ink: Color(0xFF1A1C1E),
    ink2: Color(0xFF3F4347),
    muted: Color(0xFF6C7177),
    muted2: Color(0xFF8E9298),
    background: Color(0xFFF2F2F7),
    surfaceSubtle: Color(0xFFEFEFF4),
    hairline: Color(0x213C3C43),
    hairline2: Color(0x143C3C43),
    primary: Color(0xFF007AFF),
    onPrimary: Color(0xFFFFFFFF),
    searchPrimaryActionBg: Color(0xFF007AFF),
    searchPrimaryActionFg: Color(0xFFFFFFFF),
    primarySoft: Color(0x1A007AFF),
    primaryRing: Color(0x59007AFF),
    danger: Color(0xFFD62A2A),
    dangerCont: Color(0xFFFFEDED),
    scrim: Color(0x52000000),
    searchFieldBg: Color(0xFFEBEBEF),
    rxTint: Color(0x1A007AFF),
    rxInk: Color(0xFF0A6FE8),
    dxTint: Color(0x1A7A4FCC),
    dxInk: Color(0xFF7A4FCC),
    drugTint: Color(0x1A0A6FE8),
    drugInk: Color(0xFF0A6FE8),
    diseaseTint: Color(0x1A7A4FCC),
    diseaseInk: Color(0xFF7A4FCC),
  );

  /// Dark Round6 palette.
  static const dark = SearchPalette(
    brightness: Brightness.dark,
    bg: Color(0xFF101317),
    surface: Color(0xFF181B20),
    surface2: Color(0xFF1F2329),
    surface3: Color(0xFF272B32),
    surface4: Color(0xFF31353D),
    ink: Color(0xFFE5E7EC),
    ink2: Color(0xFFC2C6CD),
    muted: Color(0xFF9CA1AA),
    muted2: Color(0xFF7A7F88),
    background: Color(0xFF101317),
    surfaceSubtle: Color(0xFF272B32),
    hairline: Color(0x1AFFFFFF),
    hairline2: Color(0x0FFFFFFF),
    primary: Color(0xFF9ECAFF),
    onPrimary: Color(0xFF003258),
    searchPrimaryActionBg: Color(0xFF00497F),
    searchPrimaryActionFg: Color(0xFF003258),
    primarySoft: Color(0x249ECAFF),
    primaryRing: Color(0x739ECAFF),
    danger: Color(0xFFFFB4AB),
    dangerCont: Color(0xFF5C1612),
    scrim: Color(0x8C000000),
    searchFieldBg: Color(0xFF272B32),
    rxTint: Color(0x299ECAFF),
    rxInk: Color(0xFF9ECAFF),
    dxTint: Color(0x29D5BAFF),
    dxInk: Color(0xFFD5BAFF),
    drugTint: Color(0x299ECAFF),
    drugInk: Color(0xFF9ECAFF),
    diseaseTint: Color(0x29D5BAFF),
    diseaseInk: Color(0xFFD5BAFF),
  );

  /// Theme brightness this palette represents.
  final Brightness brightness;

  /// Page background.
  final Color bg;

  /// Main surface.
  final Color surface;

  /// Secondary surface.
  final Color surface2;

  /// Tertiary surface.
  final Color surface3;

  /// Quaternary surface.
  final Color surface4;

  /// Primary ink.
  final Color ink;

  /// Secondary ink.
  final Color ink2;

  /// Muted text.
  final Color muted;

  /// More muted text.
  final Color muted2;

  /// Search page background.
  final Color background;

  /// Subtle surface used for input fields and empty containers.
  final Color surfaceSubtle;

  /// Hairline color.
  final Color hairline;

  /// Fainter hairline color.
  final Color hairline2;

  /// Primary action color.
  final Color primary;

  /// Text/icon color on primary.
  final Color onPrimary;

  /// Round6 primary action background.
  final Color searchPrimaryActionBg;

  /// Round6 primary action foreground.
  final Color searchPrimaryActionFg;

  /// Soft primary fill.
  final Color primarySoft;

  /// Primary focus ring.
  final Color primaryRing;

  /// Destructive/accent danger color.
  final Color danger;

  /// Danger container color.
  final Color dangerCont;

  /// Modal scrim color.
  final Color scrim;

  /// Search field fill.
  final Color searchFieldBg;

  /// Rx badge tint.
  final Color rxTint;

  /// Rx badge ink.
  final Color rxInk;

  /// Dx badge tint.
  final Color dxTint;

  /// Dx badge ink.
  final Color dxInk;

  /// Drug target pill tint.
  final Color drugTint;

  /// Drug target pill ink.
  final Color drugInk;

  /// Disease target pill tint.
  final Color diseaseTint;

  /// Disease target pill ink.
  final Color diseaseInk;

  /// Drug regulatory badge colors.
  ({Color background, Color foreground}) regulatoryBadgeColors(String value) {
    final base = switch (value) {
      'poison' => danger,
      'potent' => _byBrightness(
        light: const Color(0xFFB45309),
        dark: const Color(0xFFFFB77C),
      ),
      'prescription_required' => drugInk,
      'psychotropic_1' || 'psychotropic_2' || 'psychotropic_3' => _byBrightness(
        light: const Color(0xFF7C3AED),
        dark: const Color(0xFFD5BAFF),
      ),
      'narcotic' => _byBrightness(
        light: const Color(0xFF9333EA),
        dark: const Color(0xFFE1BDFF),
      ),
      'stimulant_precursor' => _byBrightness(
        light: const Color(0xFFEA580C),
        dark: const Color(0xFFFFB68B),
      ),
      'biological' => _byBrightness(
        light: const Color(0xFF0F766E),
        dark: const Color(0xFF5DD5BB),
      ),
      'specified_biological' => _byBrightness(
        light: const Color(0xFF0E7490),
        dark: const Color(0xFF7DD3FC),
      ),
      'ordinary' => _byBrightness(
        light: const Color(0xFF4B5563),
        dark: const Color(0xFFC5CAD0),
      ),
      _ => drugInk,
    };
    return _badgeColors(base);
  }

  /// Disease card badge colors derived from a category-specific base color.
  ({Color background, Color foreground}) diseaseBadgeColors(
    DiseaseBadgeCategory category,
    String value,
  ) {
    final base = switch (category) {
      DiseaseBadgeCategory.chronicity => switch (value) {
        'acute' => _byBrightness(
          light: const Color(0xFFC2410C),
          dark: const Color(0xFFFB923C),
        ),
        'chronic' || 'subacute' => _byBrightness(
          light: const Color(0xFFB45309),
          dark: const Color(0xFFFFB77C),
        ),
        'episodic' || 'relapsing' => _byBrightness(
          light: const Color(0xFF7C3AED),
          dark: const Color(0xFFD5BAFF),
        ),
        'remission' => _byBrightness(
          light: const Color(0xFF0F766E),
          dark: const Color(0xFF5DD5BB),
        ),
        _ => diseaseInk,
      },
      DiseaseBadgeCategory.infectious => switch (value) {
        'true' => danger,
        'false' => _byBrightness(
          light: const Color(0xFF0F766E),
          dark: const Color(0xFF5DD5BB),
        ),
        'infectious' => _byBrightness(
          light: const Color(0xFF4B5563),
          dark: const Color(0xFFC5CAD0),
        ),
        'non_infectious' => _byBrightness(
          light: const Color(0xFF0F766E),
          dark: const Color(0xFF5DD5BB),
        ),
        _ => diseaseInk,
      },
      DiseaseBadgeCategory.department => switch (value) {
        'internal_medicine' => _byBrightness(
          light: const Color(0xFF1D4ED8),
          dark: const Color(0xFFBFD7FF),
        ),
        'surgery' => _byBrightness(
          light: const Color(0xFFB91C1C),
          dark: const Color(0xFFFFB4AB),
        ),
        'pediatrics' => _byBrightness(
          light: const Color(0xFF15803D),
          dark: const Color(0xFF86E0A4),
        ),
        'obstetrics_gynecology' || 'gynecology' => _byBrightness(
          light: const Color(0xFFEA580C),
          dark: const Color(0xFFFFB68B),
        ),
        'psychiatry' => _byBrightness(
          light: const Color(0xFF6D28D9),
          dark: const Color(0xFFC9B5FF),
        ),
        'dermatology' => _byBrightness(
          light: const Color(0xFF0E7490),
          dark: const Color(0xFF7DD3FC),
        ),
        'orthopedics' => _byBrightness(
          light: const Color(0xFFA16207),
          dark: const Color(0xFFFFC966),
        ),
        'ophthalmology' => _byBrightness(
          light: const Color(0xFFBE185D),
          dark: const Color(0xFFFFB1C8),
        ),
        'otolaryngology' => _byBrightness(
          light: const Color(0xFF0891B2),
          dark: const Color(0xFF67E8F9),
        ),
        'cardiology' => _byBrightness(
          light: const Color(0xFF4D7C0F),
          dark: const Color(0xFFBEF264),
        ),
        'neurology' => _byBrightness(
          light: const Color(0xFF3730A3),
          dark: const Color(0xFFC7D2FE),
        ),
        'urology' => _byBrightness(
          light: const Color(0xFF9F1239),
          dark: const Color(0xFFFDA4AF),
        ),
        'gastroenterology' => _byBrightness(
          light: const Color(0xFFCA8A04),
          dark: const Color(0xFFFDE68A),
        ),
        'respiratory' || 'emergency' => _byBrightness(
          light: const Color(0xFF7F1D1D),
          dark: const Color(0xFFFCA5A5),
        ),
        'nephrology' || 'infectious_disease' => _byBrightness(
          light: const Color(0xFF9A3412),
          dark: const Color(0xFFFDBA74),
        ),
        'endocrinology' => _byBrightness(
          light: const Color(0xFF0F766E),
          dark: const Color(0xFF5DD5BB),
        ),
        _ => diseaseInk,
      },
    };
    return _badgeColors(base);
  }

  ({Color background, Color foreground}) _badgeColors(Color base) {
    final alpha = brightness == Brightness.dark ? 0.20 : 0.02;
    return (background: base.withValues(alpha: alpha), foreground: base);
  }

  Color _byBrightness({required Color light, required Color dark}) {
    return brightness == Brightness.dark ? dark : light;
  }

  @override
  SearchPalette copyWith({
    Brightness? brightness,
    Color? bg,
    Color? surface,
    Color? surface2,
    Color? surface3,
    Color? surface4,
    Color? ink,
    Color? ink2,
    Color? muted,
    Color? muted2,
    Color? background,
    Color? surfaceSubtle,
    Color? hairline,
    Color? hairline2,
    Color? primary,
    Color? onPrimary,
    Color? searchPrimaryActionBg,
    Color? searchPrimaryActionFg,
    Color? primarySoft,
    Color? primaryRing,
    Color? danger,
    Color? dangerCont,
    Color? scrim,
    Color? searchFieldBg,
    Color? rxTint,
    Color? rxInk,
    Color? dxTint,
    Color? dxInk,
    Color? drugTint,
    Color? drugInk,
    Color? diseaseTint,
    Color? diseaseInk,
  }) {
    return SearchPalette(
      brightness: brightness ?? this.brightness,
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      surface3: surface3 ?? this.surface3,
      surface4: surface4 ?? this.surface4,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      muted: muted ?? this.muted,
      muted2: muted2 ?? this.muted2,
      background: background ?? this.background,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      hairline: hairline ?? this.hairline,
      hairline2: hairline2 ?? this.hairline2,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      searchPrimaryActionBg:
          searchPrimaryActionBg ?? this.searchPrimaryActionBg,
      searchPrimaryActionFg:
          searchPrimaryActionFg ?? this.searchPrimaryActionFg,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryRing: primaryRing ?? this.primaryRing,
      danger: danger ?? this.danger,
      dangerCont: dangerCont ?? this.dangerCont,
      scrim: scrim ?? this.scrim,
      searchFieldBg: searchFieldBg ?? this.searchFieldBg,
      rxTint: rxTint ?? this.rxTint,
      rxInk: rxInk ?? this.rxInk,
      dxTint: dxTint ?? this.dxTint,
      dxInk: dxInk ?? this.dxInk,
      drugTint: drugTint ?? this.drugTint,
      drugInk: drugInk ?? this.drugInk,
      diseaseTint: diseaseTint ?? this.diseaseTint,
      diseaseInk: diseaseInk ?? this.diseaseInk,
    );
  }

  @override
  SearchPalette lerp(ThemeExtension<SearchPalette>? other, double t) {
    if (other is! SearchPalette) {
      return this;
    }
    return SearchPalette(
      brightness: t < 0.5 ? brightness : other.brightness,
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      surface3: Color.lerp(surface3, other.surface3, t)!,
      surface4: Color.lerp(surface4, other.surface4, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      muted2: Color.lerp(muted2, other.muted2, t)!,
      background: Color.lerp(background, other.background, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      hairline2: Color.lerp(hairline2, other.hairline2, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      searchPrimaryActionBg: Color.lerp(
        searchPrimaryActionBg,
        other.searchPrimaryActionBg,
        t,
      )!,
      searchPrimaryActionFg: Color.lerp(
        searchPrimaryActionFg,
        other.searchPrimaryActionFg,
        t,
      )!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      primaryRing: Color.lerp(primaryRing, other.primaryRing, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerCont: Color.lerp(dangerCont, other.dangerCont, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      searchFieldBg: Color.lerp(searchFieldBg, other.searchFieldBg, t)!,
      rxTint: Color.lerp(rxTint, other.rxTint, t)!,
      rxInk: Color.lerp(rxInk, other.rxInk, t)!,
      dxTint: Color.lerp(dxTint, other.dxTint, t)!,
      dxInk: Color.lerp(dxInk, other.dxInk, t)!,
      drugTint: Color.lerp(drugTint, other.drugTint, t)!,
      drugInk: Color.lerp(drugInk, other.drugInk, t)!,
      diseaseTint: Color.lerp(diseaseTint, other.diseaseTint, t)!,
      diseaseInk: Color.lerp(diseaseInk, other.diseaseInk, t)!,
    );
  }
}
