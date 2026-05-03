// Freezed applies JsonSerializable annotations to the generated class.
// ignore_for_file: invalid_annotation_target

import 'package:fictional_drug_and_disease_ref/data/dto/disease/disease_summary_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'disease_list_response_dto.freezed.dart';
part 'disease_list_response_dto.g.dart';

/// Disease list envelope DTO returned by `/v1/diseases`.
@freezed
abstract class DiseaseListResponseDto with _$DiseaseListResponseDto {
  /// Creates a disease list response DTO.
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DiseaseListResponseDto({
    required List<DiseaseSummaryDto> items,
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalCount,
    required String disclaimer,
  }) = _DiseaseListResponseDto;

  /// Creates a DTO from JSON.
  factory DiseaseListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DiseaseListResponseDtoFromJson(json);
}
