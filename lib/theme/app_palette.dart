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

/// Round6 application color tokens.
final class AppPalette extends ThemeExtension<AppPalette> {
  /// Creates a palette.
  const AppPalette({
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
    required this.filterFabBg,
    required this.filterFabFg,
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
    required this.chipDosageForm,
    required this.chipRouteOfAdmin,
    required this.chipPrecaution,
    required this.chipIcd10Chapter,
    required this.chipOnsetPattern,
    required this.chipExamCategory,
  });

  /// Light Round6 palette.
  static const light = AppPalette(
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
    filterFabBg: Color(0xFF007AFF),
    filterFabFg: Color(0xFFFFFFFF),
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
    chipDosageForm: _lightChipDosageForm,
    chipRouteOfAdmin: _lightChipRouteOfAdmin,
    chipPrecaution: _lightChipPrecaution,
    chipIcd10Chapter: _lightChipIcd10Chapter,
    chipOnsetPattern: _lightChipOnsetPattern,
    chipExamCategory: _lightChipExamCategory,
  );

  /// Dark Round6 palette.
  static const dark = AppPalette(
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
    searchPrimaryActionBg: Color(0xFF9ECAFF),
    searchPrimaryActionFg: Color(0xFF003258),
    filterFabBg: Color(0xFF00497F),
    filterFabFg: Color(0xFFD1E4FF),
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
    chipDosageForm: _darkChipDosageForm,
    chipRouteOfAdmin: _darkChipRouteOfAdmin,
    chipPrecaution: _darkChipPrecaution,
    chipIcd10Chapter: _darkChipIcd10Chapter,
    chipOnsetPattern: _darkChipOnsetPattern,
    chipExamCategory: _darkChipExamCategory,
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

  /// Round6 filter FAB background.
  final Color filterFabBg;

  /// Round6 filter FAB foreground.
  final Color filterFabFg;

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

  /// W2 dosage-form chip foreground colors keyed by mock-server serial name.
  final Map<String, Color> chipDosageForm;

  /// W2 route-of-administration chip foreground colors keyed by serial name.
  final Map<String, Color> chipRouteOfAdmin;

  /// W2 precaution-population chip foreground colors keyed by serial name.
  final Map<String, Color> chipPrecaution;

  /// W2 ICD-10 chapter chip foreground colors keyed by serial name.
  final Map<String, Color> chipIcd10Chapter;

  /// W2 onset-pattern chip foreground colors keyed by serial name.
  final Map<String, Color> chipOnsetPattern;

  /// W2 exam-category chip foreground colors keyed by serial name.
  final Map<String, Color> chipExamCategory;

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
    final alpha = brightness == Brightness.dark ? 0.20 : 0.05;
    final background = base.withValues(alpha: alpha);
    return (
      background: background,
      foreground: _ensureBadgeContrast(base, background),
    );
  }

  Color _ensureBadgeContrast(Color foreground, Color background) {
    final surfaceColor = Color.alphaBlend(background, surface);
    var adjusted = foreground;
    for (var index = 0; index < 16; index += 1) {
      if (_contrast(adjusted, surfaceColor) >= 4.5) {
        return adjusted;
      }
      final hsl = HSLColor.fromColor(adjusted);
      final nextLightness = brightness == Brightness.dark
          ? (hsl.lightness + 0.04).clamp(0.0, 1.0)
          : (hsl.lightness - 0.04).clamp(0.0, 1.0);
      adjusted = hsl.withLightness(nextLightness).toColor();
    }
    return adjusted;
  }

