import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_palette.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_typography.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/drug_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  runGoldenMatrix(
    fileNamePrefix: 'drug_result_card_existing',
    description: 'DrugResultCard existing layout',
    builder: (theme, size, scaler) {
      final cacheManager = _MockBaseCacheManager();
      when(
        () => cacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('golden tests render the fallback image'));

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: _CardGoldenFrame(
            child: DrugResultCard(
              item: _drugSummary,
              cacheManager: cacheManager,
              logImageErrors: false,
            ),
          ),
        ),
      );
    },
  );

  runGoldenMatrix(
    fileNamePrefix: 'drug_result_card_trailing_time',
    description: 'DrugResultCard trailing time layout',
    builder: (theme, size, scaler) {
      final cacheManager = _MockBaseCacheManager();
      when(
        () => cacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(StateError('golden tests render the fallback image'));
      final palette =
          theme.extension<AppPalette>() ??
          (theme.brightness == Brightness.dark
              ? AppPalette.dark
              : AppPalette.light);
      final typography =
          theme.extension<AppTypography>() ?? AppTypography.tokens;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: _CardGoldenFrame(
            child: DrugResultCard(
              item: _drugSummary,
              cacheManager: cacheManager,
              logImageErrors: false,
              trailingTime: Text(
                '5分前',
                key: const ValueKey('drug-card-trailing-time'),
                style: typography.labelM.copyWith(color: palette.muted),
              ),
            ),
          ),
        ),
      );
    },
  );

  testWidgets('DrugResultCard keeps row height in list constraints', (
    tester,
  ) async {
    final cacheManager = _MockBaseCacheManager();
    when(
      () => cacheManager.getSingleFile(
        any(),
        key: any(named: 'key'),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(StateError('widget tests render the fallback image'));

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DrugResultCard(
                item: _drugSummary,
                cacheManager: cacheManager,
                logImageErrors: false,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final cardRect = tester.getRect(find.byType(Card));
    expect(cardRect.height, lessThan(160));
  });
}

class _CardGoldenFrame extends StatelessWidget {
  const _CardGoldenFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(width: constraints.maxWidth - 32, child: child),
          ),
        );
      },
    );
  }
}

const _drugSummary = DrugSummary(
  id: 'drug_AML012',
  brandName: 'アムロジ錠5mg「ニチイ」',
  genericName: 'アムロジピンベシル酸塩',
  therapeuticCategoryName: 'Ca拮抗薬',
  regulatoryClass: ['narcotic', 'prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジジョウ',
  atcCode: 'C08CA01',
  revisedAt: '2025-03-02',
  imageUrl: '/images/drugs/drug_AML012.png',
);

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}
