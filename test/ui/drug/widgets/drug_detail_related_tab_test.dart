import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_related_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('DrugDetailRelatedTab renders D18 carousel and navigates by id', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();
    final diseaseId = drug.relatedDiseaseIds.single;
    final router = GoRouter(
      initialLocation: AppRoutes.search,
      routes: [
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => DrugDetailRelatedTab(drug: drug),
          routes: [
            GoRoute(
              path: 'disease/:id',
              builder: (context, state) =>
                  Text('disease-detail-${state.pathParameters['id']}'),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );

    expect(find.text('関連疾患'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text(diseaseId), findsOneWidget);

    await tester.tap(find.text(diseaseId));
    await tester.pumpAndSettle();

    expect(find.text('disease-detail-$diseaseId'), findsOneWidget);
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      AppRoutes.diseaseDetail(diseaseId),
    );
  });
}

DrugDto _drugFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DrugDto.fromJson(json);
}
