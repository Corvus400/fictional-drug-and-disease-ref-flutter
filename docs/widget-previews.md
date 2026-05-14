# Widget Preview Inventory

Issue: #10

Last local detector evidence:

- Command: `flutter widget-preview start --no-web-server`
- Result: `Found 12 previews`, `Done loading previews`
- Fixture source: `lib/ui/previews/preview_data.dart`
- Shared support: `lib/ui/previews/preview_support.dart`

Preview isolation rules:

- Preview entrypoints and helper annotations live under `lib/ui/previews/`.
- Production files must not import preview files, preview annotations, or
  preview-only providers.
- Preview files may import production widgets and pass deterministic fixture
  data into their public constructors.
- Full-screen previews are intentionally avoided when they would require
  production-only web shims, production provider overrides, database connection
  changes, platform exception indirection, or dialog-host changes.
- No preview-only user-facing copy is added to production UI.

## Coverage

| Area | Status | Preview coverage |
| --- | --- | --- |
| Calc | component preview added | Result-card chart gallery, CrCl chart, history row. |
| Detail shared | component preview added | Shared panels, key-value rows, exam table, pharmacokinetics table, badges, chips, warning banner. |
| Common | component preview added | Disease result card and loading skeletons. |
| Shell | component preview added | Disclaimer ribbon, tab header, bottom navigation. |
| History | component preview added | Bulk delete confirmation dialog. |
| Bookmarks | component preview added | Bookmark search box. |
| Search full screen, filter sheet, history dropdown | intentionally removed | Earlier previews required production code changes for provider/database/dialog behavior. These were removed to keep production code unchanged. |
| Drug result card and drug/detail full screens | intentionally removed | Earlier previews required platform image/cache shims or full production screen dependencies. These were removed to keep production code unchanged. |
| History/bookmarks full screens and rows | intentionally removed | Earlier previews required production database/API/image behavior. These were removed to keep production code unchanged. |

## Intentional Skips

| Files or surface type | Status | Reason |
| --- | --- | --- |
| `*_screen_notifier.dart`, `*_screen_state.dart`, providers, use cases, repositories, DTOs, domain models | intentional skip | Non-visual application/data logic. Preview support must not add dependencies back into production layers. |
| Private implementation widgets under feature directories | parent or component represented where safe | Private widgets are not public preview targets. They can be previewed only if doing so does not require production code changes. |
| Formatters, constants, route enums, and static helpers | intentional skip | No standalone visual surface. |
| Platform, Drift, API, cache, and exception shims | intentional skip | Preview support must not introduce production shims solely for Widget Previewer. |
| Test files, golden helpers, integration tests | intentional skip | Not production UI surfaces. |

## Audit Result

- Current strategy favors production isolation over preview breadth.
- Production code impact target: zero lines outside `lib/ui/previews/`.
- New preview entries must preserve the dependency direction: preview imports
  production, production never imports preview.
