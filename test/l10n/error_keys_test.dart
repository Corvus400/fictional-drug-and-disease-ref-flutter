import 'package:fictional_drug_and_disease_ref/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppLocalizations exposes RFC 9457 error keys', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    expect(
      <String>[
        l10n.errNetwork,
        l10n.errServer,
        l10n.errApiNotFound,
        l10n.errApiValidation,
        l10n.errApiConflict,
        l10n.errApiUnauthorized,
        l10n.errApiForbidden,
        l10n.errApiRateLimited,
        l10n.errParse,
        l10n.errStorageUnique,
        l10n.errStorageCheck,
        l10n.errStorageGeneric,
        l10n.errUnknown,
        l10n.errBookmarkOfflineBanner,
        l10n.errGoBack,
        l10n.errNetworkRetry,
      ],
      everyElement(isNotEmpty),
    );
  });

  test('AppLocalizations exposes RFC 9457 fallback interpolation', () {
    final l10n = lookupAppLocalizations(const Locale('ja'));

    expect(l10n.errApi4xx('test'), contains('test'));
  });
}
