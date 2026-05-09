import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:flutter/material.dart';

/// App-wide fixed disclaimer ribbon.
class DisclaimerRibbon extends StatelessWidget {
  /// Creates a disclaimer ribbon.
  const DisclaimerRibbon({super.key});

  static const _semanticsLabel = '免責: 架空データ・医療判断には使用しないでください';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).extension<AppPalette>()!;
    final height = _heightFor(MediaQuery.sizeOf(context));
    final segments = l10n.detailDisclaimer.split(' / ');

    return SizedBox(
      height: height,
      width: double.infinity,
      child: IgnorePointer(
        child: Semantics(
          label: _semanticsLabel,
          liveRegion: false,
          child: Container(
            height: height,
            decoration: BoxDecoration(color: palette.calcRibbonBg),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _AccentDot(color: palette.calcRibbonAccent),
                const SizedBox(width: 10),
                _RibbonText(
                  text: segments.first,
                  color: palette.calcRibbonFg,
                  fontSize: _fontSizeFor(height),
                ),
                const SizedBox(width: 10),
                _AccentDot(color: palette.calcRibbonAccent),
                const SizedBox(width: 10),
                _RibbonText(
                  text: segments.length > 1
                      ? segments.sublist(1).join(' / ')
                      : '',
                  color: palette.calcRibbonFg,
                  fontSize: _fontSizeFor(height),
                ),
                const SizedBox(width: 10),
                _AccentDot(color: palette.calcRibbonAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _heightFor(Size size) {
    if (size.width >= 600 && size.height >= 600) {
      return 28;
    }
    if (size.width > size.height && size.height < 480) {
      return 22;
    }
    return 26;
  }

  double _fontSizeFor(double height) => height <= 22 ? 9 : 11;
}

class _RibbonText extends StatelessWidget {
  const _RibbonText({
    required this.text,
    required this.color,
    required this.fontSize,
  });

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: color,
            fontFamily: 'NotoSansJP',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            fontVariations: const [FontVariation('wght', 700)],
            height: 1,
            letterSpacing: 0.44,
          ),
        ),
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '·',
      style: TextStyle(
        color: color,
        fontFamily: 'NotoSansJP',
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    );
  }
}
