import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_expand_tile.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_markdown_body.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:go_router/go_router.dart';

final FutureProviderFamily<Disease, String> _relatedDiseaseProvider =
    FutureProvider.autoDispose.family<Disease, String>((ref, id) async {
      final result = await ref.watch(diseaseRepositoryProvider).getDisease(id);
      return switch (result) {
        Ok<Disease>(:final value) => value,
        Err<Disease>(:final error) => throw error,
      };
    });

/// Related diseases tab for drug detail.
class DrugDetailRelatedTab extends StatelessWidget {
  /// Creates a related diseases tab.
  const DrugDetailRelatedTab({required this.drug, super.key});

  /// Drug detail model.
  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailPanel(
          sectionIndex: 'D16',
          title: l10n.detailDrugSectionHandlingPackagesInsurance,
          child: _PackageTable(packages: drug.packages),
        ),
        DetailPanel(
          sectionIndex: 'D17',
          title: l10n.detailDrugSectionApprovalReferences,
          child: _ApprovalAndReferenceBody(drug: drug),
        ),
        DetailPanel(
          sectionIndex: 'D18',
          title: l10n.detailDrugSectionRelatedDiseases,
          showBottomDivider: false,
          child: DetailCarousel(
            children: [
              for (final id in drug.relatedDiseaseIds)
                _RelatedDiseaseCard(id: id),
            ],
          ),
        ),
      ],
    );
  }
}

class _PackageTable extends StatelessWidget {
  const _PackageTable({required this.packages});

  final List<PackageInfo> packages;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DetailExamTable(
      nameHeader: l10n.detailDrugPackageSizeHeader,
      categoryHeader: l10n.detailDrugPackageStorageHeader,
      findingHeader: l10n.detailDrugPackageExpirationHeader,
      categoryAsPill: false,
      rows: [
        for (final package in packages)
          DetailExamRow(
            name: package.size,
            category: _storageConditionLabel(l10n, package.storageCondition),
            finding:
                '${package.expirationMonths} '
                '${l10n.detailDrugExpirationMonthsSuffix}',
          ),
      ],
    );
  }
}

String _storageConditionLabel(
  AppLocalizations l10n,
  StorageCondition condition,
) {
  final values = <String>[
    _storageTemperatureLabel(l10n, condition.temperature),
  ];
  if (condition.lightProtection) {
    values.add(l10n.detailDrugStorageLightProtection);
  }
  if (condition.moistureProtection) {
    values.add(l10n.detailDrugStorageMoistureProtection);
  }
  if (condition.additionalNote != null) {
    values.add(condition.additionalNote!);
  }
  return values.join('・');
}

String _storageTemperatureLabel(AppLocalizations l10n, String temperature) {
  return switch (temperature) {
    'room_temperature' => l10n.detailDrugStorageRoomTemperature,
    'cold' => l10n.detailDrugStorageCold,
    'frozen' => l10n.detailDrugStorageFrozen,
    _ => temperature,
  };
}

class _ApprovalAndReferenceBody extends StatelessWidget {
  const _ApprovalAndReferenceBody({required this.drug});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NumberedParagraphList(items: drug.approvalConditions),
        if (drug.references.isNotEmpty) ...[
          const SizedBox(height: DetailConstants.gapS),
          for (final (index, reference) in drug.references.indexed)
            DetailExpandTile(
              title: '${index + 1}. ${reference.citation}',
              body: reference.source ?? reference.citation,
              initiallyExpanded: index == 0,
            ),
        ],
      ],
    );
  }
}

class _NumberedParagraphList extends StatelessWidget {
  const _NumberedParagraphList({required this.items});

  final List<NumberedParagraph> items;

  @override
  Widget build(BuildContext context) {
    final sorted = [...items]
      ..sort((a, b) {
        final order = a.order.compareTo(b.order);
        if (order != 0) {
          return order;
        }
        return (a.subOrder ?? 0).compareTo(b.subOrder ?? 0);
      });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in sorted)
          _NumberedMarkdownParagraph(index: _paragraphIndex(item), item: item),
      ],
    );
  }
}

String _paragraphIndex(NumberedParagraph item) {
  if (item.subOrder == null) {
    return item.order.toString();
  }
  return '${item.order}.${item.subOrder}';
}

class _NumberedMarkdownParagraph extends StatelessWidget {
  const _NumberedMarkdownParagraph({required this.index, required this.item});

  final String index;
  final NumberedParagraph item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DetailConstants.gapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$index. '),
          Expanded(child: DetailMarkdownBody(data: item.content)),
        ],
      ),
    );
  }
}

class _RelatedDiseaseCard extends ConsumerWidget {
  const _RelatedDiseaseCard({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final disease = ref.watch(_relatedDiseaseProvider(id));
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.push(AppRoutes.diseaseDetail(id)),
      child: disease.when(
        data: (disease) => DetailCarouselCard(
          title: disease.name,
          subtitle: disease.id,
          badges: [_chronicityLabel(l10n, disease.chronicity)],
        ),
        loading: () => DetailCarouselCard(
          title: id,
          subtitle: l10n.detailDrugSectionRelatedDiseases,
        ),
        error: (_, _) => DetailCarouselCard(
          title: id,
          subtitle: l10n.detailDrugSectionRelatedDiseases,
        ),
      ),
    );
  }
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
