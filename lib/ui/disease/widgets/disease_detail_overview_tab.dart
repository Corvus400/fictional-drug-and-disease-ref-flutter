import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';

/// Overview tab for disease detail.
class DiseaseDetailOverviewTab extends StatelessWidget {
  /// Creates an overview tab.
  const DiseaseDetailOverviewTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DiseaseHero(disease: disease, l10n: l10n),
        DetailPanel(
          sectionIndex: 'E3',
          title: l10n.detailDiseaseSectionSynonyms,
          child: DetailBadgeWrap(
            children: [
              for (final synonym in disease.synonyms)
                DetailBadge(label: synonym, tone: DetailBadgeTone.outline),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'E4',
          title: l10n.detailDiseaseSectionSummary,
          child: DetailMarkdownBody(data: disease.summary),
        ),
        DetailPanel(
          sectionIndex: 'E5',
          title: l10n.detailDiseaseSectionEpidemiology,
          showBottomDivider: false,
          child: _DiseaseEpidemiology(disease: disease, l10n: l10n),
        ),
      ],
    );
  }
}

class _DiseaseHero extends StatelessWidget {
  const _DiseaseHero({required this.disease, required this.l10n});

  final Disease disease;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Container(
      key: const ValueKey<String>('disease-detail-hero'),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: colors.outlineVariant)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DetailConstants.heroMetaPaddingHorizontal,
          vertical: Theme.of(context).brightness == Brightness.dark
              ? DetailConstants.heroMetaPaddingVertical + 4
              : DetailConstants.heroMetaPaddingVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_icd10ChapterLabel(l10n, disease.icd10Chapter)} · '
              '${disease.id}',
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: DetailConstants.heroGenericFontSize,
              ),
            ),
            const SizedBox(height: DetailConstants.heroBrandTopMargin),
            Text(
              disease.name,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: DetailConstants.heroBrandFontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: DetailConstants.heroBrandTopMargin),
            Text(
              _nameKanaLine(disease),
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: DetailConstants.heroKanaFontSize,
              ),
            ),
            DetailBadgeWrap(children: _badges(context)),
            Padding(
              padding: const EdgeInsets.only(
                top: DetailConstants.heroRevisedTopMargin,
              ),
              child: Text(
                '${l10n.searchDiseaseMetaRevised(disease.revisedAt)} · E1-E2',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: DetailConstants.heroRevisedFontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _badges(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return [
      DetailBadge(
        label: _icd10ChapterLabel(l10n, disease.icd10Chapter),
        colors: _foregroundBadgeColors(
          palette,
          palette.chipIcd10Chapter[disease.icd10Chapter],
        ),
      ),
      for (final department in disease.medicalDepartment)
        DetailBadge(
          label: _departmentLabel(l10n, department),
          colors: _badgeColors(
            palette.diseaseBadgeColors(
              DiseaseBadgeCategory.department,
              department,
            ),
          ),
        ),
      DetailBadge(
        label: _infectiousLabel(l10n, disease.infectious),
        colors: _badgeColors(
          palette.diseaseBadgeColors(
            DiseaseBadgeCategory.infectious,
            disease.infectious.toString(),
          ),
        ),
      ),
      DetailBadge(
        label: _chronicityLabel(l10n, disease.chronicity),
        colors: _badgeColors(
          palette.diseaseBadgeColors(
            DiseaseBadgeCategory.chronicity,
            disease.chronicity,
          ),
        ),
      ),
    ];
  }
}

class _DiseaseEpidemiology extends StatelessWidget {
  const _DiseaseEpidemiology({required this.disease, required this.l10n});

  final Disease disease;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final epidemiology = disease.epidemiology;
    if (epidemiology == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        if (epidemiology.prevalence != null)
          DetailKvRow(
            label: l10n.detailDiseaseSectionPrevalence,
            value: epidemiology.prevalence!.label,
            showTopBorder: true,
          ),
        if (epidemiology.onsetAgeRange != null)
          DetailKvRow(
            label: l10n.detailDiseaseSectionOnsetAge,
            value: epidemiology.onsetAgeRange!.label,
            showTopBorder: epidemiology.prevalence == null,
          ),
        if (epidemiology.sexRatio != null)
          DetailKvRow(
            label: l10n.detailDiseaseSectionSexRatio,
            value: _sexRatioValue(epidemiology.sexRatio!),
            showTopBorder:
                epidemiology.prevalence == null &&
                epidemiology.onsetAgeRange == null,
          ),
        if (epidemiology.riskFactors.isNotEmpty)
          DetailKvRow(
            label: l10n.detailDiseaseSectionRiskFactors,
            value: epidemiology.riskFactors.join('、'),
            showTopBorder:
                epidemiology.prevalence == null &&
                epidemiology.onsetAgeRange == null &&
                epidemiology.sexRatio == null,
          ),
      ],
    );
  }
}

