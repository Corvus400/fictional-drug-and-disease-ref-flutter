import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/repositories/theme_settings_repository.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/theme_settings_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('ThemeSettingsRepository', () {
    late _MockThemeSettingsService service;
    late ThemeSettingsRepository repository;

    setUp(() {
      service = _MockThemeSettingsService();
      repository = ThemeSettingsRepository(service);
    });

    test('read maps stored string to ThemeModeSetting', () async {
      when(() => service.read()).thenAnswer(
        (_) async => const Result.ok('dark'),
      );

      final result = await repository.read();

      expect(result, isA<Ok<ThemeModeSetting>>());
      expect((result as Ok<ThemeModeSetting>).value, ThemeModeSetting.dark);
    });

    test('write passes storage value to service', () async {
      when(() => service.write('light')).thenAnswer(
        (_) async => const Result.ok(null),
      );

      final result = await repository.write(ThemeModeSetting.light);

      expect(result, isA<Ok<void>>());
      verify(() => service.write('light')).called(1);
    });
  });
}

final class _MockThemeSettingsService extends Mock
    implements ThemeSettingsService {}
