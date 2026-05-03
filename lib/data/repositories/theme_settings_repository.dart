import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:fictional_drug_and_disease_ref/data/services/local/theme_settings_service.dart';
import 'package:fictional_drug_and_disease_ref/domain/theme/theme_mode_setting.dart';

/// Repository for theme-mode settings.
final class ThemeSettingsRepository {
  /// Creates a theme settings repository.
  const ThemeSettingsRepository(this._service);

  final ThemeSettingsService _service;

  /// Reads the theme mode setting.
  Future<Result<ThemeModeSetting>> read() async {
    final result = await _service.read();
    return switch (result) {
      Ok<String>(:final value) => Result.ok(
        ThemeModeSetting.fromStorageValue(value),
      ),
      Err<String>(:final error) => Result.error(error),
    };
  }

  /// Writes the theme mode setting.
  Future<Result<void>> write(ThemeModeSetting mode) {
    return _service.write(mode.storageValue);
  }
}
