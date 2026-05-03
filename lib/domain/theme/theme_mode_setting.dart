/// Persistable theme-mode setting.
enum ThemeModeSetting {
  /// Follow the system theme.
  system('system'),

  /// Force light theme.
  light('light'),

  /// Force dark theme.
  dark('dark')
  ;

  const ThemeModeSetting(this.storageValue);

  /// Value stored in shared_preferences.
  final String storageValue;

  /// Restores a theme mode from a stored value.
  static ThemeModeSetting fromStorageValue(String value) {
    for (final mode in values) {
      if (mode.storageValue == value) {
        return mode;
      }
    }
    return ThemeModeSetting.system;
  }
}
