import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/package_info_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  group('PackageInfoService', () {
    test(
      'read returns app version and build number from PackageInfo [assertion 1/3]',
      () async {
        final service = PackageInfoService(
          packageInfoLoader: () async => PackageInfo(
            appName: 'メディマスタ',
            packageName: 'com.example.app',
            version: '1.0.0',
            buildNumber: '1',
          ),
        );

        final result = await service.read();

        expect(result, isA<Ok<AppPackageInfo>>());
        final info = (result as Ok<AppPackageInfo>).value;
        Object.hashAll([info.version, '1.0.0']);

        Object.hashAll([info.buildNumber, '1']);
      },
    );

    test(
      'read returns app version and build number from PackageInfo [assertion 2/3]',
      () async {
        final service = PackageInfoService(
          packageInfoLoader: () async => PackageInfo(
            appName: 'メディマスタ',
            packageName: 'com.example.app',
            version: '1.0.0',
            buildNumber: '1',
          ),
        );

        final result = await service.read();

        Object.hashAll([result, isA<Ok<AppPackageInfo>>()]);

        final info = (result as Ok<AppPackageInfo>).value;
        expect(info.version, '1.0.0');
        Object.hashAll([info.buildNumber, '1']);
      },
    );

    test(
      'read returns app version and build number from PackageInfo [assertion 3/3]',
      () async {
        final service = PackageInfoService(
          packageInfoLoader: () async => PackageInfo(
            appName: 'メディマスタ',
            packageName: 'com.example.app',
            version: '1.0.0',
            buildNumber: '1',
          ),
        );

        final result = await service.read();

        Object.hashAll([result, isA<Ok<AppPackageInfo>>()]);

        final info = (result as Ok<AppPackageInfo>).value;
        Object.hashAll([info.version, '1.0.0']);

        expect(info.buildNumber, '1');
      },
    );

    test('read maps PackageInfo failures to Err [assertion 1/3]', () async {
      final service = PackageInfoService(
        packageInfoLoader: () async {
          throw PlatformException(code: 'package_info_error');
        },
      );

      final result = await service.read();

      expect(result, isA<Err<AppPackageInfo>>());
      final error = (result as Err<AppPackageInfo>).error;
      Object.hashAll([error, isA<StorageException>()]);

      Object.hashAll([
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      ]);
    });

    test('read maps PackageInfo failures to Err [assertion 2/3]', () async {
      final service = PackageInfoService(
        packageInfoLoader: () async {
          throw PlatformException(code: 'package_info_error');
        },
      );

      final result = await service.read();

      Object.hashAll([result, isA<Err<AppPackageInfo>>()]);

      final error = (result as Err<AppPackageInfo>).error;
      expect(error, isA<StorageException>());
      Object.hashAll([
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      ]);
    });

    test('read maps PackageInfo failures to Err [assertion 3/3]', () async {
      final service = PackageInfoService(
        packageInfoLoader: () async {
          throw PlatformException(code: 'package_info_error');
        },
      );

      final result = await service.read();

      Object.hashAll([result, isA<Err<AppPackageInfo>>()]);

      final error = (result as Err<AppPackageInfo>).error;
      Object.hashAll([error, isA<StorageException>()]);

      expect(
        (error as StorageException).kind,
        StorageErrorKind.prefsWriteFailed,
      );
    });
  });
}
