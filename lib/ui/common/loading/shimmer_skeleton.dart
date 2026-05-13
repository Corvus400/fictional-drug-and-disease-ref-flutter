import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Applies the app-standard shimmer skeleton effect to loading placeholders.
class ShimmerSkeleton extends StatelessWidget {
  /// Creates a shimmer skeleton wrapper.
  const ShimmerSkeleton({
    required this.child,
    this.enabled = true,
    super.key,
  });

  /// Placeholder content painted by Skeletonizer while [enabled] is true.
  final Widget child;

  /// Whether the shimmer skeleton effect is active.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);

    return Semantics(
      container: true,
      excludeSemantics: true,
      label: '読み込み中',
      liveRegion: true,
      child: Skeletonizer(
        effect: ShimmerEffect(
          baseColor: palette.surface2,
          highlightColor: palette.surface3,
        ),
        child: child,
      ),
    );
  }
}

/// Factory methods for common app loading placeholder shapes.
class ShimmerSkeletonShapes {
  const ShimmerSkeletonShapes._();

  /// Creates a detail-screen block placeholder.
  static Widget detailBlock({double height = 120}) {
    return Card(
      child: SizedBox(
        height: height,
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Bone.text(width: 160, fontSize: 16),
              SizedBox(height: 10),
              Bone.text(width: double.infinity),
              SizedBox(height: 6),
              Bone.text(width: 220, fontSize: 12),
              Spacer(),
              Row(
                children: [
                  Bone.button(width: 72, height: 20),
                  SizedBox(width: 8),
                  Bone.button(width: 96, height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a list-row placeholder.
  static Widget listRow({double height = 80}) {
    return Card(
      child: SizedBox(
        height: height,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Bone.circle(size: 44),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(width: 180, fontSize: 16),
                    SizedBox(height: 10),
                    Bone.text(width: 120, fontSize: 12),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Bone.icon(size: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a compact single-line bar placeholder.
  static Widget compactBar({double width = 64, double height = 12}) {
    return Bone(width: width, height: height, uniRadius: height / 2);
  }
}
