import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared title header for top-level shell tabs.
class AppTabHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a shared tab header.
  const AppTabHeader({
    required this.tab,
    this.toolbarHeight = 56,
    this.bottom,
    this.actions,
    super.key,
  });

  /// Shell tab represented by this header.
  final AppShellTab tab;

  /// Header toolbar height.
  final double toolbarHeight;

  /// Optional tab-specific bottom area.
  final PreferredSizeWidget? bottom;

  /// Optional tab-specific actions rendered before the about entry point.
  final List<Widget>? actions;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 1;
    return Size.fromHeight(toolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette =
        theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
    final typography = theme.extension<AppTypography>() ?? AppTypography.tokens;
    final effectiveBottom = bottom ?? _AppTabHeaderHairline(palette: palette);
    final l10n = AppLocalizations.of(context)!;

    return AppBar(
      key: const ValueKey<String>('app-tab-header'),
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 16,
      toolbarHeight: toolbarHeight,
      title: Text(
        tab.label(context),
        key: const ValueKey<String>('app-tab-header-title'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: typography.titleL
            .copyWith(color: palette.ink)
            .withVariableWeight(FontWeight.w700),
      ),
      backgroundColor: palette.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: effectiveBottom,
      actions: [
        ...?actions,
        IconButton(
          icon: Icon(Icons.info_outline, color: palette.ink),
          tooltip: l10n.aboutTitle,
          onPressed: () => context.push(AppRoutes.about),
        ),
      ],
    );
  }
}

class _AppTabHeaderHairline extends StatelessWidget
    implements PreferredSizeWidget {
  const _AppTabHeaderHairline({required this.palette});

  final AppPalette palette;

  @override
  Size get preferredSize => const Size.fromHeight(1);

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    return Divider(
      height: 1,
      thickness: 1 / devicePixelRatio,
      color: palette.hairline,
    );
  }
}
