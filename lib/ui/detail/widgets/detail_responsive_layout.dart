import 'package:fictional_drug_and_disease_ref/theme/detail_color_extension.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:flutter/material.dart';

/// Responsive detail layout shared by drug and disease detail screens.
class DetailResponsiveLayout extends StatelessWidget {
  /// Creates a responsive detail layout.
  const DetailResponsiveLayout({
    required this.tabs,
    required this.activeBody,
    this.appBar,
    this.footer,
    super.key,
  });

  /// App bar content.
  final Widget? appBar;

  /// Tab controls.
  final List<Widget> tabs;

  /// Active tab body.
  final Widget activeBody;

  /// Fixed footer content.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= DetailConstants.tabletBreakpoint) {
          final colors = _detailColors(context);
          return Column(
            key: const ValueKey<String>('detail-tablet-layout'),
            children: [
              if (appBar != null)
                SizedBox(
                  height: DetailConstants.appBarHeight,
                  child: appBar,
                ),
              Expanded(
                child: Row(
                  key: const ValueKey<String>('detail-tablet-shell'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      key: const ValueKey<String>('detail-tablet-nav-pane'),
                      width: DetailConstants.tabletNavWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerLow,
                          border: Border(
                            right: BorderSide(color: colors.outlineVariant),
                          ),
                        ),
                        child: Padding(
                          key: const ValueKey<String>(
                            'detail-tablet-nav-padding',
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: DetailConstants.tabletNavPaddingVertical,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _TabletNavHeader(colors: colors),
                                ...tabs,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      key: const ValueKey<String>('detail-tablet-content-pane'),
                      child: SingleChildScrollView(
                        key: const ValueKey<String>(
                          'detail-tablet-content-scroll',
                        ),
                        padding: const EdgeInsets.only(
                          bottom: DetailConstants.tabletContentBottomPadding,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: activeBody,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (footer != null)
                SizedBox(
                  height: DetailConstants.footerHeight,
                  child: footer,
                ),
            ],
          );
        }
        return Column(
          key: const ValueKey<String>('detail-phone-layout'),
          children: [
            if (appBar != null)
              SizedBox(
                height: DetailConstants.appBarHeight,
                child: appBar,
              ),
            SizedBox(
              height: DetailConstants.tabBarHeight,
              child: SingleChildScrollView(
                key: const ValueKey<String>('detail-phone-tab-scroll'),
                scrollDirection: Axis.horizontal,
                child: Row(children: tabs),
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    key: const ValueKey<String>(
                      'detail-phone-content-scroll',
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: activeBody,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (footer != null)
              SizedBox(
                height: DetailConstants.footerHeight,
                child: footer,
              ),
          ],
        );
      },
    );
  }
}

class _TabletNavHeader extends StatelessWidget {
  const _TabletNavHeader({required this.colors});

  final DetailColorExtension colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey<String>('detail-tablet-nav-header'),
      padding: const EdgeInsets.fromLTRB(
        DetailConstants.tabletNavHeaderPaddingHorizontal,
        DetailConstants.tabletNavHeaderPaddingVertical,
        DetailConstants.tabletNavHeaderPaddingHorizontal,
        DetailConstants.tabletNavHeaderPaddingVertical +
            DetailConstants.tabletNavHeaderBottomMargin,
      ),
      child: Text(
        'セクション',
        style: TextStyle(
          color: colors.onSurfaceVariant,
          fontSize: DetailConstants.tabletNavHeaderFontSize,
          fontWeight: FontWeight.w700,
          letterSpacing: DetailConstants.tabletNavHeaderLetterSpacing,
        ),
      ),
    );
  }
}

DetailColorExtension _detailColors(BuildContext context) {
  final theme = Theme.of(context);
  final extension = theme.extension<DetailColorExtension>();
  if (extension != null) {
    return extension;
  }
  return theme.brightness == Brightness.dark
      ? DetailColorExtension.dark
      : DetailColorExtension.light;
}
