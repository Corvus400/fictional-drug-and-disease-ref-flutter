enum PatrolE2EWorkflow {
  appLaunch,
  searchDrug,
  searchDisease,
  searchEmpty,
  searchError,
  searchHistory,
  filterApplyReset,
  sortResults,
  loadMore,
  drugDetailTabs,
  diseaseDetailTabs,
  imagePreview,
  bookmarkToggle,
  relatedNavigation,
  doseCalcNavigation,
  bookmarksList,
  bookmarksSearch,
  bookmarksDelete,
  browsingHistoryList,
  browsingHistoryRetry,
  browsingHistoryDelete,
  calcBmi,
  calcEgfr,
  calcCrcl,
  calcValidation,
  calcHistory,
  iosInputToolbar,
  shellNavigation,
  adaptiveNavigation,
  disclaimer,
  about,
  licenses,
}

enum PatrolE2EDeviceClass {
  androidEmulator,
  iPhoneSimulator,
  iPadSimulator,
}

enum PatrolE2EOrientation {
  portrait,
  landscape,
}

class PatrolE2EScenario {
  const PatrolE2EScenario({
    required this.id,
    required this.routes,
    required this.workflows,
  });

  final String id;
  final Set<String> routes;
  final Set<PatrolE2EWorkflow> workflows;
}

class PatrolE2EDeviceTarget {
  const PatrolE2EDeviceTarget({
    required this.id,
    required this.deviceClass,
    required this.orientation,
  });

  final String id;
  final PatrolE2EDeviceClass deviceClass;
  final PatrolE2EOrientation orientation;
}

const patrolE2EScenarios = <PatrolE2EScenario>[
  PatrolE2EScenario(
    id: 'search',
    routes: {'/search'},
    workflows: {
      PatrolE2EWorkflow.appLaunch,
      PatrolE2EWorkflow.searchDrug,
      PatrolE2EWorkflow.searchDisease,
      PatrolE2EWorkflow.searchEmpty,
      PatrolE2EWorkflow.searchError,
      PatrolE2EWorkflow.searchHistory,
      PatrolE2EWorkflow.filterApplyReset,
      PatrolE2EWorkflow.sortResults,
      PatrolE2EWorkflow.loadMore,
    },
  ),
  PatrolE2EScenario(
    id: 'detail',
    routes: {'/search/drug/:id', '/search/disease/:id'},
    workflows: {
      PatrolE2EWorkflow.drugDetailTabs,
      PatrolE2EWorkflow.diseaseDetailTabs,
      PatrolE2EWorkflow.imagePreview,
      PatrolE2EWorkflow.bookmarkToggle,
      PatrolE2EWorkflow.relatedNavigation,
      PatrolE2EWorkflow.doseCalcNavigation,
    },
  ),
  PatrolE2EScenario(
    id: 'bookmarks-history',
    routes: {'/bookmarks', '/history'},
    workflows: {
      PatrolE2EWorkflow.bookmarksList,
      PatrolE2EWorkflow.bookmarksSearch,
      PatrolE2EWorkflow.bookmarksDelete,
      PatrolE2EWorkflow.browsingHistoryList,
      PatrolE2EWorkflow.browsingHistoryRetry,
      PatrolE2EWorkflow.browsingHistoryDelete,
    },
  ),
  PatrolE2EScenario(
    id: 'calc',
    routes: {'/calc'},
    workflows: {
      PatrolE2EWorkflow.calcBmi,
      PatrolE2EWorkflow.calcEgfr,
      PatrolE2EWorkflow.calcCrcl,
      PatrolE2EWorkflow.calcValidation,
      PatrolE2EWorkflow.calcHistory,
      PatrolE2EWorkflow.iosInputToolbar,
    },
  ),
  PatrolE2EScenario(
    id: 'shell-about',
    routes: {'/about', '/about/licenses'},
    workflows: {
      PatrolE2EWorkflow.shellNavigation,
      PatrolE2EWorkflow.adaptiveNavigation,
      PatrolE2EWorkflow.disclaimer,
      PatrolE2EWorkflow.about,
      PatrolE2EWorkflow.licenses,
    },
  ),
];

const patrolE2EDeviceMatrix = <PatrolE2EDeviceTarget>[
  PatrolE2EDeviceTarget(
    id: 'android-emulator-portrait',
    deviceClass: PatrolE2EDeviceClass.androidEmulator,
    orientation: PatrolE2EOrientation.portrait,
  ),
  PatrolE2EDeviceTarget(
    id: 'android-emulator-landscape',
    deviceClass: PatrolE2EDeviceClass.androidEmulator,
    orientation: PatrolE2EOrientation.landscape,
  ),
  PatrolE2EDeviceTarget(
    id: 'iphone-simulator-portrait',
    deviceClass: PatrolE2EDeviceClass.iPhoneSimulator,
    orientation: PatrolE2EOrientation.portrait,
  ),
  PatrolE2EDeviceTarget(
    id: 'iphone-simulator-landscape',
    deviceClass: PatrolE2EDeviceClass.iPhoneSimulator,
    orientation: PatrolE2EOrientation.landscape,
  ),
  PatrolE2EDeviceTarget(
    id: 'ipad-simulator-portrait',
    deviceClass: PatrolE2EDeviceClass.iPadSimulator,
    orientation: PatrolE2EOrientation.portrait,
  ),
  PatrolE2EDeviceTarget(
    id: 'ipad-simulator-landscape',
    deviceClass: PatrolE2EDeviceClass.iPadSimulator,
    orientation: PatrolE2EOrientation.landscape,
  ),
];
