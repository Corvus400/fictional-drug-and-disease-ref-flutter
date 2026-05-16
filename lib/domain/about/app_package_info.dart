/// App package metadata required by about/license UI.
final class AppPackageInfo {
  /// Creates app package metadata.
  const AppPackageInfo({
    required this.version,
    required this.buildNumber,
  });

  /// App version name.
  final String version;

  /// App build number.
  final String buildNumber;
}
