import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:fictional_drug_and_disease_ref/domain/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/domain/usecases/view_drug_detail_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// View-drug-detail use case provider.
final viewDrugDetailUsecaseProvider = Provider<ViewDrugDetailUsecase>(
  (ref) => ViewDrugDetailUsecase(
    drugRepository: ref.watch(drugRepositoryProvider),
    browsingHistoryRepository: ref.watch(browsingHistoryRepositoryProvider),
    bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
  ),
);

/// View-disease-detail use case provider.
final viewDiseaseDetailUsecaseProvider = Provider<ViewDiseaseDetailUsecase>(
  (ref) => ViewDiseaseDetailUsecase(
    diseaseRepository: ref.watch(diseaseRepositoryProvider),
    browsingHistoryRepository: ref.watch(browsingHistoryRepositoryProvider),
    bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
  ),
);
