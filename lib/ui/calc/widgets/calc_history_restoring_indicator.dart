import 'package:fictional_drug_and_disease_ref/ui/common/loading/shimmer_skeleton.dart';
import 'package:flutter/material.dart';

/// Inline indicator shown while a calculation history row is restored.
class CalcHistoryRestoringIndicator extends StatelessWidget {
  /// Creates a restoring indicator.
  const CalcHistoryRestoringIndicator({
    required this.message,
    this.progressValue,
    super.key,
  });

  /// Localized restoring message.
  final String message;

  /// Optional deterministic progress value for static visual tests.
  final double? progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey<String>('calc-history-restoring-indicator'),
      height: 38,
      child: Center(
        child: ShimmerSkeleton(
          child: ShimmerSkeletonShapes.compactBar(width: 96, height: 16),
        ),
      ),
    );
  }
}
