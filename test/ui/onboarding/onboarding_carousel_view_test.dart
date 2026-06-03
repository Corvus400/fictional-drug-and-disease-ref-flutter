import 'dart:io';

import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_spacing.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _secondIntroBody = '検索・詳細・計算ツール・ブックマーク・閲覧履歴を1つに集約しています。';
const _secondIntroBodySegments = [
  '検索・',
  '詳細・',
  '計算ツール・',
  'ブックマーク・',
  '閲覧履歴を',
  '1つに集約しています。',
];
const _thirdIntroBody = '続いて、実画面上で主要な操作位置を順に案内します。';
const _thirdIntroBodySegments = [
  '続いて、',
  '実画面上で',
  '主要な操作位置を',
  '順に',
  '案内します。',
];

void main() {
  group('OnboardingCarouselView', () {
    late _MockOnboardingService service;

    setUp(() {
      service = _MockOnboardingService();
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.ok(false));
    });

    test('intro icons do not depend on Material Symbols package fonts', () {
      final source = File(
        'lib/ui/onboarding/onboarding_carousel_view.dart',
      ).readAsStringSync();

      expect(source, isNot(contains('material_symbols_icons')));
    });

    testWidgets('shows first intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-1')),
        findsOneWidget,
      );
    });

    testWidgets('shows skip action on first intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-skip')),
        findsOneWidget,
      );
    });

    testWidgets('matches skip label and close icon font size', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final labelFinder = find.descendant(
        of: skipFinder,
        matching: find.text('スキップ'),
      );
      final iconFinder = find.descendant(
        of: skipFinder,
        matching: find.text('×'),
      );
      final label = tester.widget<Text>(labelFinder);
      final icon = tester.widget<Text>(iconFinder);

      expect(label.style?.fontSize, icon.style?.fontSize);
    });

    testWidgets('uses the design spec weight for the skip label', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final label = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const ValueKey<String>('onboarding-skip')),
          matching: find.text('スキップ'),
        ),
      );

      expect(label.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('uses the design spec muted color for the skip label', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final palette = Theme.of(
        tester.element(skipFinder),
      ).extension<AppPalette>()!;
      final label = tester.widget<Text>(
        find.descendant(of: skipFinder, matching: find.text('スキップ')),
      );

      expect(label.style?.color, palette.muted);
    });

    testWidgets('uses the design spec muted color for the skip close icon', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final palette = Theme.of(
        tester.element(skipFinder),
      ).extension<AppPalette>()!;
      final icon = tester.widget<Text>(
        find.descendant(of: skipFinder, matching: find.text('×')),
      );

      expect(icon.style?.color, palette.muted);
    });

    testWidgets('vertically centers the skip label and close icon', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final labelRect = tester.getRect(
        find.descendant(of: skipFinder, matching: find.text('スキップ')),
      );
      final iconRect = tester.getRect(
        find.descendant(of: skipFinder, matching: find.text('×')),
      );

      expect((labelRect.center.dy - iconRect.center.dy).abs(), 0);
    });

    testWidgets('uses the design spec gap between skip label and close icon', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final spacing = Theme.of(
        tester.element(skipFinder),
      ).extension<AppSpacing>()!;
      final labelRect = tester.getRect(
        find.descendant(of: skipFinder, matching: find.text('スキップ')),
      );
      final iconRect = tester.getRect(
        find.descendant(of: skipFinder, matching: find.text('×')),
      );

      expect(iconRect.left - labelRect.right, spacing.s1);
    });

    testWidgets('uses the design spec right padding for the skip control', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      final skipFinder = find.byKey(const ValueKey<String>('onboarding-skip'));
      final buttonRect = tester.getRect(skipFinder);
      final iconRect = tester.getRect(
        find.descendant(of: skipFinder, matching: find.text('×')),
      );

      expect(buttonRect.right - iconRect.right, 10);
    });

    testWidgets(
      'renders skip as an inline spec control without TextButton chrome',
      (
        tester,
      ) async {
        await tester.pumpOnboardingCarousel(service);

        final skipFinder = find.byKey(
          const ValueKey<String>('onboarding-skip'),
        );

        expect(tester.widget(skipFinder), isNot(isA<TextButton>()));
      },
    );

    testWidgets('shows next action on first intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-next')),
        findsOneWidget,
      );
    });

    testWidgets('shows first page indicator dot', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-1')),
        findsOneWidget,
      );
    });

    testWidgets('shows second page indicator dot', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-2')),
        findsOneWidget,
      );
    });

    testWidgets('shows third page indicator dot', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byKey(const ValueKey<String>('onboarding-dot-3')),
        findsOneWidget,
      );
    });

    testWidgets('moves to the second intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-2')),
        findsOneWidget,
      );
    });

    testWidgets('moves to the third intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('onboarding-page-3')),
        findsOneWidget,
      );
    });

    testWidgets('shows start action on the last intro page', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-next')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('onboarding-start')),
        findsOneWidget,
      );
    });

    testWidgets('renders search feature row title', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);
      await tester.goToSecondOnboardingPage();

      expect(find.text('検索'), findsOneWidget);
    });

    testWidgets('renders search feature row supporting text', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);
      await tester.goToSecondOnboardingPage();

      expect(find.text('医薬品・疾患をキーワードで検索できます'), findsOneWidget);
    });

    testWidgets(
      'reveals the disclaimer after scrolling phone landscape column',
      (
        tester,
      ) async {
        await tester.pumpOnboardingCarousel(
          service,
          surfaceSize: const Size(844, 390),
        );

        await tester.drag(
          find.byKey(const ValueKey<String>('onboarding-page-1')),
          const Offset(0, -180),
        );
        await tester.pumpAndSettle();

        final disclaimerRect = tester.getRect(
          find.bySemanticsLabel(
            'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可',
          ),
        );
        final pageViewRect = tester.getRect(find.byType(PageView));

        expect(
          disclaimerRect.bottom,
          lessThanOrEqualTo(pageViewRect.bottom - 8),
        );
      },
    );

    testWidgets('breaks the disclaimer at the bilingual separator', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(service);

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data ==
                  'FICTIONAL DATA - NOT FOR MEDICAL USE\n'
                      '架空データ・医療判断には使用不可' &&
              widget.semanticsLabel ==
                  'FICTIONAL DATA - NOT FOR MEDICAL USE / 架空データ・医療判断には使用不可',
        ),
        findsOneWidget,
      );
    });

    testWidgets('breaks first intro body copy at the sentence boundary', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );

      expect(
        find.text(
          '架空データの医薬品・疾患リファレンスです。\n主要機能の場所を最初に案内します。',
        ),
        findsOneWidget,
      );
    });

    testWidgets('uses centered phone column layout in landscape', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-1'),
      );
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.medical_services_outlined),
        ),
      );
      final titleRect = tester.getRect(find.text('メディマスタへようこそ'));

      expect(iconRect.bottom, lessThan(titleRect.top));
    });

    testWidgets('centers the first page icon with the title in landscape', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-1'),
      );
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.medical_services_outlined),
        ),
      );
      final titleRect = tester.getRect(find.text('メディマスタへようこそ'));

      expect(
        (iconRect.center.dx - titleRect.center.dx).abs(),
        lessThanOrEqualTo(1),
      );
    });

    testWidgets('wraps second intro body at Japanese phrase boundaries', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(_renderedIntroBodySegments(tester), _secondIntroBodySegments);
    });

    testWidgets('preserves the full second intro body copy', (tester) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(_renderedIntroBodySegments(tester).join(), _secondIntroBody);
    });

    testWidgets('keeps second intro body phrases free of hard newlines', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(_segmentsWithHardNewlines(tester), isEmpty);
    });

    testWidgets('keeps browsing history as one Japanese phrase', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(find.text('閲覧履歴を'), findsOneWidget);
    });

    testWidgets(
      'wraps second intro body inside the feature list right edge',
      (tester) async {
        await tester.pumpOnboardingCarousel(
          service,
          surfaceSize: const Size(1024, 474),
        );
        await tester.goToSecondOnboardingPage();

        final featureListRect = tester.getRect(
          find.byKey(
            const ValueKey<String>('onboarding-feature-list'),
          ),
        );

        expect(
          _segmentsOutsideRightEdge(
            tester,
            _secondIntroBodySegments,
            featureListRect,
          ),
          isEmpty,
        );
      },
    );

    testWidgets('wraps phone portrait body at Japanese phrase boundaries', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToSecondOnboardingPage();

      expect(_renderedIntroBodySegments(tester), _secondIntroBodySegments);
    });

    testWidgets('keeps phone portrait body phrases inside the feature width', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToSecondOnboardingPage();

      final featureListRect = tester.getRect(
        find.byKey(const ValueKey<String>('onboarding-feature-list')),
      );

      expect(
        _segmentsOutsideRightEdge(
          tester,
          _secondIntroBodySegments,
          featureListRect,
        ),
        isEmpty,
      );
    });

    testWidgets('keeps third intro body from splitting polite ending', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      expect(_renderedIntroBodySegments(tester), _thirdIntroBodySegments);
    });

    testWidgets('preserves the full third intro body copy', (tester) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      expect(_renderedIntroBodySegments(tester).join(), _thirdIntroBody);
    });

    testWidgets('keeps the third intro polite ending as one phrase', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      expect(find.text('案内します。'), findsOneWidget);
    });

    testWidgets('does not split the third intro polite stem', (tester) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      expect(find.text('案内し'), findsNothing);
    });

    testWidgets('does not split the third intro polite ending', (tester) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      expect(find.text('ます。'), findsNothing);
    });

    testWidgets(
      'keeps narrow landscape body phrases inside the feature width',
      (
        tester,
      ) async {
        await tester.pumpOnboardingCarousel(
          service,
          surfaceSize: const Size(844, 390),
        );
        await tester.goToSecondOnboardingPage();

        final featureListRect = tester.getRect(
          find.byKey(
            const ValueKey<String>('onboarding-feature-list'),
          ),
        );

        expect(
          _segmentsOutsideRightEdge(
            tester,
            _secondIntroBodySegments,
            featureListRect,
          ),
          isEmpty,
        );
      },
    );

    testWidgets('keeps the narrow landscape history phrase intact', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(find.text('閲覧履歴を'), findsOneWidget);
    });

    testWidgets('reveals feature row text after scrolling phone landscape', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      await tester.drag(
        find.byKey(const ValueKey<String>('onboarding-page-2')),
        const Offset(0, -260),
      );
      await tester.pumpAndSettle();

      final featureTextRect = tester.getRect(
        find.text('医薬品・疾患をキーワードで検索できます'),
      );
      final pageViewRect = tester.getRect(find.byType(PageView));

      expect(
        featureTextRect.bottom,
        lessThanOrEqualTo(pageViewRect.bottom - 8),
      );
    });

    testWidgets('places phone landscape title to the right of the icon', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(1024, 474),
      );
      await tester.goToSecondOnboardingPage();

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-2'),
      );
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.menu_book_outlined),
        ),
      );
      final titleRect = tester.getRect(find.text('主要機能'));

      expect(titleRect.left, greaterThan(iconRect.right));
    });

    testWidgets('aligns phone landscape feature list with the icon left edge', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(1024, 474),
      );
      await tester.goToSecondOnboardingPage();

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-2'),
      );
      final spacing = Theme.of(
        tester.element(pageFinder),
      ).extension<AppSpacing>()!;
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.menu_book_outlined),
        ),
      );
      final featureIconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.search),
        ),
      );

      expect(
        (featureIconRect.left - spacing.s3 - iconRect.left).abs(),
        lessThanOrEqualTo(1),
      );
    });

    testWidgets('keeps phone portrait page two in a centered column', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToSecondOnboardingPage();

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-2'),
      );
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.menu_book_outlined),
        ),
      );
      final titleRect = tester.getRect(find.text('主要機能'));

      expect(iconRect.bottom, lessThan(titleRect.top));
    });

    testWidgets('centers phone portrait page two icon with the title', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToSecondOnboardingPage();

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-2'),
      );
      final iconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.menu_book_outlined),
        ),
      );
      final titleRect = tester.getRect(find.text('主要機能'));

      expect(
        (iconRect.center.dx - titleRect.center.dx).abs(),
        lessThanOrEqualTo(1),
      );
    });

    testWidgets('places phone portrait feature list below the title', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToSecondOnboardingPage();

      final pageFinder = find.byKey(
        const ValueKey<String>('onboarding-page-2'),
      );
      final titleRect = tester.getRect(find.text('主要機能'));
      final featureIconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Icons.search),
        ),
      );

      expect(featureIconRect.top, greaterThan(titleRect.bottom));
    });

    testWidgets('reveals the final feature after scrolling phone landscape', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      await tester.drag(
        find.byKey(const ValueKey<String>('onboarding-page-2')),
        const Offset(0, -420),
      );
      await tester.pumpAndSettle();

      final historyTextRect = tester.getRect(find.text('閲覧履歴'));
      final pageViewRect = tester.getRect(find.byType(PageView));

      expect(
        historyTextRect.bottom,
        lessThanOrEqualTo(pageViewRect.bottom - 8),
      );
    });

    testWidgets('skip marks onboarding completed', (tester) async {
      when(
        () => service.write(completed: true),
      ).thenAnswer((_) async => const Result.ok(null));

      await tester.pumpOnboardingCarousel(service);
      await tester.tap(find.byKey(const ValueKey<String>('onboarding-skip')));
      await tester.pump();

      verify(() => service.write(completed: true)).called(1);
    });
  });
}

