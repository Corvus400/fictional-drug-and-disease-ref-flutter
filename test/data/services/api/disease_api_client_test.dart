import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/disease_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DiseaseApiClient can be constructed with Dio', () {
    final client = DiseaseApiClient(Dio());

    expect(client, isA<DiseaseApiClient>());
  });
}
