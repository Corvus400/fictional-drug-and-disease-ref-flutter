// Freezed applies JsonSerializable annotations to the generated class.
// ignore_for_file: invalid_annotation_target

import 'package:fictional_drug_and_disease_ref/data/dto/drug/drug_summary_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drug_list_response_dto.freezed.dart';
part 'drug_list_response_dto.g.dart';

/// Drug list envelope DTO returned by `/v1/drugs`.
@freezed
abstract class DrugListResponseDto with _$DrugListResponseDto {
  /// Creates a drug list response DTO.
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DrugListResponseDto({
    required List<DrugSummaryDto> items,
    required int page,
    required int pageSize,
    required int totalPages,
    required int totalCount,
    required String disclaimer,
  }) = _DrugListResponseDto;

  /// Creates a DTO from JSON.
  factory DrugListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DrugListResponseDtoFromJson(json);
}
