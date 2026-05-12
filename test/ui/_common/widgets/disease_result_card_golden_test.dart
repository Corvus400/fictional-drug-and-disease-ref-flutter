import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/ui/_common/widgets/disease_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../golden/golden_test_helpers.dart';

void main() {
  runGoldenMatrix(
    fileNamePrefix: 'disease_result_card_existing',
    description: 'DiseaseResultCard existing layout',
    builder: (theme, size, scaler) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: _CardGoldenFrame(
            child: DiseaseResultCard(item: _diseaseSummary),
          ),
        ),
      );
    },
  );

  testWidgets('DiseaseResultCard keeps row height in list constraints', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              DiseaseResultCard(item: _diseaseSummary),
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

const _diseaseSummary = DiseaseSummary(
  id: 'disease_HTN001',
  name: '本態性高血圧症',
  icd10Chapter: 'chapter_ix',
  medicalDepartment: ['internal_medicine', 'cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'ホンタイセイコウケツアツショウ',
  revisedAt: '2025-03-02',
);
