import 'package:fictional_drug_and_disease_ref/application/usecases/observe_bookmark_state_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_disease_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/view_drug_detail_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/api_providers.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
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

/// Observe-bookmark-state use case provider.
final observeBookmarkStateUsecaseProvider =
    Provider<ObserveBookmarkStateUsecase>(
      (ref) => ObserveBookmarkStateUsecase(
        bookmarkRepository: ref.watch(bookmarkRepositoryProvider),
      ),
    );
