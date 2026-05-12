import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/constants/search_constants.dart';
import 'package:flutter/material.dart';

/// Shared disease result card used by search, bookmarks, and browsing history.
class DiseaseResultCard extends StatelessWidget {
  /// Creates a disease result card.
  const DiseaseResultCard({
    required this.item,
    super.key,
    this.onTap,
    this.trailingTime,
    this.borderRadius,
  });

  /// Disease summary to render.
  final DiseaseSummary item;

  /// Optional tap handler.
  final VoidCallback? onTap;

  /// Optional inline trailing time widget for browsing history rows.
  final Widget? trailingTime;

  /// Card corner radius. Browsing history overrides this while swipe-delete is
  /// revealed so the front card joins the delete action without a rounded seam.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final cardBorderRadius =
        borderRadius ?? BorderRadius.circular(SearchConstants.searchCardRadius);
    return Card(
      key: ValueKey('disease-card-${item.id}'),
      margin: const EdgeInsets.only(top: 8),
      shape: RoundedRectangleBorder(
        borderRadius: cardBorderRadius,
        side: BorderSide(color: palette.hairline),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: cardBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: [
                  _DiseaseBadge(
                    category: DiseaseBadgeCategory.chronicity,
                    value: item.chronicity,
                    label: _chronicityLabel(l10n, item.chronicity),
                    palette: palette,
                  ),
                  _DiseaseBadge(
                    category: DiseaseBadgeCategory.infectious,
                    value: item.infectious.toString(),
                    label: item.infectious
                        ? l10n.searchDiseaseInfectiousTrue
                        : l10n.searchDiseaseInfectiousFalse,
                    palette: palette,
                  ),
                  for (final department in item.medicalDepartment)
                    _DiseaseBadge(
                      category: DiseaseBadgeCategory.department,
                      value: department,
                      label: _departmentLabel(l10n, department),
                      palette: palette,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              _DiseaseCardTitleRow(
                item: item,
                trailingTime: trailingTime,
              ),
              const SizedBox(height: 2),
              Text(
                item.nameKana,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 12,
                children: [
                  Text(
                    l10n.searchDiseaseMetaIcd10(
                      _diseaseIcd10ChapterLabel(l10n, item.icd10Chapter),
                    ),
                    style: theme.textTheme.labelSmall,
                  ),
                  Text(
                    l10n.searchDiseaseMetaRevised(
                      _formatRevisionDate(item.revisedAt),
                    ),
                    style: theme.textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiseaseCardTitleRow extends StatelessWidget {
  const _DiseaseCardTitleRow({
    required this.item,
    required this.trailingTime,
  });

  final DiseaseSummary item;
  final Widget? trailingTime;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      item.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
    );
    final trailing = trailingTime;
    if (trailing == null) {
      return title;
    }
    return Row(
      children: [
        Expanded(child: title),
        const SizedBox(width: 8),
        trailing,
      ],
    );
  }
}

class _DiseaseBadge extends StatelessWidget {
  const _DiseaseBadge({
    required this.category,
    required this.value,
    required this.label,
    required this.palette,
  });

  final DiseaseBadgeCategory category;
  final String value;
  final String label;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final colors = palette.diseaseBadgeColors(category, value);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

String _diseaseIcd10ChapterLabel(AppLocalizations l10n, String value) {
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

String _formatRevisionDate(String value) => value.replaceAll('-', '/');
