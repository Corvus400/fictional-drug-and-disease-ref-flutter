import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/bootstrap.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';

/// Starts the dev flavor.
void main() {
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );
  ApiConfig.initialize(
    const FlavorConfig(flavor: Flavor.dev, apiBaseUrl: baseUrl),
  );
  bootstrap(App.new);
}
