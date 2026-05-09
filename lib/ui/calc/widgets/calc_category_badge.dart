import 'package:fictional_drug_and_disease_ref/domain/calc/bmi.dart';
import 'package:fictional_drug_and_disease_ref/domain/calc/egfr.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Classification badge atom for BMI and CKD categories.
class CalcCategoryBadge extends StatelessWidget {
  /// Creates a BMI classification badge.
  const CalcCategoryBadge.bmi({
    required BmiCategory category,
    required this.label,
    super.key,
  }) : _bmiCategory = category,
       _ckdStage = null;

  /// Creates a CKD stage badge.
  const CalcCategoryBadge.ckd({
    required CkdStage stage,
    required this.label,
    super.key,
  }) : _bmiCategory = null,
       _ckdStage = stage;

  final BmiCategory? _bmiCategory;
  final CkdStage? _ckdStage;

  /// Badge label.
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final colors = _palette(palette);
    final shape = _shape;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(radii.pill),
        border: Border.all(color: Colors.transparent),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 26),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BadgeShapeMark(shape: shape, color: colors.fg),
              SizedBox(width: spacing.s1 + 2),
              Text(
                label,
                style: typography.labelS.copyWith(
                  color: colors.fg,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CalcCategoryPaletteToken _palette(AppPalette palette) {
    final bmiCategory = _bmiCategory;
    if (bmiCategory != null) {
      return palette.calcBmiCategoryPalette[_bmiToken(bmiCategory)]!;
    }
    return palette.calcCkdStagePalette[_ckdToken(_ckdStage!)]!;
  }

  _BadgeShape get _shape {
    final bmiCategory = _bmiCategory;
    if (bmiCategory != null) {
      return switch (bmiCategory) {
        BmiCategory.underweight => _BadgeShape.dot,
        BmiCategory.normal => _BadgeShape.triangle,
        BmiCategory.overweight => _BadgeShape.square,
        BmiCategory.obese1 => _BadgeShape.diamond,
        BmiCategory.obese2 => _BadgeShape.pentagon,
        BmiCategory.obese3 => _BadgeShape.hexagon,
        BmiCategory.obese4 => _BadgeShape.x,
      };
    }
    return switch (_ckdStage!) {
      CkdStage.g1 => _BadgeShape.dot,
      CkdStage.g2 => _BadgeShape.triangle,
      CkdStage.g3a => _BadgeShape.square,
      CkdStage.g3b => _BadgeShape.diamond,
      CkdStage.g4 => _BadgeShape.hexagon,
      CkdStage.g5 => _BadgeShape.x,
    };
  }

  CalcBmiCategoryToken _bmiToken(BmiCategory category) {
    return switch (category) {
      BmiCategory.underweight => CalcBmiCategoryToken.underweight,
      BmiCategory.normal => CalcBmiCategoryToken.normal,
      BmiCategory.overweight => CalcBmiCategoryToken.overweight,
      BmiCategory.obese1 => CalcBmiCategoryToken.obese1,
      BmiCategory.obese2 => CalcBmiCategoryToken.obese2,
      BmiCategory.obese3 => CalcBmiCategoryToken.obese3,
      BmiCategory.obese4 => CalcBmiCategoryToken.obese4,
    };
  }

  CalcCkdStageToken _ckdToken(CkdStage stage) {
    return switch (stage) {
      CkdStage.g1 => CalcCkdStageToken.g1,
      CkdStage.g2 => CalcCkdStageToken.g2,
      CkdStage.g3a => CalcCkdStageToken.g3a,
      CkdStage.g3b => CalcCkdStageToken.g3b,
      CkdStage.g4 => CalcCkdStageToken.g4,
      CkdStage.g5 => CalcCkdStageToken.g5,
    };
  }
}

enum _BadgeShape { dot, triangle, square, diamond, pentagon, hexagon, x }

class _BadgeShapeMark extends StatelessWidget {
  const _BadgeShapeMark({required this.shape, required this.color});

  final _BadgeShape shape;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: ValueKey<String>('calc-badge-shape-${shape.name}'),
      size: const Size.square(10),
      painter: _BadgeShapePainter(shape: shape, color: color),
    );
  }
}

class _BadgeShapePainter extends CustomPainter {
  const _BadgeShapePainter({required this.shape, required this.color});

  final _BadgeShape shape;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    switch (shape) {
      case _BadgeShape.dot:
        canvas.drawOval(Offset.zero & size, paint);
      case _BadgeShape.triangle:
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, paint);
      case _BadgeShape.square:
        canvas.drawRRect(
          RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(1)),
          paint,
        );
      case _BadgeShape.diamond:
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
        canvas.drawPath(path, paint);
      case _BadgeShape.pentagon:
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height * 0.38)
          ..lineTo(size.width * 0.82, size.height)
          ..lineTo(size.width * 0.18, size.height)
          ..lineTo(0, size.height * 0.38)
          ..close();
        canvas.drawPath(path, paint);
      case _BadgeShape.hexagon:
        final path = Path()
          ..moveTo(size.width * 0.25, 0)
          ..lineTo(size.width * 0.75, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width * 0.75, size.height)
          ..lineTo(size.width * 0.25, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
        canvas.drawPath(path, paint);
      case _BadgeShape.x:
        final stroke = Paint()
          ..color = color
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;
        canvas
          ..drawLine(Offset.zero, Offset(size.width, size.height), stroke)
          ..drawLine(Offset(size.width, 0), Offset(0, size.height), stroke);
    }
  }

  @override
  bool shouldRepaint(_BadgeShapePainter oldDelegate) {
    return oldDelegate.shape != shape || oldDelegate.color != color;
  }
}
