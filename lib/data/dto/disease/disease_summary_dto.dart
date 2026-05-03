// Freezed applies JsonSerializable annotations to the generated class.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'disease_summary_dto.freezed.dart';
part 'disease_summary_dto.g.dart';

/// Disease summary DTO returned by `/v1/diseases`.
@freezed
abstract class DiseaseSummaryDto with _$DiseaseSummaryDto {
  /// Creates a disease summary DTO.
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DiseaseSummaryDto({
    required String id,
    required String name,
    required String icd10Chapter,
    required List<String> medicalDepartment,
    required String chronicity,
    required bool infectious,
    required String nameKana,
    required String revisedAt,
  }) = _DiseaseSummaryDto;

  /// Creates a DTO from JSON.
  factory DiseaseSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$DiseaseSummaryDtoFromJson(json);
}
