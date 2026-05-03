import 'package:fictional_drug_and_disease_ref/core/error/app_exception.dart';
import 'package:fictional_drug_and_disease_ref/core/error/exception_mapper.dart';
import 'package:fictional_drug_and_disease_ref/core/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModeKey = 'theme_mode';
const _systemThemeMode = 'system';
const _allowedThemeModes = {'system', 'light', 'dark'};

/// Local service for persisted theme-mode settings.
class ThemeSettingsService {
  /// Creates a theme settings service.
  const ThemeSettingsService(this._prefsFuture);

  final Future<SharedPreferences> _prefsFuture;

  /// Reads the stored theme mode string.
  Future<Result<String>> read() async {
    final prefs = await _prefsFuture;
    return Result.ok(prefs.getString(_themeModeKey) ?? _systemThemeMode);
  }

  /// Writes the theme mode string.
  Future<Result<void>> write(String mode) async {
    if (!_allowedThemeModes.contains(mode)) {
      return const Result.error(
        StorageException(kind: StorageErrorKind.prefsWriteFailed),
      );
    }

    try {
      final prefs = await _prefsFuture;
      await prefs.setString(_themeModeKey, mode);
      return const Result.ok(null);
    } on Object catch (error) {
      return Result.error(toAppException(error));
    }
  }
}
