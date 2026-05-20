import 'dart:io';

import 'package:drift/native.dart';
import 'package:fictional_drug_and_disease_ref/app.dart';
import 'package:fictional_drug_and_disease_ref/config/api_config.dart';
import 'package:fictional_drug_and_disease_ref/config/flavor.dart';
import 'package:fictional_drug_and_disease_ref/data/local/app_database.dart';
import 'package:fictional_drug_and_disease_ref/data/providers/local_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

/// Stable mock-server fixture ID used by E2E.
const e2eDrugId = 'drug_0080';

/// Stable mock-server fixture name used by E2E.
const e2eDrugName = 'トレデキム';

/// Stable mock-server fixture ID used by E2E.
const e2eDiseaseId = 'disease_0079';

/// Stable mock-server fixture name used by E2E.
const e2eDiseaseName = '魔女因子症候群';

/// API URL used by Patrol E2E.
const e2eApiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:8080',
);

/// Requested orientation passed by scripts/run-patrol-e2e-matrix.sh.
const e2eOrientation = String.fromEnvironment(
  'FDDR_E2E_ORIENTATION',
  defaultValue: 'portrait',
);

/// Platform automation config shared by all Patrol tests.
final platformAutomatorConfig = PlatformAutomatorConfig.fromOptions(
  packageName: 'com.corvus400.fictional_drug_and_disease_ref.dev',
  bundleId: 'com.corvus400.fictionalDrugAndDiseaseRef',
);

/// Patrol test timeout.
const e2eTimeout = Timeout(Duration(minutes: 3));

/// Starts the app with a fresh in-memory database.
Future<AppDatabase> pumpE2EApp(PatrolIntegrationTester $) async {
  await _configurePreferredOrientations();
  ApiConfig.initialize(
    const FlavorConfig(flavor: Flavor.dev, apiBaseUrl: e2eApiBaseUrl),
  );
  final db = AppDatabase(NativeDatabase.memory());
  addTearDown(db.close);
  await $.pumpWidgetAndSettle(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: App(),
    ),
  );
  await $.pumpAndSettle();
  return db;
}

/// Finds a widget by ValueKey.
PatrolFinder keyed(PatrolIntegrationTester $, String key) {
  return $(ValueKey<String>(key));
}

/// Taps a ValueKey target and waits for shell/page transitions to settle.
Future<void> tapKey(PatrolIntegrationTester $, String key) async {
  var target = find.byKey(ValueKey<String>(key)).hitTestable();
  if (target.evaluate().isEmpty) {
    await ensureKeyVisible($, key);
    target = find.byKey(ValueKey<String>(key)).hitTestable();
  }
  await $.tester.tap(target);
  await $.pump(const Duration(milliseconds: 350));
}

/// Scrolls a keyed widget into view when it lives inside a responsive pane.
Future<void> ensureKeyVisible(PatrolIntegrationTester $, String key) async {
  final elements = find.byKey(ValueKey<String>(key)).evaluate();
  if (elements.isEmpty) {
    throw TestFailure('No widget found for key $key');
  }
  await Scrollable.ensureVisible(elements.first);
  await $.pumpAndSettle();
}

/// Scrolls the search utility pane until a lazily-built keyed child is visible.
Future<void> scrollSearchUtilityPaneTo(
  PatrolIntegrationTester $,
  String key,
) async {
  await $.tester.scrollUntilVisible(
    find.byKey(ValueKey<String>(key)),
    220,
    scrollable: find.descendant(
      of: find.byKey(const ValueKey<String>('search-utility-pane-scroll')),
      matching: find.byType(Scrollable),
    ),
  );
  await $.pump(const Duration(milliseconds: 150));
}

/// Runs a search from the search tab.
Future<void> searchFor(PatrolIntegrationTester $, String query) async {
  await keyed($, 'search-field').enterText(query);
  await $.tester.testTextInput.receiveAction(TextInputAction.search);
  await $.pumpAndSettle();
}

/// Opens the calculation tab.
Future<void> openCalcTab(PatrolIntegrationTester $) {
  return tapKey($, 'app-shell-tab-calc');
}

/// Opens the bookmarks tab.
Future<void> openBookmarksTab(PatrolIntegrationTester $) {
  return tapKey($, 'app-shell-tab-bookmarks');
}

/// Opens the history tab.
Future<void> openHistoryTab(PatrolIntegrationTester $) {
  return tapKey($, 'app-shell-tab-history');
}

/// Enters text into a calculation input.
Future<void> enterCalcInput(
  PatrolIntegrationTester $,
  String key,
  String value,
) async {
  final finder = find.byKey(ValueKey<String>(key));
  await $.tester.tap(finder);
  await $.tester.enterText(finder, value);
  await $.pump(const Duration(milliseconds: 250));
}

/// Dismisses the calculation keyboard before tapping bottom controls.
Future<void> dismissCalcKeyboard(PatrolIntegrationTester $) async {
  final doneButton = find
      .byKey(const ValueKey<String>('calc-input-toolbar-done'))
      .hitTestable();
  if (doneButton.evaluate().isNotEmpty) {
    await $.tester.tap(doneButton);
    await $.pump(const Duration(milliseconds: 250));
    return;
  }

  await $.tester.testTextInput.receiveAction(TextInputAction.done);
  await $.pump(const Duration(milliseconds: 250));
}

/// Selects a calculation tool segment.
Future<void> selectCalcTool(PatrolIntegrationTester $, String label) async {
  await dismissCalcKeyboard($);
  final keyedSegment = switch (label) {
    'BMI' => 'calc-segment-CalcType.bmi',
    'eGFR' => 'calc-segment-CalcType.egfr',
    'CrCl' => 'calc-segment-CalcType.crcl',
    _ => null,
  };
  if (keyedSegment != null) {
    await tapKey($, keyedSegment);
    return;
  }
  await $(label).tap();
}

/// Verifies the current MediaQuery orientation matches script intent.
void verifyRequestedOrientation(BuildContext context) {
  final orientation = MediaQuery.orientationOf(context);
  if (e2eOrientation == 'landscape') {
    expect(orientation, Orientation.landscape);
  } else {
    expect(orientation, Orientation.portrait);
  }
}

/// Returns whether the app is currently using a tablet-sized layout.
bool isTabletLayout(BuildContext context) {
  return MediaQuery.sizeOf(context).shortestSide >= 600;
}

/// Returns whether this run should show the iPhone-only iOS input toolbar.
bool showsIOSPhoneInputToolbar(PatrolIntegrationTester $) {
  final context = $.tester.element(find.byType(MaterialApp));
  return Platform.isIOS && !isTabletLayout(context);
}

Future<void> _configurePreferredOrientations() async {
  if (e2eOrientation == 'landscape') {
    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.landscapeRight,
    ]);
    return;
  }
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

/// Returns whether the current target is iOS.
bool get isIOSPatrolRun => Platform.isIOS;
