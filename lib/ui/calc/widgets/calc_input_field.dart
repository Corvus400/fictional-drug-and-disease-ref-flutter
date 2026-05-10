import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_radii.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Calc form input atom backed by the platform text input.
class CalcInputField extends StatefulWidget {
  /// Creates a calc input field.
  const CalcInputField({
    required this.label,
    required this.unit,
    this.valueText,
    this.placeholder = '--',
    this.errorText,
    this.focused = false,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
    this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    super.key,
  });

  /// Field label.
  final String label;

  /// Current value text.
  final String? valueText;

  /// Placeholder text when [valueText] is empty.
  final String placeholder;

  /// Unit suffix.
  final String unit;

  /// Error text.
  final String? errorText;

  /// Whether the field is visually focused.
  final bool focused;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Optional focus node used by parent forms to control field traversal.
  final FocusNode? focusNode;

  /// Platform keyboard type.
  final TextInputType keyboardType;

  /// Optional input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Platform keyboard action.
  final TextInputAction textInputAction;

  /// Callback invoked when the keyboard action is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CalcInputField> createState() => _CalcInputFieldState();
}

class _CalcInputFieldState extends State<CalcInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valueText);
  }

  @override
  void didUpdateWidget(CalcInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextText = widget.valueText ?? '';
    if (_controller.text != nextText) {
      _controller.value = TextEditingValue(
        text: nextText,
        selection: TextSelection.collapsed(offset: nextText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final radii = Theme.of(context).extension<AppRadii>()!;
    final spacing = Theme.of(context).extension<AppSpacing>()!;
    final typography = Theme.of(context).extension<AppTypography>()!;
    final hasError = widget.errorText != null;
    final largeText = MediaQuery.textScalerOf(context).scale(16) >= 20.8;
    final inputHeight = largeText ? 56.0 : 44.0;
    final inputTextStyle =
        (largeText
                ? typography.titleL.copyWith(fontSize: 24)
                : typography.titleM)
            .copyWith(
              color: palette.calcInk,
              fontWeight: FontWeight.w600,
            );
    final borderColor = hasError
        ? palette.calcError
        : widget.focused
        ? palette.calcPrimary
        : palette.calcHairline;
    final borderWidth = widget.focused
        ? 2.0
        : hasError
        ? 1.5
        : 1.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: typography.labelS.copyWith(color: palette.calcMuted),
        ),
        SizedBox(height: spacing.s1),
        SizedBox(
          key: _inputBoxKey,
          height: inputHeight,
          child: TextFormField(
            controller: _controller,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            style: inputTextStyle,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: hasError
                  ? palette.calcErrorContainer
                  : palette.calcSurface,
              hintText: widget.placeholder,
              hintStyle: inputTextStyle.copyWith(
                color: palette.calcMuted2,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: spacing.s3),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    widget.unit,
                    style: typography.labelM.copyWith(
                      color: hasError ? palette.calcError : palette.calcMuted,
                      fontFamily: 'JetBrainsMono',
                      fontFamilyFallback: const ['NotoSansJP'],
                    ),
                  ),
                ),
              ),
              suffixIconConstraints: const BoxConstraints.tightFor(
                width: 32,
                height: 20,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: spacing.s3,
                vertical: largeText ? 14 : 11,
              ),
              border: _inputBorder(radii.tile, borderColor, borderWidth),
              enabledBorder: _inputBorder(radii.tile, borderColor, borderWidth),
              focusedBorder: _inputBorder(
                radii.tile,
                palette.calcPrimary,
                2,
              ),
              errorBorder: _inputBorder(radii.tile, palette.calcError, 1.5),
              focusedErrorBorder: _inputBorder(
                radii.tile,
                palette.calcError,
                2,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: spacing.s1),
          Row(
            children: [
              Icon(Icons.error_outline, color: palette.calcError, size: 14),
              SizedBox(width: spacing.s1),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: typography.labelS.copyWith(
                    color: palette.calcError,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  OutlineInputBorder _inputBorder(
    double radius,
    Color color,
    double width,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Key? get _inputBoxKey {
    final widgetKey = widget.key;
    if (widgetKey is ValueKey<String>) {
      return ValueKey<String>('${widgetKey.value}-box');
    }
    return null;
  }
}
