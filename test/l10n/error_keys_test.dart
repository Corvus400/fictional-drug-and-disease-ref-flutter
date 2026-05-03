import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLocalizations exposes all error keys', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    expect(l10n.errNetwork, isNotEmpty);
    expect(l10n.errServer, isNotEmpty);
    expect(l10n.errApi4xx('test'), contains('test'));
    expect(l10n.errApiNotFound, isNotEmpty);
    expect(l10n.errApiBadRequest, isNotEmpty);
    expect(l10n.errApiInvalidCategory, isNotEmpty);
    expect(l10n.errParse, isNotEmpty);
    expect(l10n.errStorageUnique, isNotEmpty);
    expect(l10n.errStorageCheck, isNotEmpty);
    expect(l10n.errStorageGeneric, isNotEmpty);
    expect(l10n.errUnknown, isNotEmpty);
    expect(l10n.errBookmarkOfflineBanner, isNotEmpty);
    expect(l10n.errGoBack, isNotEmpty);
    expect(l10n.errNetworkRetry, isNotEmpty);
  });
}
