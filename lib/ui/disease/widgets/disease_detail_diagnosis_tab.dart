import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Diagnosis tab for disease detail.
class DiseaseDetailDiagnosisTab extends StatefulWidget {
  /// Creates a diagnosis tab.
  const DiseaseDetailDiagnosisTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  State<DiseaseDetailDiagnosisTab> createState() =>
      _DiseaseDetailDiagnosisTabState();
}

class _DiseaseDetailDiagnosisTabState extends State<DiseaseDetailDiagnosisTab> {
  _DiagnosisInnerTab _activeTab = _DiagnosisInnerTab.criteria;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: DetailConstants.gapS,
          runSpacing: DetailConstants.gapS,
          children: [
            for (final tab in _DiagnosisInnerTab.values)
              ChoiceChip(
                label: Text(_diagnosisTabLabel(l10n, tab)),
                selected: _activeTab == tab,
                onSelected: (_) => setState(() => _activeTab = tab),
              ),
          ],
        ),
        const SizedBox(height: DetailConstants.gapS),
        AnimatedSwitcher(
          duration: DetailConstants.innerTabSwitchDuration,
          child: _diagnosisBody(l10n, widget.disease, _activeTab),
        ),
      ],
    );
  }
}

enum _DiagnosisInnerTab { criteria, exams, severity }

String _diagnosisTabLabel(AppLocalizations l10n, _DiagnosisInnerTab tab) {
  return switch (tab) {
    _DiagnosisInnerTab.criteria => l10n.detailDiseaseSectionDiagnosticCriteria,
    _DiagnosisInnerTab.exams => l10n.detailDiseaseSectionRequiredExams,
    _DiagnosisInnerTab.severity => l10n.detailDiseaseSectionSeverityGrading,
  };
}

Widget _diagnosisBody(
  AppLocalizations l10n,
  Disease disease,
  _DiagnosisInnerTab tab,
) {
  return switch (tab) {
    _DiagnosisInnerTab.criteria => Column(
      key: const ValueKey(_DiagnosisInnerTab.criteria),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.detailDiseaseSectionDiagnosticCriteria),
        for (final criterion in disease.diagnosticCriteria.required)
          Text(criterion),
      ],
    ),
    _DiagnosisInnerTab.exams => Column(
      key: const ValueKey(_DiagnosisInnerTab.exams),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final exam in disease.requiredExams) Text(exam.name),
      ],
    ),
    _DiagnosisInnerTab.severity => Column(
      key: const ValueKey(_DiagnosisInnerTab.severity),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (disease.severityGrading != null)
          Text(disease.severityGrading!.gradingSystem),
      ],
    ),
  };
}