List<String> _renderedIntroBodySegments(WidgetTester tester) {
  return find
      .descendant(
        of: find.byKey(
          const ValueKey<String>('onboarding-intro-body-phrase-lines'),
        ),
        matching: find.byType(Text),
      )
      .evaluate()
      .map((element) => (element.widget as Text).data)
      .whereType<String>()
      .toList(growable: false);
}

List<String> _segmentsWithHardNewlines(WidgetTester tester) {
  return [
    for (final segment in _renderedIntroBodySegments(tester))
      if (segment.contains('\n')) segment,
  ];
}

List<String> _segmentsOutsideRightEdge(
  WidgetTester tester,
  Iterable<String> segments,
  Rect boundary,
) {
  return [
    for (final segment in segments)
      if (tester.getRect(find.text(segment)).right > boundary.right) segment,
  ];
}

extension on WidgetTester {
  Future<void> pumpOnboardingCarousel(
    OnboardingService service, {
    Size? surfaceSize,
  }) async {
    if (surfaceSize != null) {
      await binding.setSurfaceSize(surfaceSize);
      addTearDown(() => binding.setSurfaceSize(null));
    }

    await pumpWidget(
      ProviderScope(
        overrides: [onboardingServiceProvider.overrideWithValue(service)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: _OnboardingCarouselTestHost(surfaceSize: surfaceSize),
        ),
      ),
    );
    await pump();
  }

  Future<void> goToSecondOnboardingPage() async {
    await tap(find.byKey(const ValueKey<String>('onboarding-next')));
    await pumpAndSettle();
  }

  Future<void> goToThirdOnboardingPage() async {
    await goToSecondOnboardingPage();
    await tap(find.byKey(const ValueKey<String>('onboarding-next')));
    await pumpAndSettle();
  }
}

final class _OnboardingCarouselTestHost extends StatelessWidget {
  const _OnboardingCarouselTestHost({required this.surfaceSize});

  final Size? surfaceSize;

  @override
  Widget build(BuildContext context) {
    const child = OnboardingCarouselView();
    final size = surfaceSize;
    if (size == null) {
      return child;
    }
    return MediaQuery(
      data: MediaQueryData(size: size),
      child: child,
    );
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
