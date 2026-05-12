import 'package:fictional_drug_and_disease_ref/application/bookmarks/disease_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/bookmarks/drug_bookmark_snapshot_codec.dart';
import 'package:fictional_drug_and_disease_ref/application/usecases/resolve_bookmark_rows_usecase.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/bookmark/bookmark_entry.dart';
import 'package:fictional_drug_and_disease_ref/domain/disease/disease_summary.dart';
import 'package:fictional_drug_and_disease_ref/domain/drug/drug_summary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResolveBookmarkRowsUsecase', () {
    const usecase = ResolveBookmarkRowsUsecase(
      drugCodec: DrugBookmarkSnapshotCodec(),
      diseaseCodec: DiseaseBookmarkSnapshotCodec(),
    );

    test('decodes drug and disease bookmark snapshots', () {
      final result = usecase.execute([
        BookmarkEntry(
          id: _drugSummary.id,
          snapshotJson: const DrugBookmarkSnapshotCodec().encode(_drugSummary),
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        ),
        BookmarkEntry(
          id: _diseaseSummary.id,
          snapshotJson: const DiseaseBookmarkSnapshotCodec().encode(
            _diseaseSummary,
          ),
          bookmarkedAt: DateTime.utc(2026, 5, 9),
        ),
      ]);

      expect(result, isA<Ok<List<ResolvedBookmarkRow>>>());
      final rows = (result as Ok<List<ResolvedBookmarkRow>>).value;
      expect(rows, hasLength(2));
      expect(rows[0], isA<ResolvedBookmarkDrugRow>());
      expect((rows[0] as ResolvedBookmarkDrugRow).summary.brandName, 'Norvasc');
      expect(rows[0].bookmarkedAt, DateTime.utc(2026, 5, 10));
      expect(rows[1], isA<ResolvedBookmarkDiseaseRow>());
      expect(
        (rows[1] as ResolvedBookmarkDiseaseRow).summary.name,
        '高血圧症',
      );
      expect(rows[1].bookmarkedAt, DateTime.utc(2026, 5, 9));
    });

    test('returns error when one snapshot cannot be decoded', () {
      final result = usecase.execute([
        BookmarkEntry(
          id: 'drug_broken',
          snapshotJson: '{"id":"drug_broken"}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        ),
      ]);

      expect(result, isA<Err<List<ResolvedBookmarkRow>>>());
      expect(
        (result as Err<List<ResolvedBookmarkRow>>).error,
        isA<ParseException>(),
      );
    });

    test('returns error when one id prefix is unknown', () {
      final result = usecase.execute([
        BookmarkEntry(
          id: 'unknown_001',
          snapshotJson: '{}',
          bookmarkedAt: DateTime.utc(2026, 5, 10),
        ),
      ]);

      expect(result, isA<Err<List<ResolvedBookmarkRow>>>());
      expect(
        (result as Err<List<ResolvedBookmarkRow>>).error,
        isA<ParseException>(),
      );
    });
  });
}

const _drugSummary = DrugSummary(
  id: 'drug_001',
  brandName: 'Norvasc',
  genericName: 'Amlodipine',
  therapeuticCategoryName: 'Ca拮抗薬',
  regulatoryClass: ['prescription_required'],
  dosageForm: 'tablet',
  brandNameKana: 'ノルバスク',
  atcCode: 'C08CA01',
  revisedAt: '2026-01-01',
  imageUrl: '/v1/images/drugs/drug_001',
);

const _diseaseSummary = DiseaseSummary(
  id: 'disease_001',
  name: '高血圧症',
  icd10Chapter: 'IX',
  medicalDepartment: ['cardiology'],
  chronicity: 'chronic',
  infectious: false,
  nameKana: 'コウケツアツショウ',
  revisedAt: '2026-01-01',
);
