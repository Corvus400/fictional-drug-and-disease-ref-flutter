import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 1/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      expect(light.chipDosageForm, hasLength(13));
      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 2/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      expect(light.chipRouteOfAdmin, hasLength(8));
      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 3/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      expect(light.chipPrecaution, hasLength(8));
      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 4/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      expect(light.chipIcd10Chapter, hasLength(22));
      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 5/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      expect(light.chipOnsetPattern, hasLength(5));
      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 6/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      expect(light.chipExamCategory, hasLength(5));

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 7/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      expect(light.chipDosageForm['tablet'], const Color(0xFF1D4ED8));
      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 8/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      expect(dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF));
      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 9/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      expect(light.chipRouteOfAdmin['inhalation'], const Color(0xFF0891B2));
      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 10/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      expect(dark.chipRouteOfAdmin['inhalation'], const Color(0xFF67E8F9));
      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 11/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      expect(light.chipPrecaution['pregnant'], const Color(0xFF9F1239));
      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 12/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      expect(dark.chipPrecaution['pregnant'], const Color(0xFFFDA4AF));
      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 13/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      expect(light.chipIcd10Chapter['chapter_x'], const Color(0xFF0A6FE8));
      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 14/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      expect(dark.chipIcd10Chapter['chapter_x'], const Color(0xFF9ECAFF));
      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 15/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      expect(light.chipOnsetPattern['intermittent'], const Color(0xFF0F766E));
      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 16/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      expect(dark.chipOnsetPattern['intermittent'], const Color(0xFF5DD5BB));
      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 17/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      expect(light.chipExamCategory['pathology'], const Color(0xFF7C3AED));
      Object.hashAll([
        dark.chipExamCategory['pathology'],
        const Color(0xFFD5BAFF),
      ]);
    },
  );

  test(
    'AppPalette exposes W2 chip color maps from Detail Spec [assertion 18/18]',
    () {
      const light = AppPalette.light;
      const dark = AppPalette.dark;

      Object.hashAll([light.chipDosageForm, hasLength(13)]);

      Object.hashAll([light.chipRouteOfAdmin, hasLength(8)]);

      Object.hashAll([light.chipPrecaution, hasLength(8)]);

      Object.hashAll([light.chipIcd10Chapter, hasLength(22)]);

      Object.hashAll([light.chipOnsetPattern, hasLength(5)]);

      Object.hashAll([light.chipExamCategory, hasLength(5)]);

      Object.hashAll([light.chipDosageForm['tablet'], const Color(0xFF1D4ED8)]);

      Object.hashAll([dark.chipDosageForm['tablet'], const Color(0xFFBFD7FF)]);

      Object.hashAll([
        light.chipRouteOfAdmin['inhalation'],
        const Color(0xFF0891B2),
      ]);

      Object.hashAll([
        dark.chipRouteOfAdmin['inhalation'],
        const Color(0xFF67E8F9),
      ]);

      Object.hashAll([
        light.chipPrecaution['pregnant'],
        const Color(0xFF9F1239),
      ]);

      Object.hashAll([
        dark.chipPrecaution['pregnant'],
        const Color(0xFFFDA4AF),
      ]);

      Object.hashAll([
        light.chipIcd10Chapter['chapter_x'],
        const Color(0xFF0A6FE8),
      ]);

      Object.hashAll([
        dark.chipIcd10Chapter['chapter_x'],
        const Color(0xFF9ECAFF),
      ]);

      Object.hashAll([
        light.chipOnsetPattern['intermittent'],
        const Color(0xFF0F766E),
      ]);

      Object.hashAll([
        dark.chipOnsetPattern['intermittent'],
        const Color(0xFF5DD5BB),
      ]);

      Object.hashAll([
        light.chipExamCategory['pathology'],
        const Color(0xFF7C3AED),
      ]);

      expect(dark.chipExamCategory['pathology'], const Color(0xFFD5BAFF));
    },
  );

  test(
    'AppPalette copyWith and lerp include W2 chip color maps [assertion 1/4]',
    () {
      final changed = AppPalette.light.copyWith(
        chipDosageForm: const {'tablet': Color(0xFF000000)},
      );

      expect(changed.chipDosageForm['tablet'], const Color(0xFF000000));
      Object.hashAll([
        changed.chipRouteOfAdmin,
        same(AppPalette.light.chipRouteOfAdmin),
      ]);

      final lerped = AppPalette.light.lerp(AppPalette.dark, 0.5);

      Object.hashAll([
        lerped.chipDosageForm['tablet'],
        Color.lerp(
          AppPalette.light.chipDosageForm['tablet'],
          AppPalette.dark.chipDosageForm['tablet'],
          0.5,
        ),
      ]);

      Object.hashAll([
        lerped.chipIcd10Chapter['chapter_x'],
        Color.lerp(
          AppPalette.light.chipIcd10Chapter['chapter_x'],
          AppPalette.dark.chipIcd10Chapter['chapter_x'],
          0.5,
        ),
      ]);
    },
  );

  test(
    'AppPalette copyWith and lerp include W2 chip color maps [assertion 2/4]',
    () {
      final changed = AppPalette.light.copyWith(
        chipDosageForm: const {'tablet': Color(0xFF000000)},
      );

      Object.hashAll([
        changed.chipDosageForm['tablet'],
        const Color(0xFF000000),
      ]);

      expect(changed.chipRouteOfAdmin, same(AppPalette.light.chipRouteOfAdmin));

      final lerped = AppPalette.light.lerp(AppPalette.dark, 0.5);

      Object.hashAll([
        lerped.chipDosageForm['tablet'],
        Color.lerp(
          AppPalette.light.chipDosageForm['tablet'],
          AppPalette.dark.chipDosageForm['tablet'],
          0.5,
        ),
      ]);

      Object.hashAll([
        lerped.chipIcd10Chapter['chapter_x'],
        Color.lerp(
          AppPalette.light.chipIcd10Chapter['chapter_x'],
          AppPalette.dark.chipIcd10Chapter['chapter_x'],
          0.5,
        ),
      ]);
    },
  );

  test(
    'AppPalette copyWith and lerp include W2 chip color maps [assertion 3/4]',
    () {
      final changed = AppPalette.light.copyWith(
        chipDosageForm: const {'tablet': Color(0xFF000000)},
      );

      Object.hashAll([
        changed.chipDosageForm['tablet'],
        const Color(0xFF000000),
      ]);

      Object.hashAll([
        changed.chipRouteOfAdmin,
        same(AppPalette.light.chipRouteOfAdmin),
      ]);

      final lerped = AppPalette.light.lerp(AppPalette.dark, 0.5);

      expect(
        lerped.chipDosageForm['tablet'],
        Color.lerp(
          AppPalette.light.chipDosageForm['tablet'],
          AppPalette.dark.chipDosageForm['tablet'],
          0.5,
        ),
      );
      Object.hashAll([
        lerped.chipIcd10Chapter['chapter_x'],
        Color.lerp(
          AppPalette.light.chipIcd10Chapter['chapter_x'],
          AppPalette.dark.chipIcd10Chapter['chapter_x'],
          0.5,
        ),
      ]);
    },
  );

  test(
    'AppPalette copyWith and lerp include W2 chip color maps [assertion 4/4]',
    () {
      final changed = AppPalette.light.copyWith(
        chipDosageForm: const {'tablet': Color(0xFF000000)},
      );

      Object.hashAll([
        changed.chipDosageForm['tablet'],
        const Color(0xFF000000),
      ]);

      Object.hashAll([
        changed.chipRouteOfAdmin,
        same(AppPalette.light.chipRouteOfAdmin),
      ]);

      final lerped = AppPalette.light.lerp(AppPalette.dark, 0.5);

      Object.hashAll([
        lerped.chipDosageForm['tablet'],
        Color.lerp(
          AppPalette.light.chipDosageForm['tablet'],
          AppPalette.dark.chipDosageForm['tablet'],
          0.5,
        ),
      ]);

      expect(
        lerped.chipIcd10Chapter['chapter_x'],
        Color.lerp(
          AppPalette.light.chipIcd10Chapter['chapter_x'],
          AppPalette.dark.chipIcd10Chapter['chapter_x'],
          0.5,
        ),
      );
    },
  );
}
