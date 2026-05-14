// Preview entrypoints must stay public for Flutter Widget Previewer.
// ignore_for_file: public_member_api_docs

import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:fictional_drug_and_disease_ref/ui/common/loading/shimmer_skeleton.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_data.dart';
import 'package:fictional_drug_and_disease_ref/ui/previews/preview_support.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_tab_header.dart';
import 'package:flutter/material.dart';

@FddComponentPreview(group: 'Common', name: 'Drug result card')
Widget previewCommonDrugResultCard() {
  return const DrugResultCard(
    item: previewDrugSummary,
    cacheManager: previewFailingCacheManager,
    logImageErrors: false,
  );
}

@FddComponentPreview(group: 'Common', name: 'Disease result card')
Widget previewCommonDiseaseResultCard() {
  return const DiseaseResultCard(item: previewDiseaseSummary);
}

@FddComponentPreview(group: 'Common', name: 'Loading skeletons')
Widget previewCommonShimmerSkeletons() {
  return ShimmerSkeleton(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShimmerSkeletonShapes.listRow(),
        const SizedBox(height: 12),
        ShimmerSkeletonShapes.detailBlock(),
        const SizedBox(height: 12),
        ShimmerSkeletonShapes.compactBar(width: 160, height: 16),
      ],
    ),
  );
}

@FddComponentPreview(group: 'Shell', name: 'Disclaimer ribbon')
Widget previewShellDisclaimerRibbon() {
  return const DisclaimerRibbon();
}

@FddComponentPreview(group: 'Shell', name: 'Tab header')
Widget previewShellTabHeader() {
  return const SizedBox(
    height: 72,
    child: Scaffold(
      appBar: AppTabHeader(tab: AppShellTab.search),
      body: SizedBox.shrink(),
    ),
  );
}

@FddComponentPreview(group: 'Shell', name: 'Bottom navigation')
Widget previewShellBottomNavigation() {
  return AppShellBottomNavigation(
    selectedIndex: 1,
    onDestinationSelected: (_) {},
  );
}
