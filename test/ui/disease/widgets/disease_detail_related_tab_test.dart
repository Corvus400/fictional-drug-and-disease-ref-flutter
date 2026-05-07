import 'dart:convert';
import 'dart:io';

import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_dto.dart';
import 'package:fictional_drug_and_disease_ref/data/mappers/disease_mapper.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:fictional_drug_and_disease_ref/router/app_router.dart';
import 'package:fictional_drug_and_disease_ref/theme/app_theme.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/constants/detail_constants.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_carousel.dart';
import 'package:fictional_drug_and_disease_ref/ui/detail/widgets/detail_panel.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/widgets/disease_detail_related_tab.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() {
    ApiConfig.initialize(
      const FlavorConfig(
        flavor: Flavor.dev,
        apiBaseUrl: 'https://api.example.test',
      ),
    );
  });

  testWidgets(
    'DiseaseDetailRelatedTab renders E15 carousel and navigates by id',
    (
      tester,
    ) async {
      final disease = _diseaseFixture().toDomain();
      final drugDto = _drugFixture();
      final drugId = disease.relatedDrugIds.single;
      final apiClient = _MockDrugApiClient();
      final cacheManager = _MockBaseCacheManager();
      final imageFile = _writeTestImageFile('related-drug-card.png');
      when(() => apiClient.getDrug(drugId)).thenAnswer((_) async => drugDto);
      when(
        () => cacheManager.getSingleFile(
          any(),
          key: any(named: 'key'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => imageFile);
      final router = GoRouter(
        initialLocation: AppRoutes.search,
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => DiseaseDetailRelatedTab(
              disease: disease,
              cacheManager: cacheManager,
            ),
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
        ProviderScope(
          overrides: [drugApiClientProvider.overrideWithValue(apiClient)],
          child: MaterialApp.router(
            routerConfig: router,
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(DetailPanel), findsNWidgets(2));
      expect(find.text('E15'), findsOneWidget);
      expect(find.text('関連医薬品'), findsWidgets);
      expect(find.byType(DetailCarousel), findsWidgets);
      expect(
        find.byKey(const ValueKey<String>('detail-related-drug-card')),
        findsOneWidget,
      );
      final relatedDrugCardSize = tester.getSize(
        find.byKey(const ValueKey<String>('detail-related-drug-card')),
      );
      expect(
        relatedDrugCardSize.width,
        lessThanOrEqualTo(DetailConstants.relatedDrugCardMaxWidth),
      );
      expect(
        tester
            .widget<SizedBox>(
              find.byKey(
                const ValueKey<String>('detail-related-drug-image-text-gap'),
              ),
            )
            .width,
        DetailConstants.relatedDrugCardImageTextGap,
      );
      expect(find.text(drugId), findsOneWidget);
      expect(find.text(drugDto.brandName), findsOneWidget);
      expect(
        find.byKey(ValueKey<String>('detail-related-drug-image-$drugId')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('detail-carousel-card-image')),
        findsNothing,
      );
      expect(find.text('液剤'), findsOneWidget);
      expect(find.text('内服'), findsOneWidget);
      expect(find.text('E16'), findsOneWidget);
      expect(find.text('関連疾患'), findsWidgets);
      expect(find.textContaining('E17'), findsOneWidget);
      expect(find.textContaining(disease.revisedAt), findsOneWidget);

      await tester.tap(find.text(drugDto.brandName));
      await tester.pumpAndSettle();

      expect(find.text('drug-detail-$drugId'), findsOneWidget);
      expect(
        router.routerDelegate.currentConfiguration.last.matchedLocation,
        AppRoutes.drugDetail(drugId),
      );
      verify(
        () => cacheManager.getSingleFile(
          'https://api.example.test/v1/images/drugs/$drugId?size=M',
          key:
              'detail-related-drug-card-image-v1::'
              'https://api.example.test/v1/images/drugs/$drugId?size=M',
          headers: any(named: 'headers'),
        ),
      ).called(1);
    },
  );
}

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockBaseCacheManager extends Mock implements BaseCacheManager {}

file.File _writeTestImageFile(String name) {
  const fileSystem = LocalFileSystem();
  final ioFile = File('${Directory.systemTemp.path}/$name');
  final bytes = base64Decode(
    'iVBORw0KGgoAAAANSUhEUgAAAAIAAAADCAYAAAC56t6BAAAAG0lEQVR4nGPQj978/'
    '86GG/8Z/gMBiMMA4oEAAPBbEzen1b62AAAAAElFTkSuQmCC',
  );
  ioFile.writeAsBytesSync(bytes);
  return fileSystem.file(ioFile.path);
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
