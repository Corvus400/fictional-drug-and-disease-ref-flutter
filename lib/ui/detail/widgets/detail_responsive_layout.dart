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
          return Row(
            key: const ValueKey<String>('detail-tablet-layout'),
            children: [
              SizedBox(
                width: DetailConstants.tabletNavWidth,
                child: Column(children: tabs),
              ),
              Expanded(child: activeBody),
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
              child: Row(children: tabs),
            ),
            Expanded(child: activeBody),
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
