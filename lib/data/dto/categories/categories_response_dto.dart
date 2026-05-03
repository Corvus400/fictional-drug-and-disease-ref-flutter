// Freezed applies JsonSerializable annotations to the generated class.
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_response_dto.freezed.dart';
part 'categories_response_dto.g.dart';

/// ATC category entry DTO.
@freezed
abstract class AtcEntryDto with _$AtcEntryDto {
  /// Creates an ATC category entry DTO.
  const factory AtcEntryDto({
    required String code,
    required String label,
  }) = _AtcEntryDto;

  /// Creates a DTO from JSON.
  factory AtcEntryDto.fromJson(Map<String, dynamic> json) =>
      _$AtcEntryDtoFromJson(json);
}

/// Therapeutic category entry DTO.
@freezed
abstract class TherapeuticCategoryEntryDto with _$TherapeuticCategoryEntryDto {
  /// Creates a therapeutic category entry DTO.
  const factory TherapeuticCategoryEntryDto({
    required String id,
    required String label,
  }) = _TherapeuticCategoryEntryDto;

  /// Creates a DTO from JSON.
  factory TherapeuticCategoryEntryDto.fromJson(Map<String, dynamic> json) =>
      _$TherapeuticCategoryEntryDtoFromJson(json);
}

/// ICD-10 chapter entry DTO.
@freezed
abstract class Icd10ChapterEntryDto with _$Icd10ChapterEntryDto {
  /// Creates an ICD-10 chapter entry DTO.
  const factory Icd10ChapterEntryDto({
    required String roman,
    required String code,
    required String label,
  }) = _Icd10ChapterEntryDto;

  /// Creates a DTO from JSON.
  factory Icd10ChapterEntryDto.fromJson(Map<String, dynamic> json) =>
      _$Icd10ChapterEntryDtoFromJson(json);
}

/// Categories response DTO returned by `/v1/categories`.
@freezed
abstract class CategoriesResponseDto with _$CategoriesResponseDto {
  /// Creates a categories response DTO.
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategoriesResponseDto({
    required List<AtcEntryDto> atc,
    required List<TherapeuticCategoryEntryDto> therapeuticCategories,
    required List<String> routeOfAdministration,
    required List<String> dosageForm,
    required List<String> regulatoryClass,
    required List<Icd10ChapterEntryDto> icd10Chapters,
    required List<String> medicalDepartments,
  }) = _CategoriesResponseDto;

  /// Creates a DTO from JSON.
  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseDtoFromJson(json);
}
