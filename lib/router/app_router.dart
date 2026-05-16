import 'package:fictional_drug_and_disease_ref/ui/about/about_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/about/licenses_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/bookmarks/bookmarks_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/calc/calc_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/disease/disease_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/drug/drug_detail_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/history/history_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/search/search_view.dart';
import 'package:fictional_drug_and_disease_ref/ui/shell/app_shell.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Route observer used by views that need stack return callbacks.
final appRouteObserver = RouteObserver<PageRoute<dynamic>>();

/// Application route paths.
class AppRoutes {
  const AppRoutes._();

  /// Search tab route.
  static const search = '/search';

  /// Bookmarks tab route.
  static const bookmarks = '/bookmarks';

  /// Browsing history tab route.
  static const history = '/history';

  /// Calculation tools tab route.
  static const calc = '/calc';

  /// About route.
  static const about = '/about';

  /// Open source licenses route.
  static const aboutLicenses = '/about/licenses';

  /// Builds a drug detail route.
  static String drugDetail(String id) => '$search/drug/$id';

  /// Builds a disease detail route.
  static String diseaseDetail(String id) => '$search/disease/$id';
}

/// Builds the application router.
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: AppRoutes.search,
    observers: [appRouteObserver],
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.search,
                pageBuilder: (context, state) => CupertinoPage<void>(
                  key: state.pageKey,
                  child: const SearchView(),
                ),
                routes: [
                  GoRoute(
                    path: 'drug/:id',
                    pageBuilder: (context, state) => CupertinoPage<void>(
                      key: state.pageKey,
                      child: DrugDetailView(
                        id: state.pathParameters['id']!,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'disease/:id',
                    pageBuilder: (context, state) => CupertinoPage<void>(
                      key: state.pageKey,
                      child: DiseaseDetailView(
                        id: state.pathParameters['id']!,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.bookmarks,
                pageBuilder: (context, state) => CupertinoPage<void>(
                  key: state.pageKey,
                  child: const BookmarksView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                pageBuilder: (context, state) => CupertinoPage<void>(
                  key: state.pageKey,
                  child: const HistoryView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.calc,
                pageBuilder: (context, state) => CupertinoPage<void>(
                  key: state.pageKey,
                  child: const CalcView(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (context, state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const AboutView(),
        ),
        routes: [
          GoRoute(
            path: 'licenses',
            pageBuilder: (context, state) => CupertinoPage<void>(
              key: state.pageKey,
              child: const LicensesView(),
            ),
          ),
        ],
      ),
    ],
  );
}
