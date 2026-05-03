import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';

/// API service for PNG image endpoints.
class ImageApiService {
  /// Creates an image API service.
  const ImageApiService(this._dio);

  final Dio _dio;

  /// Fetches a dosage-form image.
  Future<Result<Uint8List>> getDosageFormImage(
    String form, {
    String size = 'Original',
  }) async {
    try {
      final response = await _dio.get<Uint8List>(
        '/v1/images/dosage-forms/$form',
        queryParameters: {'size': size},
      );
      return Result.ok(response.data ?? Uint8List(0));
    } on DioException catch (error) {
      return Result.error(_toImageException(error));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }

  /// Fetches a drug-specific image.
  Future<Result<Uint8List>> getDrugImage(
    String drugId, {
    String size = 'Original',
  }) async {
    try {
      final response = await _dio.get<Uint8List>(
        '/v1/images/drugs/$drugId',
        queryParameters: {'size': size},
      );
      return Result.ok(response.data ?? Uint8List(0));
    } on DioException catch (error) {
      return Result.error(_toImageException(error));
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}

AppException _toImageException(DioException error) {
  if (error.response?.statusCode == 404) {
    return ApiException(
      statusCode: 404,
      code: 'NOT_FOUND',
      message: 'Image not found',
      cause: error,
    );
  }
  return toAppException(error);
}
