import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_kv_row.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';

/// Treatment tab for disease detail.
class DiseaseDetailTreatmentTab extends StatefulWidget {
  /// Creates a treatment tab.
  const DiseaseDetailTreatmentTab({required this.disease, super.key});

  /// Disease detail model.
  final Disease disease;

  @override
  State<DiseaseDetailTreatmentTab> createState() =>
      _DiseaseDetailTreatmentTabState();
}

class _DiseaseDetailTreatmentTabState extends State<DiseaseDetailTreatmentTab> {
  late _TreatmentInnerTab _activeTab = _initialTab(widget.disease);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final disease = widget.disease;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'E11',
          title:
              '${l10n.detailDiseaseSectionDifferentialDiagnoses}・'
              '${l10n.detailDiseaseSectionComplications}',
          child: Column(
            children: [
              DetailKvRow(
                label: l10n.detailDiseaseSectionDifferentialDiagnoses,
                value: disease.differentialDiagnoses.join('、'),
                showTopBorder: true,
              ),
              DetailKvRow(
                label: l10n.detailDiseaseSectionComplications,
                value: disease.complications.join('、'),
              ),
            ],
          ),
        ),
        DetailPanel(
          sectionIndex: 'E12',
          title: l10n.detailDiseaseSectionTreatments,
          showBottomDivider: false,
          child: DefaultTabController(
            length: _TreatmentInnerTab.values.length,
            initialIndex: _TreatmentInnerTab.values.indexOf(_activeTab),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TreatmentInnerTabBar(
                  activeTab: _activeTab,
                  onSelected: (tab) => setState(() => _activeTab = tab),
                ),
                const SizedBox(height: DetailConstants.gapS),
                AnimatedSwitcher(
                  duration: DetailConstants.innerTabSwitchDuration,
                  child: _treatmentBody(l10n, disease, _activeTab),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum _TreatmentInnerTab { pharmacological, nonPharmacological, acutePhase }

class _TreatmentInnerTabBar extends StatelessWidget {
  const _TreatmentInnerTabBar({
    required this.activeTab,
    required this.onSelected,
  });

  final _TreatmentInnerTab activeTab;
  final ValueChanged<_TreatmentInnerTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    return TabBar(
      key: const ValueKey<String>('disease-detail-treatment-inner-tabs'),
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelColor: colors.primary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicatorColor: colors.primary,
      dividerColor: colors.outlineVariant,
      labelStyle: const TextStyle(
        fontSize: DetailConstants.kvFontSize,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: DetailConstants.kvFontSize,
        fontWeight: FontWeight.w600,
      ),
      onTap: (index) => onSelected(_TreatmentInnerTab.values[index]),
      tabs: [
        for (final tab in _TreatmentInnerTab.values)
          Tab(text: _treatmentTabLabel(l10n, tab)),
      ],
    );
  }
}

Widget _treatmentBody(
  AppLocalizations l10n,
  Disease disease,
  _TreatmentInnerTab tab,
) {
  return switch (tab) {
    _TreatmentInnerTab.pharmacological => DetailExamTable(
      key: const ValueKey<_TreatmentInnerTab>(
        _TreatmentInnerTab.pharmacological,
      ),
      nameHeader: '分類',
      categoryHeader: '適応',
      findingHeader: '備考',
      rows: [
        for (final item in disease.treatments.pharmacological)
          DetailExamRow(
            name: item.drugCategory,
            category: item.indication,
            finding: item.notes,
          ),
      ],
    ),
    _TreatmentInnerTab.nonPharmacological => DetailExamTable(
      key: const ValueKey<_TreatmentInnerTab>(
        _TreatmentInnerTab.nonPharmacological,
      ),
      nameHeader: '方針',
      categoryHeader: '内容',
      findingHeader: '説明',
      rows: [
        for (final item in disease.treatments.nonPharmacological)
          DetailExamRow(
            name: item.heading,
            category: item.items.join('、'),
            finding: item.description ?? '',
          ),
      ],
    ),
    _TreatmentInnerTab.acutePhase => DetailExamTable(
      key: const ValueKey<_TreatmentInnerTab>(_TreatmentInnerTab.acutePhase),
      nameHeader: '順序',
      categoryHeader: '対応',
      findingHeader: '目標',
      rows: [
        for (final item in disease.treatments.acutePhaseProtocol)
          DetailExamRow(
            name: item.order.toString(),
            category: item.action,
            finding: item.target ?? '',
          ),
      ],
    ),
  };
}

_TreatmentInnerTab _initialTab(Disease disease) {
  if (disease.treatments.pharmacological.isNotEmpty) {
    return _TreatmentInnerTab.pharmacological;
  }
  if (disease.treatments.nonPharmacological.isNotEmpty) {
    return _TreatmentInnerTab.nonPharmacological;
  }
  return _TreatmentInnerTab.acutePhase;
}

String _treatmentTabLabel(AppLocalizations l10n, _TreatmentInnerTab tab) {
  return switch (tab) {
    _TreatmentInnerTab.pharmacological =>
      l10n.detailDiseaseSectionPharmacological,
    _TreatmentInnerTab.nonPharmacological =>
      l10n.detailDiseaseSectionNonPharmacological,
    _TreatmentInnerTab.acutePhase =>
      l10n.detailDiseaseSectionAcutePhaseProtocol,
  };
}
