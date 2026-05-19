import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/common/loading/shimmer_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  testWidgets('enabled skeleton wraps child in an active Skeletonizer', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedApp(
        child: const ShimmerSkeleton(child: Text('content')),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is Skeletonizer && widget.enabled,
      ),
      findsOneWidget,
    );
  });

  testWidgets('disabled skeleton renders the child without Skeletonizer', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedApp(
        child: const ShimmerSkeleton(
          enabled: false,
          child: Text('content'),
        ),
      ),
    );

    expect(find.byType(Skeletonizer), findsNothing);
    expect(find.text('content'), findsOneWidget);
  });

  testWidgets('enabled skeleton exposes a loading semantics label', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      _localizedApp(
        child: const ShimmerSkeleton(child: Text('content')),
      ),
    );

    expect(find.bySemanticsLabel('読み込み中'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('enabled skeleton does not render visible loading copy', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedApp(
        child: const ShimmerSkeleton(child: Text('content')),
      ),
    );

    expect(find.text('読み込み中'), findsNothing);
    expect(find.text('Loading'), findsNothing);
    expect(find.text('検索中…'), findsNothing);
  });

  testWidgets('enabled skeleton uses palette surface2 as shimmer base color', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localizedApp(
        child: const ShimmerSkeleton(child: Text('content')),
      ),
    );

    final skeletonizer = tester.widget<Skeletonizer>(
      find.byWidgetPredicate((widget) => widget is Skeletonizer),
    );
    final effect = skeletonizer.effect! as ShimmerEffect;

    expect(effect.colors.first, AppPalette.light.surface2);
  });

  testWidgets(
    'enabled skeleton uses palette surface3 as shimmer highlight color',
    (tester) async {
      await tester.pumpWidget(
        _localizedApp(
          child: const ShimmerSkeleton(child: Text('content')),
        ),
      );

      final skeletonizer = tester.widget<Skeletonizer>(
        find.byWidgetPredicate((widget) => widget is Skeletonizer),
      );
      final effect = skeletonizer.effect! as ShimmerEffect;

      expect(effect.colors[1], AppPalette.light.surface3);
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'shimmer_skeleton__list_row',
    description: 'List row skeleton shape',
    builder: (theme, size, scaler) => _localizedApp(
      theme: theme,
      tickerModeEnabled: false,
      child: Center(
        child: SizedBox(
          width: 320,
          child: ShimmerSkeleton(
            child: ShimmerSkeletonShapes.listRow(),
          ),
        ),
      ),
    ),
  );

  runGoldenMatrix(
    fileNamePrefix: 'shimmer_skeleton__detail_block',
    description: 'Detail block skeleton shape',
    builder: (theme, size, scaler) => _localizedApp(
      theme: theme,
      tickerModeEnabled: false,
      child: Center(
        child: SizedBox(
          width: 320,
          child: ShimmerSkeleton(
            child: ShimmerSkeletonShapes.detailBlock(),
          ),
        ),
      ),
    ),
  );
}

Widget _localizedApp({
  required Widget child,
  ThemeData? theme,
  bool tickerModeEnabled = true,
}) {
  return MaterialApp(
    theme: theme ?? AppTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: TickerMode(enabled: tickerModeEnabled, child: child),
    ),
  );
}
