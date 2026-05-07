import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppPalette exposes W2 chip color maps from Detail Spec', () {
    const light = AppPalette.light;
    const dark = AppPalette.dark;

    expect(light.chipDosageForm, hasLength(13));
    expect(light.chipRouteOfAdmin, hasLength(8));
    expect(light.chipPrecaution, hasLength(8));
    expect(light.chipIcd10Chapter, hasLength(22));
    expect(light.chipOnsetPattern, hasLength(5));
    expect(light.chipExamCategory, hasLength(5));

    expect(light.chipDosageForm['tablet'], const Color(0xFF1D4ED8));
    expect(dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF));
    expect(light.chipRouteOfAdmin['inhalation'], const Color(0xFF0891B2));
    expect(dark.chipRouteOfAdmin['inhalation'], const Color(0xFF67E8F9));
    expect(light.chipPrecaution['pregnant'], const Color(0xFF9F1239));
    expect(dark.chipPrecaution['pregnant'], const Color(0xFFFDA4AF));
    expect(light.chipIcd10Chapter['chapter_x'], const Color(0xFF0A6FE8));
    expect(dark.chipIcd10Chapter['chapter_x'], const Color(0xFF9ECAFF));
    expect(light.chipOnsetPattern['intermittent'], const Color(0xFF0F766E));
    expect(dark.chipOnsetPattern['intermittent'], const Color(0xFF5DD5BB));
    expect(light.chipExamCategory['pathology'], const Color(0xFF7C3AED));
    expect(dark.chipExamCategory['pathology'], const Color(0xFFD5BAFF));
  });

  test('AppPalette copyWith and lerp include W2 chip color maps', () {
    final changed = AppPalette.light.copyWith(
      chipDosageForm: const {'tablet': Color(0xFF000000)},
    );

    expect(changed.chipDosageForm['tablet'], const Color(0xFF000000));
    expect(changed.chipRouteOfAdmin, same(AppPalette.light.chipRouteOfAdmin));

    final lerped = AppPalette.light.lerp(AppPalette.dark, 0.5);

    expect(
      lerped.chipDosageForm['tablet'],
      Color.lerp(
        AppPalette.light.chipDosageForm['tablet'],
        AppPalette.dark.chipDosageForm['tablet'],
        0.5,
      ),
    );
    expect(
      lerped.chipIcd10Chapter['chapter_x'],
      Color.lerp(
        AppPalette.light.chipIcd10Chapter['chapter_x'],
        AppPalette.dark.chipIcd10Chapter['chapter_x'],
        0.5,
      ),
    );
  });
}
