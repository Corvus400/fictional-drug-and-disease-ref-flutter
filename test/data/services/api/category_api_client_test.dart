import 'package:dio/dio.dart';
import 'package:fictional_drug_and_disease_ref/data/services/api/category_api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CategoryApiClient can be constructed with Dio', () {
    final client = CategoryApiClient(Dio());

    expect(client, isA<CategoryApiClient>());
  });
}
