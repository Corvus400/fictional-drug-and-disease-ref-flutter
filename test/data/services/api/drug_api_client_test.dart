import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/drug_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DrugApiClient can be constructed with Dio', () {
    final client = DrugApiClient(Dio());

    expect(client, isA<DrugApiClient>());
  });
}
