/// Application flavor.
enum Flavor {
  /// Development flavor.
  dev,

  /// Production flavor.
  prod,
}

/// Flavor-specific application configuration.
class FlavorConfig {
  /// Creates a flavor configuration.
  const FlavorConfig({required this.flavor, required this.apiBaseUrl});

  /// Active flavor.
  final Flavor flavor;

  /// Base URL for API calls.
  final String apiBaseUrl;
}
