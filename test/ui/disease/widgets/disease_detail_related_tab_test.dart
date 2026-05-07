import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_related_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets(
    'DiseaseDetailRelatedTab renders E15 carousel and navigates by id',
    (
      tester,
    ) async {
      final disease = _diseaseFixture().toDomain();
      final drugId = disease.relatedDrugIds.single;
      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) =>
                DiseaseDetailRelatedTab(disease: disease),
            routes: [
              GoRoute(
                path: 'drug/:id',
                builder: (context, state) =>
                    Text('drug-detail-${state.pathParameters['id']}'),
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

      expect(find.text('関連医薬品'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text(drugId), findsOneWidget);

      await tester.tap(find.text(drugId));
      await tester.pumpAndSettle();

      expect(find.text('drug-detail-$drugId'), findsOneWidget);
      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.drugDetail(drugId),
      );
    },
  );
}

DiseaseDto _diseaseFixture() {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_diseases__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  return DiseaseDto.fromJson(json);
}