DetailBadgeColors _badgeColors(({Color background, Color foreground}) colors) {
  return DetailBadgeColors(
    background: colors.background,
    foreground: colors.foreground,
  );
}

DetailBadgeColors _foregroundBadgeColors(
  AppPalette palette,
  Color? foreground,
) {
  return DetailBadgeColors(
    background: palette.surface3,
    foreground: foreground ?? palette.ink2,
  );
}

String _nameKanaLine(Disease disease) {
  final english = disease.nameEnglish;
  if (english == null || english.isEmpty) {
    return disease.nameKana;
  }
  return '${disease.nameKana} · $english';
}

String _sexRatioValue(SexDistribution value) {
  if (value.note != null && value.note!.isNotEmpty) {
    return value.note!;
  }
  return '男 ${value.maleRatio} : 女 ${value.femaleRatio}';
}

String _icd10ChapterLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'chapter_i' => l10n.searchDiseaseIcd10ChapterI,
    'chapter_ii' => l10n.searchDiseaseIcd10ChapterII,
    'chapter_iii' => l10n.searchDiseaseIcd10ChapterIII,
    'chapter_iv' => l10n.searchDiseaseIcd10ChapterIV,
    'chapter_v' => l10n.searchDiseaseIcd10ChapterV,
    'chapter_vi' => l10n.searchDiseaseIcd10ChapterVI,
    'chapter_vii' => l10n.searchDiseaseIcd10ChapterVII,
    'chapter_viii' => l10n.searchDiseaseIcd10ChapterVIII,
    'chapter_ix' => l10n.searchDiseaseIcd10ChapterIX,
    'chapter_x' => l10n.searchDiseaseIcd10ChapterX,
    'chapter_xi' => l10n.searchDiseaseIcd10ChapterXI,
    'chapter_xii' => l10n.searchDiseaseIcd10ChapterXII,
    'chapter_xiii' => l10n.searchDiseaseIcd10ChapterXIII,
    'chapter_xiv' => l10n.searchDiseaseIcd10ChapterXIV,
    'chapter_xv' => l10n.searchDiseaseIcd10ChapterXV,
    'chapter_xvi' => l10n.searchDiseaseIcd10ChapterXVI,
    'chapter_xvii' => l10n.searchDiseaseIcd10ChapterXVII,
    'chapter_xviii' => l10n.searchDiseaseIcd10ChapterXVIII,
    'chapter_xix' => l10n.searchDiseaseIcd10ChapterXIX,
    'chapter_xx' => l10n.searchDiseaseIcd10ChapterXX,
    'chapter_xxi' => l10n.searchDiseaseIcd10ChapterXXI,
    'chapter_xxii' => l10n.searchDiseaseIcd10ChapterXXII,
    _ => value,
  };
}

String _departmentLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'internal_medicine' => l10n.searchDiseaseDepartmentInternalMedicine,
    'cardiology' => l10n.searchDiseaseDepartmentCardiology,
    'gastroenterology' => l10n.searchDiseaseDepartmentGastroenterology,
    'endocrinology' => l10n.searchDiseaseDepartmentEndocrinology,
    'neurology' => l10n.searchDiseaseDepartmentNeurology,
    'psychiatry' => l10n.searchDiseaseDepartmentPsychiatry,
    'surgery' => l10n.searchDiseaseDepartmentSurgery,
    'orthopedics' => l10n.searchDiseaseDepartmentOrthopedics,
    'dermatology' => l10n.searchDiseaseDepartmentDermatology,
    'ophthalmology' => l10n.searchDiseaseDepartmentOphthalmology,
    'otolaryngology' => l10n.searchDiseaseDepartmentOtolaryngology,
    'urology' => l10n.searchDiseaseDepartmentUrology,
    'gynecology' => l10n.searchDiseaseDepartmentGynecology,
    'pediatrics' => l10n.searchDiseaseDepartmentPediatrics,
    'emergency' => l10n.searchDiseaseDepartmentEmergency,
    'infectious_disease' => l10n.searchDiseaseDepartmentInfectiousDisease,
    _ => value,
  };
}

String _chronicityLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseChronicityAcute,
    'subacute' => l10n.searchDiseaseChronicitySubacute,
    'chronic' => l10n.searchDiseaseChronicityChronic,
    'relapsing' => l10n.searchDiseaseChronicityRelapsing,
    _ => value,
  };
}

String _infectiousLabel(AppLocalizations l10n, bool value) {
  return value
      ? l10n.searchDiseaseInfectiousTrue
      : l10n.searchDiseaseInfectiousFalse;
}
