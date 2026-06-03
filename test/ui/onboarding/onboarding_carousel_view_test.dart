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
import 'package:material_symbols_icons/symbols.dart';
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

    testWidgets('matches the design spec skip button style and geometry', (
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
      final context = tester.element(skipFinder);
      final palette = Theme.of(context).extension<AppPalette>()!;
      final spacing = Theme.of(context).extension<AppSpacing>()!;
      final label = tester.widget<Text>(labelFinder);
      final icon = tester.widget<Text>(iconFinder);
      final buttonRect = tester.getRect(skipFinder);
      final labelRect = tester.getRect(labelFinder);
      final iconRect = tester.getRect(iconFinder);

      expect(label.style?.fontSize, icon.style?.fontSize);
      expect(label.style?.height, icon.style?.height);
      expect(label.style?.fontFamily, icon.style?.fontFamily);
      expect(label.style?.fontWeight, FontWeight.w600);
      expect(label.style?.color, palette.muted);
      expect(icon.style?.color, palette.muted);
      expect((labelRect.center.dy - iconRect.center.dy).abs(), 0);
      expect(iconRect.left - labelRect.right, spacing.s1);
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

        expect(skipFinder, findsOneWidget);
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
          matching: find.byIcon(Symbols.medical_services),
        ),
      );
      final titleRect = tester.getRect(find.text('メディマスタへようこそ'));

      expect(iconRect.bottom, lessThan(titleRect.top));
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

      final renderedSegments = find
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

      expect(renderedSegments.join(), _secondIntroBody);
      expect(renderedSegments, _secondIntroBodySegments);
      expect(
        renderedSegments,
        everyElement(isNot(contains('\n'))),
      );
      expect(renderedSegments, contains('閲覧履歴を'));
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

        for (final segment in _secondIntroBodySegments) {
          final rect = tester.getRect(find.text(segment));
          expect(rect.right, lessThanOrEqualTo(featureListRect.right));
        }
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

      final featureListRect = tester.getRect(
        find.byKey(const ValueKey<String>('onboarding-feature-list')),
      );
      final renderedSegments = find
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

      expect(renderedSegments.join(), _secondIntroBody);
      expect(renderedSegments, _secondIntroBodySegments);
      for (final segment in _secondIntroBodySegments) {
        final rect = tester.getRect(find.text(segment));
        expect(rect.right, lessThanOrEqualTo(featureListRect.right));
      }
    });

    testWidgets('keeps third intro body from splitting polite ending', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(390, 844),
      );
      await tester.goToThirdOnboardingPage();

      final renderedSegments = find
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

      expect(renderedSegments.join(), _thirdIntroBody);
      expect(renderedSegments, _thirdIntroBodySegments);
      expect(renderedSegments, contains('案内します。'));
      expect(renderedSegments, isNot(contains('案内し')));
      expect(renderedSegments, isNot(contains('ます。')));
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

        expect(find.text('閲覧履歴を'), findsOneWidget);
        for (final segment in _secondIntroBodySegments) {
          final rect = tester.getRect(find.text(segment));
          expect(rect.right, lessThanOrEqualTo(featureListRect.right));
        }
      },
    );

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
          matching: find.byIcon(Symbols.menu_book),
        ),
      );
      final titleRect = tester.getRect(find.text('主要機能'));
      final featureIconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Symbols.search),
        ),
      );

      expect(titleRect.left, greaterThan(iconRect.right));
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
          matching: find.byIcon(Symbols.menu_book),
        ),
      );
      final titleRect = tester.getRect(find.text('主要機能'));
      final featureIconRect = tester.getRect(
        find.descendant(
          of: pageFinder,
          matching: find.byIcon(Symbols.search),
        ),
      );

      expect(iconRect.bottom, lessThan(titleRect.top));
      expect(
        (iconRect.center.dx - titleRect.center.dx).abs(),
        lessThanOrEqualTo(1),
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
