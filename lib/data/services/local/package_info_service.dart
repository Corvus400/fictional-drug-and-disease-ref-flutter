import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Loads app package metadata from the platform.
class PackageInfoService {
  /// Creates a package info service.
  const PackageInfoService({
    Future<PackageInfo> Function()? packageInfoLoader,
  }) : _packageInfoLoader = packageInfoLoader ?? PackageInfo.fromPlatform;

  final Future<PackageInfo> Function() _packageInfoLoader;

  /// Reads app package metadata.
  Future<Result<AppPackageInfo>> read() async {
    try {
      final packageInfo = await _packageInfoLoader();
      return Result.ok(
        AppPackageInfo(
          version: packageInfo.version,
          buildNumber: packageInfo.buildNumber,
        ),
      );
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
