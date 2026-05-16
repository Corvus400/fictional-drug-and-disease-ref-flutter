import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/package_info_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/package_info_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/about/app_package_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('PackageInfoRepository', () {
    late _MockPackageInfoService service;
    late PackageInfoRepository repository;

    setUp(() {
      service = _MockPackageInfoService();
      repository = PackageInfoRepository(service);
    });

    test('read returns package info from service', () async {
      const info = AppPackageInfo(version: '1.0.0', buildNumber: '1');
      when(() => service.read()).thenAnswer((_) async => const Result.ok(info));

      final result = await repository.read();

      expect(result, isA<Ok<AppPackageInfo>>());
      expect((result as Ok<AppPackageInfo>).value, info);
      verify(() => service.read()).called(1);
    });

    test('read returns service errors unchanged', () async {
      const error = UnknownException();
      when(
        () => service.read(),
      ).thenAnswer((_) async => const Result.error(error));

      final result = await repository.read();

      expect(result, isA<Err<AppPackageInfo>>());
      expect((result as Err<AppPackageInfo>).error, error);
      verify(() => service.read()).called(1);
    });
  });
}

final class _MockPackageInfoService extends Mock
    implements PackageInfoService {}
