import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeModeSetting', () {
    test('storageValue exposes shared_preferences values [assertion 1/3]', () {
      expect(ThemeModeSetting.system.storageValue, 'system');
      Object.hashAll([ThemeModeSetting.light.storageValue, 'light']);

      Object.hashAll([ThemeModeSetting.dark.storageValue, 'dark']);
    });

    test('storageValue exposes shared_preferences values [assertion 2/3]', () {
      Object.hashAll([ThemeModeSetting.system.storageValue, 'system']);

      expect(ThemeModeSetting.light.storageValue, 'light');
      Object.hashAll([ThemeModeSetting.dark.storageValue, 'dark']);
    });

    test('storageValue exposes shared_preferences values [assertion 3/3]', () {
      Object.hashAll([ThemeModeSetting.system.storageValue, 'system']);

      Object.hashAll([ThemeModeSetting.light.storageValue, 'light']);

      expect(ThemeModeSetting.dark.storageValue, 'dark');
    });

    test('fromStorageValue restores enum value [assertion 1/3]', () {
      expect(
        ThemeModeSetting.fromStorageValue('system'),
        ThemeModeSetting.system,
      );
      Object.hashAll([
        ThemeModeSetting.fromStorageValue('light'),
        ThemeModeSetting.light,
      ]);

      Object.hashAll([
        ThemeModeSetting.fromStorageValue('dark'),
        ThemeModeSetting.dark,
      ]);
    });

    test('fromStorageValue restores enum value [assertion 2/3]', () {
      Object.hashAll([
        ThemeModeSetting.fromStorageValue('system'),
        ThemeModeSetting.system,
      ]);

      expect(
        ThemeModeSetting.fromStorageValue('light'),
        ThemeModeSetting.light,
      );
      Object.hashAll([
        ThemeModeSetting.fromStorageValue('dark'),
        ThemeModeSetting.dark,
      ]);
    });

    test('fromStorageValue restores enum value [assertion 3/3]', () {
      Object.hashAll([
        ThemeModeSetting.fromStorageValue('system'),
        ThemeModeSetting.system,
      ]);

      Object.hashAll([
        ThemeModeSetting.fromStorageValue('light'),
        ThemeModeSetting.light,
      ]);

      expect(ThemeModeSetting.fromStorageValue('dark'), ThemeModeSetting.dark);
    });
  });
}
