import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

/// Markdown body styled to match detail screen body text.
class DetailMarkdownBody extends StatelessWidget {
  /// Creates a detail markdown body.
  const DetailMarkdownBody({
    required this.data,
    this.emphasized = false,
    this.color,
    this.fontSize,
    this.height,
    super.key,
  });

  /// CommonMark/GFM markdown text.
  final String data;

  /// Whether the paragraph base style is bold.
  final bool emphasized;

  /// Optional text color override.
  final Color? color;

  /// Optional font size override.
  final double? fontSize;

  /// Optional line-height override.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<DetailColorExtension>()!;
    final baseStyle = TextStyle(
      color: color ?? colors.onSurface,
      fontSize: fontSize ?? DetailConstants.kvFontSize,
      fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
      height: height ?? DetailConstants.bodyTextLineHeight,
    );
    return MarkdownBody(
      key: const ValueKey<String>('detail-markdown-body'),
      data: data,
      softLineBreak: true,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: baseStyle,
        pPadding: EdgeInsets.zero,
        strong: baseStyle.copyWith(fontWeight: FontWeight.w700),
        em: baseStyle.copyWith(fontStyle: FontStyle.italic),
        listBullet: baseStyle,
        listIndent: DetailConstants.contentPadding,
        blockSpacing: DetailConstants.gapXs,
        h1: baseStyle.copyWith(fontWeight: FontWeight.w700),
        h2: baseStyle.copyWith(fontWeight: FontWeight.w700),
        h3: baseStyle.copyWith(fontWeight: FontWeight.w700),
        h4: baseStyle.copyWith(fontWeight: FontWeight.w700),
        h5: baseStyle.copyWith(fontWeight: FontWeight.w700),
        h6: baseStyle.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}
