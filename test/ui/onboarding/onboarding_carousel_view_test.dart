import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/onboarding_service.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/onboarding/onboarding_carousel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
      'keeps the disclaimer above the fixed footer in phone landscape',
      (
        tester,
      ) async {
        await tester.pumpOnboardingCarousel(
          service,
          surfaceSize: const Size(844, 390),
        );

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

    testWidgets('breaks second intro body copy at the sentence boundary', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      expect(
        find.text('検索・詳細・計算ツール・ブックマーク・閲覧履歴を\n1 つに集約しています。'),
        findsOneWidget,
      );
    });

    testWidgets('shows feature row text before the footer in phone landscape', (
      tester,
    ) async {
      await tester.pumpOnboardingCarousel(
        service,
        surfaceSize: const Size(844, 390),
      );
      await tester.goToSecondOnboardingPage();

      final featureTextRect = tester.getRect(
        find.text('医薬品・疾患をキーワードで検索できます'),
      );
      final pageViewRect = tester.getRect(find.byType(PageView));

      expect(
        featureTextRect.bottom,
        lessThanOrEqualTo(pageViewRect.bottom - 8),
      );
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
        const Offset(0, -320),
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
          home: const OnboardingCarouselView(),
        ),
      ),
    );
    await pump();
  }

  Future<void> goToSecondOnboardingPage() async {
    await tap(find.byKey(const ValueKey<String>('onboarding-next')));
    await pumpAndSettle();
  }
}

final class _MockOnboardingService extends Mock implements OnboardingService {}
