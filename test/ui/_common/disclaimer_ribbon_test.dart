import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/disclaimer_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DisclaimerRibbon', () {
    testWidgets('renders structured l10n text inside IgnorePointer', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: DisclaimerRibbon()),
        ),
      );

      final l10n = AppLocalizations.of(
        tester.element(find.byType(DisclaimerRibbon)),
      )!;
      final segments = l10n.detailDisclaimer.split(' / ');
      expect(find.text(segments.first), findsOneWidget);
      expect(find.text(segments.last), findsOneWidget);
      expect(find.text('·'), findsNWidgets(3));
      expect(
        find.descendant(
          of: find.byType(DisclaimerRibbon),
          matching: find.byType(IgnorePointer),
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses calc ribbon colors from AppPalette', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: DisclaimerRibbon()),
        ),
      );

      final palette = AppTheme.dark().extension<AppPalette>()!;
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(DisclaimerRibbon),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, palette.calcRibbonBg);
      expect(
        tester
            .widget<Text>(
              find.text(
                AppLocalizations.of(
                  tester.element(find.byType(DisclaimerRibbon)),
                )!.detailDisclaimer.split(' / ').first,
              ),
            )
            .style
            ?.color,
        palette.calcRibbonFg,
      );
      expect(
        tester.widget<Text>(find.text('·').first).style?.color,
        palette.calcRibbonAccent,
      );
    });

    testWidgets('switches height by media size', (tester) async {
      await _pumpRibbon(tester, const Size(390, 844));
      expect(tester.getSize(find.byType(DisclaimerRibbon)).height, 26);

      await _pumpRibbon(tester, const Size(844, 390));
      expect(tester.getSize(find.byType(DisclaimerRibbon)).height, 22);

      await _pumpRibbon(tester, const Size(834, 1194));
      expect(tester.getSize(find.byType(DisclaimerRibbon)).height, 28);
    });
  });
}

Future<void> _pumpRibbon(WidgetTester tester, Size size) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: const Scaffold(body: DisclaimerRibbon()),
      ),
    ),
  );
}
