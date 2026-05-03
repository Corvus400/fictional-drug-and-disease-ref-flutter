import 'dart:typed_data';

import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/image_api_service.dart';

/// Repository for image retrieval with drug-to-dosage-form fallback.
final class ImageRepository {
  /// Creates an image repository.
  const ImageRepository(this._service);

  final ImageApiService _service;

  /// Fetches a drug image, falling back to its dosage-form image on NOT_FOUND.
  Future<Result<Uint8List>> getDrugImage({
    required String drugId,
    required String dosageForm,
    String size = 'Original',
  }) async {
    final result = await _service.getDrugImage(drugId, size: size);
    return switch (result) {
      Ok<Uint8List>() => result,
      Err<Uint8List>(:final error) when _isNotFound(error) =>
        _service.getDosageFormImage(dosageForm, size: size),
      Err<Uint8List>() => result,
    };
  }

  /// Fetches a dosage-form image.
  Future<Result<Uint8List>> getDosageFormImage(
    String dosageForm, {
    String size = 'Original',
  }) {
    return _service.getDosageFormImage(dosageForm, size: size);
  }
}

bool _isNotFound(AppException error) {
  return error is ApiException &&
      error.statusCode == 404 &&
      error.code == 'NOT_FOUND';
}