  double _contrast(Color a, Color b) {
    final l1 = a.computeLuminance();
    final l2 = b.computeLuminance();
    final lighter = l1 > l2 ? l1 : l2;
    final darker = l1 > l2 ? l2 : l1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  Color _byBrightness({required Color light, required Color dark}) {
    return brightness == Brightness.dark ? dark : light;
  }

  @override
  AppPalette copyWith({
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
    Color? filterFabBg,
    Color? filterFabFg,
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
    Map<String, Color>? chipDosageForm,
    Map<String, Color>? chipRouteOfAdmin,
    Map<String, Color>? chipPrecaution,
    Map<String, Color>? chipIcd10Chapter,
    Map<String, Color>? chipOnsetPattern,
    Map<String, Color>? chipExamCategory,
  }) {
    return AppPalette(
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
      filterFabBg: filterFabBg ?? this.filterFabBg,
      filterFabFg: filterFabFg ?? this.filterFabFg,
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
      chipDosageForm: chipDosageForm ?? this.chipDosageForm,
      chipRouteOfAdmin: chipRouteOfAdmin ?? this.chipRouteOfAdmin,
      chipPrecaution: chipPrecaution ?? this.chipPrecaution,
      chipIcd10Chapter: chipIcd10Chapter ?? this.chipIcd10Chapter,
      chipOnsetPattern: chipOnsetPattern ?? this.chipOnsetPattern,
      chipExamCategory: chipExamCategory ?? this.chipExamCategory,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) {
      return this;
    }
    return AppPalette(
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
      filterFabBg: Color.lerp(filterFabBg, other.filterFabBg, t)!,
      filterFabFg: Color.lerp(filterFabFg, other.filterFabFg, t)!,
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
      chipDosageForm: _lerpColorMap(
        chipDosageForm,
        other.chipDosageForm,
        t,
      ),
      chipRouteOfAdmin: _lerpColorMap(
        chipRouteOfAdmin,
        other.chipRouteOfAdmin,
        t,
      ),
      chipPrecaution: _lerpColorMap(
        chipPrecaution,
        other.chipPrecaution,
        t,
      ),
      chipIcd10Chapter: _lerpColorMap(
        chipIcd10Chapter,
        other.chipIcd10Chapter,
        t,
      ),
      chipOnsetPattern: _lerpColorMap(
        chipOnsetPattern,
        other.chipOnsetPattern,
        t,
      ),
      chipExamCategory: _lerpColorMap(
        chipExamCategory,
        other.chipExamCategory,
        t,
      ),
    );
  }
}

Map<String, Color> _lerpColorMap(
  Map<String, Color> a,
  Map<String, Color> b,
  double t,
) {
  return <String, Color>{
    for (final key in {...a.keys, ...b.keys})
      key: Color.lerp(a[key] ?? b[key], b[key] ?? a[key], t)!,
  };
}

const _lightChipRouteOfAdmin = <String, Color>{
  'oral': Color(0xFF1D4ED8),
  'topical': Color(0xFF0E7490),
  'injection_route': Color(0xFFB91C1C),
  'inhalation': Color(0xFF0891B2),
  'rectal': Color(0xFFA16207),
  'ophthalmic': Color(0xFF6D28D9),
  'nasal': Color(0xFF15803D),
  'transdermal': Color(0xFFBE185D),
};

const _darkChipRouteOfAdmin = <String, Color>{
  'oral': Color(0xFFBFD7FF),
  'topical': Color(0xFF7DD3FC),
  'injection_route': Color(0xFFFFB4AB),
  'inhalation': Color(0xFF67E8F9),
  'rectal': Color(0xFFFFC966),
  'ophthalmic': Color(0xFFC9B5FF),
  'nasal': Color(0xFF86E0A4),
  'transdermal': Color(0xFFFFB1C8),
};

const _lightChipDosageForm = <String, Color>{
  'tablet': Color(0xFF1D4ED8),
  'capsule': Color(0xFF7C3AED),
  'powder': Color(0xFFA16207),
  'granule': Color(0xFFCA8A04),
  'liquid': Color(0xFF0891B2),
  'injection_form': Color(0xFFB91C1C),
  'ointment': Color(0xFF15803D),
  'cream': Color(0xFF0F766E),
  'patch': Color(0xFFBE185D),
  'eye_drops': Color(0xFF3730A3),
  'suppository': Color(0xFF9A3412),
  'inhaler': Color(0xFF0E7490),
  'nasal_spray': Color(0xFF6D28D9),
};

const _darkChipDosageForm = <String, Color>{
  'tablet': Color(0xFFBFD7FF),
  'capsule': Color(0xFFD5BAFF),
  'powder': Color(0xFFFFC966),
  'granule': Color(0xFFFDE68A),
  'liquid': Color(0xFF67E8F9),
  'injection_form': Color(0xFFFFB4AB),
  'ointment': Color(0xFF86E0A4),
  'cream': Color(0xFF5DD5BB),
  'patch': Color(0xFFFFB1C8),
  'eye_drops': Color(0xFFC7D2FE),
  'suppository': Color(0xFFFDBA74),
  'inhaler': Color(0xFF7DD3FC),
  'nasal_spray': Color(0xFFC9B5FF),
};

const _lightChipPrecaution = <String, Color>{
  'comorbidity': Color(0xFF4B5563),
  'renal_impairment': Color(0xFFA16207),
  'hepatic_impairment': Color(0xFFCA8A04),
  'reproductive_potential': Color(0xFFBE185D),
  'pregnant': Color(0xFF9F1239),
  'lactating': Color(0xFF6D28D9),
  'pediatric': Color(0xFF15803D),
  'geriatric': Color(0xFF1D4ED8),
};

const _darkChipPrecaution = <String, Color>{
  'comorbidity': Color(0xFFC5CAD0),
  'renal_impairment': Color(0xFFFFC966),
  'hepatic_impairment': Color(0xFFFDE68A),
  'reproductive_potential': Color(0xFFFFB1C8),
  'pregnant': Color(0xFFFDA4AF),
  'lactating': Color(0xFFC9B5FF),
  'pediatric': Color(0xFF86E0A4),
  'geriatric': Color(0xFFBFD7FF),
};

const _lightChipIcd10Chapter = <String, Color>{
  'chapter_i': Color(0xFFB91C1C),
  'chapter_ii': Color(0xFF7C3AED),
  'chapter_iii': Color(0xFF9F1239),
  'chapter_iv': Color(0xFFA16207),
  'chapter_v': Color(0xFF6D28D9),
  'chapter_vi': Color(0xFF3730A3),
  'chapter_vii': Color(0xFF0E7490),
  'chapter_viii': Color(0xFF0891B2),
  'chapter_ix': Color(0xFFB45309),
  'chapter_x': Color(0xFF0A6FE8),
  'chapter_xi': Color(0xFFCA8A04),
  'chapter_xii': Color(0xFFBE185D),
  'chapter_xiii': Color(0xFF4D7C0F),
  'chapter_xiv': Color(0xFF0F766E),
  'chapter_xv': Color(0xFF9333EA),
  'chapter_xvi': Color(0xFF15803D),
  'chapter_xvii': Color(0xFFEA580C),
  'chapter_xviii': Color(0xFF475569),
  'chapter_xix': Color(0xFF7F1D1D),
  'chapter_xx': Color(0xFF9A3412),
  'chapter_xxi': Color(0xFF1D4ED8),
  'chapter_xxii': Color(0xFF374151),
};

const _darkChipIcd10Chapter = <String, Color>{
  'chapter_i': Color(0xFFFFB4AB),
  'chapter_ii': Color(0xFFD5BAFF),
  'chapter_iii': Color(0xFFFDA4AF),
  'chapter_iv': Color(0xFFFFC966),
  'chapter_v': Color(0xFFC9B5FF),
  'chapter_vi': Color(0xFFC7D2FE),
  'chapter_vii': Color(0xFF7DD3FC),
  'chapter_viii': Color(0xFF67E8F9),
  'chapter_ix': Color(0xFFFFB77C),
  'chapter_x': Color(0xFF9ECAFF),
  'chapter_xi': Color(0xFFFDE68A),
  'chapter_xii': Color(0xFFFFB1C8),
  'chapter_xiii': Color(0xFFBEF264),
  'chapter_xiv': Color(0xFF5DD5BB),
  'chapter_xv': Color(0xFFE1BDFF),
  'chapter_xvi': Color(0xFF86E0A4),
  'chapter_xvii': Color(0xFFFFB68B),
  'chapter_xviii': Color(0xFFCBD5E1),
  'chapter_xix': Color(0xFFFCA5A5),
  'chapter_xx': Color(0xFFFDBA74),
  'chapter_xxi': Color(0xFFBFD7FF),
  'chapter_xxii': Color(0xFF9CA3AF),
};

const _lightChipOnsetPattern = <String, Color>{
  'acute': Color(0xFFC2410C),
  'subacute': Color(0xFFB45309),
  'chronic': Color(0xFF1D4ED8),
  'intermittent': Color(0xFF0F766E),
  'relapsing': Color(0xFF7C3AED),
};

const _darkChipOnsetPattern = <String, Color>{
  'acute': Color(0xFFFB923C),
  'subacute': Color(0xFFFFB77C),
  'chronic': Color(0xFFBFD7FF),
  'intermittent': Color(0xFF5DD5BB),
  'relapsing': Color(0xFFD5BAFF),
};

const _lightChipExamCategory = <String, Color>{
  'blood_test': Color(0xFFB91C1C),
  'imaging': Color(0xFF1D4ED8),
  'physiological': Color(0xFF0891B2),
  'pathology': Color(0xFF7C3AED),
  'interview': Color(0xFF15803D),
};

const _darkChipExamCategory = <String, Color>{
  'blood_test': Color(0xFFFFB4AB),
  'imaging': Color(0xFFBFD7FF),
  'physiological': Color(0xFF67E8F9),
  'pathology': Color(0xFFD5BAFF),
  'interview': Color(0xFF86E0A4),
};
