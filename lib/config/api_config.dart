import 'package:fictional_drug_and_disease_ref/config/flavor.dart';

/// Single source of truth for API configuration.
class ApiConfig {
  const ApiConfig._();

  /// HTTP connection timeout.
  static const connectTimeout = Duration(seconds: 10);

  /// HTTP receive timeout.
  static const receiveTimeout = Duration(seconds: 15);

  static FlavorConfig? _current;

  /// Current flavor configuration.
  static FlavorConfig get current =>
      _current ?? (throw StateError('FlavorConfig not initialized'));

  /// Initializes the API configuration once at app startup.
  // ignore: use_setters_to_change_properties
  static void initialize(FlavorConfig config) => _current = config;
}
