import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/browsing_history/name_resolution_cache.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_browsing_history_names_usecase.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/bookmark_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/disease_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/drug_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:fictional_drug_and_disease_ref/domain/browsing_history/browsing_history_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_app_database.dart';

void main() {
  group('ResolveBrowsingHistoryNamesUsecase', () {
    late AppDatabase db;
    late BookmarkRepository bookmarkRepository;
    late ResolveBrowsingHistoryNamesUsecase usecase;
    const drugCodec = DrugBookmarkSnapshotCodec();
    const diseaseCodec = DiseaseBookmarkSnapshotCodec();

    setUp(() {
      db = createTestAppDatabase();
      bookmarkRepository = BookmarkRepository(db.bookmarksDao);
      usecase = ResolveBrowsingHistoryNamesUsecase(
        bookmarkRepository: bookmarkRepository,
        drugRepository: DrugRepository(_MockDrugApiClient()),
        diseaseRepository: DiseaseRepository(_MockDiseaseApiClient()),
        drugCodec: drugCodec,
        diseaseCodec: diseaseCodec,
        cache: NameResolutionCache(capacity: 4),
      );
    });

    tearDown(() async {
      await clearTestAppDatabase(db);
      await db.close();
    });

    test(
      'execute resolves drug and disease names from bookmark snapshots',
      () async {
        await bookmarkRepository.insert(
          id: _drugSummary.id,
          snapshotJson: drugCodec.encode(_drugSummary),
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        await bookmarkRepository.insert(
          id: _diseaseSummary.id,
          snapshotJson: diseaseCodec.encode(_diseaseSummary),
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        );
        final entries = [
          BrowsingHistoryEntry(
            id: _drugSummary.id,
            viewedAt: DateTime.utc(2026, 5, 11),
          ),
          BrowsingHistoryEntry(
            id: _diseaseSummary.id,
            viewedAt: DateTime.utc(2026, 5, 11),
          ),
        ];

        final first = await usecase.execute(entries);

        expect(first[_drugSummary.id], isA<NameResolvedDrug>());
        expect(
          (first[_drugSummary.id]! as NameResolvedDrug).summary.brandName,
          _drugSummary.brandName,
        );
        expect(first[_diseaseSummary.id], isA<NameResolvedDisease>());
        expect(
          (first[_diseaseSummary.id]! as NameResolvedDisease).summary.name,
          _diseaseSummary.name,
        );

        await bookmarkRepository.deleteById(_drugSummary.id);
        final cached = await usecase.execute([entries.first]);

        expect(cached[_drugSummary.id], isA<NameResolvedDrug>());
        expect(
          (cached[_drugSummary.id]! as NameResolvedDrug).summary.brandName,
          _drugSummary.brandName,
        );
      },
    );
  });
}

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'アムロジン錠5mg',
  genericName: 'アムロジピンベシル酸塩',
  therapeuticCategoryName: '持続性Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'アムロジンジョウ',
  atcCode: 'C08CA01',
  revisedAt: '2026-05-10',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '本態性高血圧症',
  icd10Chapter: 'IX',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'ホンタイセイコウケツアツショウ',
  revisedAt: '2026-05-10',
);

final class _MockDrugApiClient extends Mock implements DrugApiClient {}

final class _MockDiseaseApiClient extends Mock implements DiseaseApiClient {}
