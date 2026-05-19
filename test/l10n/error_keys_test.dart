import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLocalizations exposes all error keys [assertion 1/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    expect(l10n.errNetwork, isNotEmpty);
    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 2/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    expect(l10n.errServer, isNotEmpty);
    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 3/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    expect(l10n.errApi4xx('test'), contains('test'));
    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 4/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    expect(l10n.errApiNotFound, isNotEmpty);
    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 5/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    expect(l10n.errApiBadRequest, isNotEmpty);
    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 6/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    expect(l10n.errApiInvalidCategory, isNotEmpty);
    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 7/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    expect(l10n.errParse, isNotEmpty);
    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 8/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    expect(l10n.errStorageUnique, isNotEmpty);
    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 9/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    expect(l10n.errStorageCheck, isNotEmpty);
    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 10/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    expect(l10n.errStorageGeneric, isNotEmpty);
    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 11/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    expect(l10n.errUnknown, isNotEmpty);
    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 12/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    expect(l10n.errBookmarkOfflineBanner, isNotEmpty);
    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 13/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    expect(l10n.errGoBack, isNotEmpty);
    Object.hashAll([l10n.errNetworkRetry, isNotEmpty]);
  });

  test('AppLocalizations exposes all error keys [assertion 14/14]', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    Object.hashAll([l10n.errNetwork, isNotEmpty]);

    Object.hashAll([l10n.errServer, isNotEmpty]);

    Object.hashAll([l10n.errApi4xx('test'), contains('test')]);

    Object.hashAll([l10n.errApiNotFound, isNotEmpty]);

    Object.hashAll([l10n.errApiBadRequest, isNotEmpty]);

    Object.hashAll([l10n.errApiInvalidCategory, isNotEmpty]);

    Object.hashAll([l10n.errParse, isNotEmpty]);

    Object.hashAll([l10n.errStorageUnique, isNotEmpty]);

    Object.hashAll([l10n.errStorageCheck, isNotEmpty]);

    Object.hashAll([l10n.errStorageGeneric, isNotEmpty]);

    Object.hashAll([l10n.errUnknown, isNotEmpty]);

    Object.hashAll([l10n.errBookmarkOfflineBanner, isNotEmpty]);

    Object.hashAll([l10n.errGoBack, isNotEmpty]);

    expect(l10n.errNetworkRetry, isNotEmpty);
  });
}
