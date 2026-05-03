import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';

/// Starts the prod flavor.
void main() {
  const baseUrl = String.fromEnvironment('API_BASE_URL');
  if (baseUrl.isEmpty) {
    throw StateError('prod flavor requires --dart-define=API_BASE_URL=...');
  }
  ApiConfig.initialize(
    const FlavorConfig(flavor: Flavor.prod, apiBaseUrl: baseUrl),
  );
  bootstrap(() => const App());
}
