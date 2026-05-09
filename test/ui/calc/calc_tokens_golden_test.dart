import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';

import '../../golden/golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'calc_tokens_swatch',
    description: 'Calc design tokens render consistently',
    sizes: const ['phone'],
    textScalers: const ['normal'],
    builder: (theme, size, scaler) => MaterialApp(
      theme: theme,
      home: const _CalcTokensSwatch(),
    ),
  );
}

class _CalcTokensSwatch extends StatelessWidget {
  const _CalcTokensSwatch();

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Scaffold(
      backgroundColor: palette.calcBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(spacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Calc Tokens',
                style: typography.titleL.copyWith(color: palette.calcInk),
              ),
              SizedBox(height: spacing.s4),
              Wrap(
                spacing: spacing.s2,
                runSpacing: spacing.s2,
                children: [
                  _ColorSwatch(label: 'bg', color: palette.calcBg),
                  _ColorSwatch(label: 'surface', color: palette.calcSurface),
                  _ColorSwatch(label: 'surface2', color: palette.calcSurface2),
                  _ColorSwatch(label: 'surface3', color: palette.calcSurface3),
                  _ColorSwatch(label: 'surface4', color: palette.calcSurface4),
                  _ColorSwatch(label: 'ink', color: palette.calcInk),
                  _ColorSwatch(label: 'ink2', color: palette.calcInk2),
                  _ColorSwatch(label: 'muted', color: palette.calcMuted),
                  _ColorSwatch(label: 'primary', color: palette.calcPrimary),
                  _ColorSwatch(label: 'error', color: palette.calcError),
                  _ColorSwatch(label: 'warn', color: palette.calcWarn),
                  _ColorSwatch(label: 'success', color: palette.calcSuccess),
                  _ColorSwatch(label: 'ribbon', color: palette.calcRibbonBg),
                  _ColorSwatch(
                    label: 'accent',
                    color: palette.calcRibbonAccent,
                  ),
                ],
              ),
              SizedBox(height: spacing.s5),
              Text(
                'Typography',
                style: typography.labelM.copyWith(color: palette.calcMuted),
              ),
              SizedBox(height: spacing.s2),
              Text(
                'display-l / 34',
                style: typography.displayL.copyWith(color: palette.calcInk),
              ),
              Text(
                'title-m / 16',
                style: typography.titleM.copyWith(color: palette.calcInk2),
              ),
              Text(
                'body-m / 14 すべての項目を入力してください',
                style: typography.bodyM.copyWith(color: palette.calcInk),
              ),
              Text(
                'mono-s / 11 22.5 kg/m²',
                style: typography.monoS.copyWith(color: palette.calcMuted),
              ),
              SizedBox(height: spacing.s5),
              Text(
                'Radii',
                style: typography.labelM.copyWith(color: palette.calcMuted),
              ),
              SizedBox(height: spacing.s2),
              Row(
                children: [
                  _RadiusBox(label: 'badge', radius: radii.badge),
                  SizedBox(width: spacing.s2),
                  _RadiusBox(label: 'tile', radius: radii.tile),
                  SizedBox(width: spacing.s2),
                  _RadiusBox(label: 'card', radius: radii.card),
                  SizedBox(width: spacing.s2),
                  _RadiusBox(label: 'pill', radius: radii.pill),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;

    return Container(
      width: 82,
      height: 54,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radii.tile),
        border: Border.all(color: palette.calcHairline),
      ),
      child: Text(
        label,
        style: typography.monoS.copyWith(
          color: _readableOn(color),
          fontSize: 10,
        ),
      ),
    );
  }
}

class _RadiusBox extends StatelessWidget {
  const _RadiusBox({required this.label, required this.radius});

  final String label;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;

    return Expanded(
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: palette.calcPrimarySoft,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: palette.calcPrimaryRing),
        ),
        child: Text(
          '$label\n${radius.toStringAsFixed(0)}',
          textAlign: TextAlign.center,
          style: typography.monoS.copyWith(color: palette.calcInk),
        ),
      ),
    );
  }
}

Color _readableOn(Color color) {
  return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}
