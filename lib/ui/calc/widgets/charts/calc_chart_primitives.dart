import 'dart:math' as math;

import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

@immutable
/// Colored segment in a calc band chart.
final class CalcBandSegment {
  /// Creates a band segment.
  const CalcBandSegment({
    required this.key,
    required this.label,
    required this.background,
    required this.foreground,
    required this.flex,
  });

  /// Stable key suffix.
  final String key;

  /// Segment label.
  final String label;

  /// Segment background color.
  final Color background;

  /// Segment foreground color.
  final Color foreground;

  /// Flex width.
  final int flex;
}

@immutable
/// Axis tick in a calc band chart.
final class CalcAxisTick {
  /// Creates an axis tick.
  const CalcAxisTick({required this.label, required this.position});

  /// Tick label.
  final String label;

  /// Tick position from 0 to 1.
  final double position;
}

/// Shared segmented number-line chart primitive.
class CalcBandChart extends StatelessWidget {
  /// Creates a band chart.
  const CalcBandChart({
    required this.chartKeyPrefix,
    required this.segments,
    required this.ticks,
    required this.markerPosition,
    required this.markerLabel,
    super.key,
  });

  /// Key prefix for test finders.
  final String chartKeyPrefix;

  /// Band segments.
  final List<CalcBandSegment> segments;

  /// Axis ticks.
  final List<CalcAxisTick> ticks;

  /// Marker position from 0 to 1.
  final double markerPosition;

  /// Marker pin label.
  final String markerLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final markerLeft = width * markerPosition.clamp(0, 1);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: _ScaleBand(
                  chartKeyPrefix: chartKeyPrefix,
                  segments: segments,
                ),
              ),
              Positioned(
                left: markerLeft,
                top: -4,
                child: _ChartMarker(
                  keyPrefix: chartKeyPrefix,
                  label: markerLabel,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 28,
                child: _AxisTicks(ticks: ticks),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ScaleBand extends StatelessWidget {
  const _ScaleBand({required this.chartKeyPrefix, required this.segments});

  final String chartKeyPrefix;
  final List<CalcBandSegment> segments;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: palette.calcHairline),
        borderRadius: BorderRadius.circular(radii.tile),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radii.tile),
        child: SizedBox(
          height: 24,
          child: Row(
            children: [
              for (final segment in segments)
                Expanded(
                  flex: segment.flex,
                  child: ColoredBox(
                    key: ValueKey<String>(
                      '$chartKeyPrefix-chart-segment-${segment.key}',
                    ),
                    color: segment.background,
                    child: Center(
                      child: Text(
                        segment.label,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: typography.monoS.copyWith(
                          color: segment.foreground,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChartMarker extends StatelessWidget {
  const _ChartMarker({required this.keyPrefix, required this.label});

  final String keyPrefix;
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return FractionalTranslation(
      translation: const Offset(-0.5, 0),
      child: SizedBox(
        width: math.max(34, label.length * 8),
        height: 54,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -22,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.calcInk,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  child: Text(
                    label,
                    style: typography.monoS.copyWith(
                      color: palette.calcSurface,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.calcInk,
                  border: Border.all(color: palette.calcSurface, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const SizedBox(width: 10, height: 10),
              ),
            ),
            Positioned(
              top: 0,
              child: ColoredBox(
                key: ValueKey<String>('$keyPrefix-chart-marker'),
                color: palette.calcInk,
                child: const SizedBox(width: 2, height: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AxisTicks extends StatelessWidget {
  const _AxisTicks({required this.ticks});

  final List<CalcAxisTick> ticks;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return SizedBox(
      height: 16,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (final tick in ticks)
                Positioned(
                  left: constraints.maxWidth * tick.position.clamp(0, 1),
                  top: 0,
                  child: FractionalTranslation(
                    translation: const Offset(-0.5, 0),
                    child: Text(
                      tick.label,
                      style: typography.monoS.copyWith(
                        color: palette.calcMuted,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// CrCl age group row primitive.
class CalcCrClRow extends StatelessWidget {
  /// Creates a CrCl row.
  const CalcCrClRow({
    required this.groupKey,
    required this.label,
    required this.normalLeft,
    required this.normalRight,
    required this.markerLeft,
    super.key,
  });

  /// Stable group key suffix.
  final String groupKey;

  /// Visible group label.
  final String label;

  /// Normal range left offset from 0 to 1.
  final double normalLeft;

  /// Normal range right offset from 0 to 1.
  final double normalRight;

  /// Patient marker left offset from 0 to 1.
  final double markerLeft;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return KeyedSubtree(
      key: ValueKey<String>('crcl-chart-row-$groupKey'),
      child: SizedBox(
        height: 14,
        child: Row(
          children: [
            SizedBox(
              width: 96,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: typography.monoS.copyWith(
                  color: palette.calcMuted,
                  fontFamilyFallback: const ['NotoSansJP'],
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 14,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: palette.calcSurface3,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const SizedBox(height: 14),
                          ),
                        ),
                        Positioned(
                          key: ValueKey<String>('crcl-chart-normal-$groupKey'),
                          left: constraints.maxWidth * normalLeft.clamp(0, 1),
                          right: constraints.maxWidth * normalRight.clamp(0, 1),
                          top: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: palette.calcSuccessContainer,
                              border: Border.all(color: palette.calcSuccess),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const SizedBox(height: 14),
                          ),
                        ),
                        Positioned(
                          key: ValueKey<String>('crcl-chart-marker-$groupKey'),
                          left: constraints.maxWidth * markerLeft.clamp(0, 1),
                          top: -3,
                          child: FractionalTranslation(
                            translation: const Offset(-0.5, 0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: palette.calcPrimary,
                                border: Border.all(
                                  color: palette.calcSurface,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const SizedBox(width: 14, height: 20),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
