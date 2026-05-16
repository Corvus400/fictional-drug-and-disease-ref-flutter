import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/package_info_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';

/// Repository for app package metadata.
final class PackageInfoRepository {
  /// Creates a package info repository.
  const PackageInfoRepository(this._service);

  final PackageInfoService _service;

  /// Reads app package metadata.
  Future<Result<AppPackageInfo>> read() {
    return _service.read();
  }
}
