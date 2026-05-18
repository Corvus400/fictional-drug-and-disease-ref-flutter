import 'package:fictional_drug_and_disease_ref/ui/_common/cache/resized_image_cache_manager.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/providers/drug_card_image_cache_manager_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'drugCardImageCacheManagerProvider returns ResizedImageCacheManager',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(drugCardImageCacheManagerProvider),
        isA<ResizedImageCacheManager>(),
      );
    },
  );
}
