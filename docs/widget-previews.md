# Widget Preview Inventory

Issue: #10

Last local detector evidence:

- Command: `flutter widget-preview start --no-web-server`
- Result: `Found 59 previews`, Chrome scaffold launched, `Done loading previews`
- Fixture source: `lib/ui/previews/preview_data.dart`
- Shared support: `lib/ui/previews/preview_support.dart`

Preview isolation rules:

- Preview API clients return deterministic fixture data.
- Preview cache manager never performs a live image fetch.
- Full-screen previews use Riverpod overrides instead of live notifiers.
- Production Drift and IO-only exception/image paths are behind conditional
  imports so the web-based preview scaffold can compile.
- No preview-only user-facing copy is added to production UI.

## Coverage

| Area | Status | Preview coverage |
| --- | --- | --- |
| Search | preview added | Drug results, disease results, history dropdown, loading, loading more, empty, error, drug filter sheet, disease filter sheet, sort sheet. Child chrome, toolbar, result list, history row, filter axis, chips, and FAB badge are represented by these parent previews. |
| Drug detail | preview added | Loading, error, overview tab, dose tab, caution tab, adverse effects tab, pharmacokinetics tab, related tab. Shared detail panels, tables, warnings, controls, carousel, accordion, tab button, bookmark footer, and related cards are represented by these screen/component previews. |
| Disease detail | preview added | Loading, error, overview tab, diagnosis tab, treatment tab, clinical course tab, related tab. Epidemiology, diagnosis, treatment, related drug, related disease, severity, and shared detail widgets are represented by these screen/component previews. |
| Calc | preview added | BMI result with history, eGFR result, CrCl result, partial input, out-of-range input, tablet split layout, result-card chart gallery, CrCl chart, history row. Form fields, segmented controls, responsive panes, charts, result card, history section, restoring overlay, and delete reveal are represented by these previews. |
| History | preview added | Loaded rows, swipe reveal, empty, loading, tablet pane, row variants, bulk delete dialog. Pane body, tab bars, FABs, rows, unresolved card, loading skeletons, and empty art are represented by these previews. |
| Bookmarks | preview added | Loaded rows, swipe reveal, search zero, error, empty, loading, tablet pane, search box and rows. Search box, list rows, empty/error/loading states, skeletons, and tablet pane are represented by these previews. |
| Common result cards | preview added | Drug result card, disease result card, loading skeletons. Platform file-image handling is covered through card previews with a failing preview cache manager. |
| Shell | preview added | Disclaimer ribbon, tab header, bottom navigation. App shell content projection is represented by the individual tab previews plus shell component previews. |
| Preview fixtures/support | intentional skip | Non-visual support only: deterministic DTO/domain data, API client fakes, wrappers, preview annotations, bootstrap, and provider overrides. |

## Intentional Skips

| Files or surface type | Status | Reason |
| --- | --- | --- |
| `*_screen_notifier.dart`, `*_screen_state.dart`, providers, use cases, repositories, DTOs, domain models | intentional skip | Non-visual application/data logic. These are exercised by existing tests and by UI previews through overridden states. |
| Private implementation widgets under `search/widgets`, `calc/widgets`, `detail/widgets`, `history/widgets`, `bookmarks/widgets` | parent preview represented | They are not public preview targets and are covered by the nearest full-screen or component gallery preview listed above. |
| Formatters, constants, route enums, and static helpers | intentional skip | No standalone visual surface. Their visible output appears in parent previews. |
| Platform shims such as cached file image, app database connection, and platform exception classifier | intentional skip | Compile/runtime support only. The visual behavior is represented by result-card and detail-card previews; IO implementations remain covered by normal tests. |
| Test files, golden helpers, integration tests | intentional skip | Not production UI surfaces. |

## Audit Result

- Unhandled meaningful public UI surfaces: none.
- Weak skip reasons: none.
- New public screens, cards, dialogs, sheets, or navigation surfaces should add a
  Widget Preview entrypoint or update this inventory with a parent-preview
  representative.
