import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeModeSetting', () {
    test('storageValue exposes shared_preferences values', () {
      expect(ThemeModeSetting.system.storageValue, 'system');
      expect(ThemeModeSetting.light.storageValue, 'light');
      expect(ThemeModeSetting.dark.storageValue, 'dark');
    });

    test('fromStorageValue restores enum value', () {
      expect(
        ThemeModeSetting.fromStorageValue('system'),
        ThemeModeSetting.system,
      );
      expect(
        ThemeModeSetting.fromStorageValue('light'),
        ThemeModeSetting.light,
      );
      expect(ThemeModeSetting.fromStorageValue('dark'), ThemeModeSetting.dark);
    });
  });
}
