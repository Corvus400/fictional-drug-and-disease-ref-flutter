import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_badge.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_severity_grade.dart';
import 'package:flutter/material.dart';

/// Diagnosis tab for disease detail.
class DiseaseDetailDiagnosisTab extends StatelessWidget {
  /// Creates a diagnosis tab.
  const DiseaseDetailDiagnosisTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'E6',
          title: l10n.detailDiseaseSectionEtiology,
          child: _BodyText(disease.etiology),
        ),
        DetailPanel(
          sectionIndex: 'E7',
          title: l10n.detailDiseaseSectionSymptoms,
          subtitle:
              '${l10n.detailDiseaseSectionMainSymptoms} / '
              '${l10n.detailDiseaseSectionAssociatedSymptoms} / '
              '${l10n.detailDiseaseSectionOnsetPattern}',
          child: _SymptomsBody(disease: disease, l10n: l10n),
        ),
        DetailPanel(
          sectionIndex: 'E8',
          title: l10n.detailDiseaseSectionDiagnosticCriteria,
          child: _DiagnosticCriteriaBody(disease: disease, l10n: l10n),
        ),
        DetailPanel(
          sectionIndex: 'E9',
          title: l10n.detailDiseaseSectionRequiredExams,
          child: DetailExamTable(
            rows: [
              for (final exam in disease.requiredExams)
                DetailExamRow(
                  name: exam.name,
                  category: _examCategoryLabel(l10n, exam.category),
                  finding: exam.typicalFinding,
                ),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'E10',
          title: l10n.detailDiseaseSectionSeverityGrading,
          subtitle: disease.severityGrading == null
              ? null
              : '${l10n.detailDiseaseSectionGradingSystem}: '
                    '${disease.severityGrading!.gradingSystem}',
          showBottomDivider: false,
          child: _SeverityBody(disease: disease),
        ),
      ],
    );
  }
}

class _SymptomsBody extends StatelessWidget {
  const _SymptomsBody({required this.disease, required this.l10n});

  final Disease disease;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final onsetPattern = disease.symptoms.onsetPattern;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailBadgeWrap(
          children: [
            for (final symptom in disease.symptoms.mainSymptoms)
              DetailBadge(label: symptom),
            for (final symptom in disease.symptoms.associatedSymptoms)
              DetailBadge(label: symptom, tone: DetailBadgeTone.outline),
          ],
        ),
        if (onsetPattern != null) ...[
          const SizedBox(height: DetailConstants.gapS),
          _MutedText(
            '${l10n.detailDiseaseSectionOnsetPattern}: '
            '${_onsetPatternLabel(l10n, onsetPattern)}',
          ),
        ],
      ],
    );
  }
}

class _DiagnosticCriteriaBody extends StatelessWidget {
  const _DiagnosticCriteriaBody({required this.disease, required this.l10n});

  final Disease disease;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final criteria = disease.diagnosticCriteria;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NumberedTextList(
          items: [
            for (final criterion in criteria.required)
              '${l10n.detailDiseaseSectionRequired}: $criterion',
          ],
        ),
        if (criteria.supporting.isNotEmpty) ...[
          const SizedBox(height: DetailConstants.gapS),
          _MutedText(l10n.detailDiseaseSectionSupporting),
          const SizedBox(height: DetailConstants.gapXs),
          for (final supporting in criteria.supporting) _BodyText(supporting),
        ],
        if (criteria.notes != null) ...[
          const SizedBox(height: DetailConstants.gapS),
          _MutedText(l10n.detailDiseaseSectionNotes),
          const SizedBox(height: DetailConstants.gapXs),
          _BodyText(criteria.notes!),
        ],
      ],
    );
  }
}

class _SeverityBody extends StatelessWidget {
  const _SeverityBody({required this.disease});

  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final grading = disease.severityGrading;
    if (grading == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, grade) in grading.grades.indexed)
          DetailSeverityGrade(
            label: grade.label,
            criteria: grade.criteria,
            recommendedAction: grade.recommendedAction,
            isFirst: index == 0,
          ),
      ],
    );
  }
}

class _NumberedTextList extends StatelessWidget {
  const _NumberedTextList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, item) in items.indexed)
          _NumberedText(index: index + 1, text: item),
      ],
    );
  }
}

class _NumberedText extends StatelessWidget {
  const _NumberedText({required this.index, required this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index. ',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: DetailConstants.kvFontSize,
              fontWeight: FontWeight.w700,
              height: DetailConstants.bodyTextLineHeight,
            ),
          ),
          Expanded(child: _BodyText(text)),
        ],
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      text,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: DetailConstants.kvFontSize,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
  }
}

class _MutedText extends StatelessWidget {
  const _MutedText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return Text(
      text,
      style: TextStyle(
        color: colors.onSurfaceVariant,
        fontSize: DetailConstants.kvFontSize,
        height: DetailConstants.bodyTextLineHeight,
      ),
    );
  }
}

String _onsetPatternLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'acute' => l10n.searchDiseaseOnsetPatternAcute,
    'subacute' => l10n.searchDiseaseOnsetPatternSubacute,
    'chronic' => l10n.searchDiseaseOnsetPatternChronic,
    'intermittent' => l10n.searchDiseaseOnsetPatternIntermittent,
    'relapsing' => l10n.searchDiseaseOnsetPatternRelapsing,
    _ => value,
  };
}

String _examCategoryLabel(AppLocalizations l10n, String value) {
  return switch (value) {
    'blood_test' => l10n.searchDiseaseExamCategoryBloodTest,
    'imaging' => l10n.searchDiseaseExamCategoryImaging,
    'physiological' => l10n.searchDiseaseExamCategoryPhysiological,
    'pathology' => l10n.searchDiseaseExamCategoryPathology,
    'interview' => l10n.searchDiseaseExamCategoryInterview,
    _ => value,
  };
}
