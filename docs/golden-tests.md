# Golden Tests Operations Guide

This project uses [alchemist](https://pub.dev/packages/alchemist) for Flutter golden / VRT tests, with custom diff artifacts inspired by [Roborazzi (Apache-2.0)](https://github.com/takahirom/roborazzi). See `third_party/roborazzi/NOTICE.txt` for attribution.

## Daily commands

| Action | Command |
|---|---|
| Verify (CI-like) | `make golden-test` |
| Update goldens | `make golden-update` |
| Regenerate HTML report only | `make golden-report` |
| Clean build artifacts | `make golden-clean` |

## Output paths

| Path | Purpose | Committed? |
|---|---|---|
| `test/**/goldens/macos/*.png` | Source-of-truth golden images | Yes |
| `build/outputs/golden/*_compare.png` | 3-pane (golden/actual/diff) on failure | No (gitignored) |
| `build/outputs/golden/*_actual.png` | Latest rendered image on failure | No |
| `build/test-results/golden/*.json` | Per-test CaptureResult JSON | No |
| `build/test-results/golden/results-summary.json` | Aggregated summary | No |
| `build/reports/golden/index.html` | Human-readable HTML report | No |

## Recording host policy

**Goldens MUST only be regenerated on macOS** (matches CLAUDE.md L165-L169):

- Skia rendering depends on host OS for shadow blur, font rendering, anti-aliasing.
- Even between Apple Silicon and Intel Mac, micro-pixel differences in shadow blur can occur.
- The recording host SHOULD be a single developer machine (or a fixed CI runner), not rotated.
- `flutter_test_config.dart` warns to stderr when run on non-macOS.

## CI policy

Golden VRT runs in the `CI` workflow after non-golden tests pass. The VRT job is
sharded on macOS and uses `strategy.fail-fast: true`, so a failing shard cancels
the remaining VRT shards.

The source-of-truth images under `test/**/goldens/macos/*.png` must stay tracked.
The comparator reads those PNGs as the reference; if they are removed from the
checkout and kept only as CI artifacts, every case is reported as `added`.

`integration_test/` is intentionally excluded from CI because it depends on the
separate mock-server repository plus emulator/simulator network setup. Run it
manually when validating device-level flows.

## How `*_compare.png` is laid out (Roborazzi-inspired)

3-pane horizontal grid:

| Pane 1 (left) | Spacing | Pane 2 (center) | Spacing | Pane 3 (right) |
|---|---|---|---|---|
| GOLDEN (or MISSING black) | 16 px | ACTUAL | 16 px | DIFF (red = changed pixels) |

Each pane is the same size as the actual rendered image.
Labels (`GOLDEN` / `ACTUAL` / `DIFF`) are drawn in arial14 bitmap font (image package built-in).

## Diff calculation

Per-pixel squared RGB distance > `0.007^2` (normalized 0..1) is "changed", drawn `#FF0000`. Otherwise drawn `#FFFFFF`. This is identical to Roborazzi's `SimpleImageComparator(maxDistance = 0.007F)`.

The DIFF pane gives a quick visual hint at WHERE the change occurred. To see WHAT changed, look at the GOLDEN vs ACTUAL panes side-by-side.

## CaptureResult JSON schema

| type | required keys |
|---|---|
| `unchanged` | `golden_file_path`, `timestamp` |
| `recorded` | `golden_file_path`, `timestamp` |
| `changed` | `compare_file_path`, `actual_file_path`, `golden_file_path`, `timestamp`, `diff_percentage` |
| `added` | `compare_file_path`, `actual_file_path`, `golden_file_path`, `timestamp` |

Aggregated as `build/test-results/golden/results-summary.json` by `tool/aggregate_golden_report.dart`.

## CI integration

This project's output naming and directory structure follow Roborazzi's specification so that workflows like [DroidKaigi/conference-app-2025 screenshot-comparison](https://github.com/DroidKaigi/conference-app-2025/blob/main/.github/workflows/screenshot-comparison.yml) can be adapted with minimal changes:

- The artifact-upload + companion-branch-push + PR-comment **workflow logic** is portable.
- The job's launch command is `flutter test --tags golden` with `--total-shards` / `--shard-index`.
- The CI runner OS must be macOS because Skia rendering is host-OS dependent.
