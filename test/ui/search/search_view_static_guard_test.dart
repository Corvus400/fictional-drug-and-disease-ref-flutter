import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'SearchView does not contain fixed sample data or filter selections',
    () {
      final sources = [
        ...Directory('lib/ui/search')
            .listSync(recursive: true)
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart'))
            .map((file) => file.readAsStringSync()),
        File('lib/ui/_common/widgets/drug_result_card.dart').readAsStringSync(),
        File(
          'lib/ui/_common/widgets/disease_result_card.dart',
        ).readAsStringSync(),
        File('lib/theme/app_palette.dart').readAsStringSync(),
        File('lib/theme/app_palette_tokens.dart').readAsStringSync(),
      ];
      final source = sources.join('\n');
      const forbiddenFragments = [
        'アムロジン',
        'アムロジピンベシル酸塩',
        'C08CA01',
        'drug_skeleton',
        '2025/03/14',
        "regulatoryClass: ['",
        "dosageForm: ['",
        "'毒薬'",
        "'劇薬'",
        "'処方箋医薬品'",
        "'錠剤'",
        "'ATC: ",
        "'改訂 ",
        "'Rx'",
        "'Dx'",
        "'絞り込み +",
        "'size': 'S'",
      ];

      for (final fragment in forbiddenFragments) {
        expect(
          source,
          isNot(contains(fragment)),
          reason:
              'SearchView must render state/domain/l10n data, not $fragment',
        );
      }
    },
  );

  test('drug_card_image_uses_cache_(T14)', () {
    final source = File(
      'lib/ui/_common/widgets/drug_result_card.dart',
    ).readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();

    expect(source, contains('getSingleFile'));
    expect(source, contains('Image.file'));
    expect(source, contains('BaseCacheManager'));
    expect(source, isNot(contains('CachedNetworkImage')));
    expect(source, isNot(contains('Image.network(')));
    expect(pubspec, contains('flutter_cache_manager:'));
  });

  test('drug regulatory badge colors come from AppPalette', () {
    final source = File(
      'lib/ui/_common/widgets/drug_result_card.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('_regulatoryBadgeColors')));
    expect(source, contains('palette.regulatoryBadgeColors('));
  });
}
