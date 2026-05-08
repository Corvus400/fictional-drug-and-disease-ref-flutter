import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/drug_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_exam_table.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/widgets/drug_detail_related_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  testWidgets('DrugDetailRelatedTab renders D18 carousel and navigates by id', (
    tester,
  ) async {
    final drug = _drugFixture().toDomain();
    final diseaseDto = _diseaseFixture();
    final diseaseId = drug.relatedDiseaseIds.single;
    final apiClient = _MockDiseaseApiClient();
    when(
      () => apiClient.getDisease(diseaseId),
    ).thenAnswer((_) async => diseaseDto);
    final router = GoRouter(
      initialLocation: AppRoutes.search,
      routes: [
        GoRoute(
          path: AppRoutes.search,
          builder: (context, state) => SingleChildScrollView(
            child: DrugDetailRelatedTab(drug: drug),
          ),
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
      ProviderScope(
        overrides: [diseaseApiClientProvider.overrideWithValue(apiClient)],
        child: MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DetailPanel), findsNWidgets(3));
    expect(find.text('D16'), findsOneWidget);
    expect(find.text('取扱い・包装・保険'), findsOneWidget);
    expect(find.byType(DetailExamTable), findsOneWidget);
    expect(find.text(drug.packages.first.size), findsOneWidget);
    expect(find.textContaining('冷所・遮光・防湿'), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('detail-exam-category-pill-0')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey<String>('detail-exam-cell-category-0')),
      findsOneWidget,
    );
    expect(find.text('D17'), findsOneWidget);
    expect(find.text('承認条件・参考文献'), findsOneWidget);
    expect(
      find.textContaining(drug.approvalConditions.first.content),
      findsOneWidget,
    );
    expect(find.text('D18'), findsOneWidget);
    expect(find.text('関連疾患'), findsOneWidget);
    expect(find.byType(DetailCarousel), findsOneWidget);
    expect(find.byType(DetailCarouselCard), findsWidgets);
    final relatedDiseaseCardSize = tester.getSize(
      find.byKey(const ValueKey<String>('detail-carousel-card')).first,
    );
    expect(
      relatedDiseaseCardSize.width,
      lessThanOrEqualTo(DetailConstants.carouselCardMaxWidth),
    );
    expect(
      find.byKey(const ValueKey<String>('detail-carousel-card-image')),
      findsNothing,
    );
    expect(find.byType(ListView), findsNothing);
    expect(find.text(diseaseId), findsOneWidget);
    expect(find.text(diseaseDto.name), findsOneWidget);
    expect(find.text('慢性'), findsOneWidget);

    await tester.ensureVisible(find.text(diseaseDto.name));
    await tester.tap(find.text(diseaseDto.name));
    await tester.pumpAndSettle();

    expect(find.text('disease-detail-$diseaseId'), findsOneWidget);
    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      AppRoutes.diseaseDetail(diseaseId),
    );
  });

  testWidgets('DrugDetailRelatedTab localizes storage temperature enums', (
    tester,
  ) async {
    final drug = _drugFixture(
      storageTemperatures: ['room_temperature', 'cold', 'frozen'],
    ).toDomain();
    final apiClient = _MockDiseaseApiClient();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [diseaseApiClientProvider.overrideWithValue(apiClient)],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: DrugDetailRelatedTab(drug: drug),
            ),
          ),
        ),
      ),
    );

    expect(find.text('室温'), findsOneWidget);
    expect(find.text('冷所'), findsOneWidget);
    expect(find.text('冷凍'), findsOneWidget);
    expect(find.textContaining('room_temperature'), findsNothing);
    expect(find.textContaining('frozen'), findsNothing);
  });
}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}

DrugDto _drugFixture({List<String>? storageTemperatures}) {
  final json =
      jsonDecode(
            File(
              'test/fixtures/swagger/get_v1_drugs__id_.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  if (storageTemperatures != null) {
    final packages = json['packages'] as List<dynamic>;
    final firstPackage = packages.first as Map<String, dynamic>;
    json['packages'] = [
      for (final (index, temperature) in storageTemperatures.indexed)
        {
          ...firstPackage,
          'size': '包装 ${index + 1}',
          'storage_condition': {
            ...(firstPackage['storage_condition'] as Map<String, dynamic>),
            'temperature': temperature,
            'light_protection': false,
            'moisture_protection': false,
            'additional_note': null,
          },
        },
    ];
  }
  return DrugDto.fromJson(json);
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
