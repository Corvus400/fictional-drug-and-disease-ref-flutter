import 'package:flutter_test/flutter_test.dart';

import '../../patrol_test/e2e_scenario_manifest.dart';

void main() {
  test('Patrol E2E covers all top-level routes [assertion 1/1]', () {
    expect(
      patrolE2EScenarios.expand((scenario) => scenario.routes).toSet(),
      containsAll(<String>{
        '/search',
        '/bookmarks',
        '/history',
        '/calc',
        '/about',
        '/about/licenses',
        '/search/drug/:id',
        '/search/disease/:id',
      }),
    );
  });

  test('Patrol E2E covers all user workflows [assertion 1/1]', () {
    expect(
      patrolE2EScenarios.expand((scenario) => scenario.workflows).toSet(),
      containsAll(PatrolE2EWorkflow.values),
    );
  });

  test('Patrol E2E runs on required device classes [assertion 1/1]', () {
    expect(
      patrolE2EDeviceMatrix.map((target) => target.deviceClass).toSet(),
      containsAll(PatrolE2EDeviceClass.values),
    );
  });

  test('Patrol E2E runs in portrait and landscape [assertion 1/1]', () {
    expect(
      patrolE2EDeviceMatrix.map((target) => target.orientation).toSet(),
      containsAll(PatrolE2EOrientation.values),
    );
  });
}
