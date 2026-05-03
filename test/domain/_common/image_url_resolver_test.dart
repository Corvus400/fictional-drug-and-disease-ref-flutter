import 'package:fictional_drug_and_disease_ref/domain/_common/image_url_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolveImageUrl joins baseUrl and relative imageUrl', () {
    final resolved = resolveImageUrl(
      baseUrl: 'https://api.example.test',
      imageUrl: '/v1/images/dosage-forms/tablet?size=Original',
    );

    expect(
      resolved,
      Uri.parse(
        'https://api.example.test/v1/images/dosage-forms/tablet?size=Original',
      ),
    );
  });
}
