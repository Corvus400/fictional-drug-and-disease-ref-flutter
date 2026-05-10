# UI / Golden Design Gate

This temporary handoff note is mandatory for the remaining UI/golden phases of
the calc tools plan. Re-read it before starting or closing any UI/golden phase.

## Why This Exists

Golden retention is not design comparison.

- `flutter test --update-goldens` stores the current implementation image.
- `flutter test --tags golden` only checks whether the implementation still
  matches that stored image.
- A golden can pass while still differing from the design spec.

Therefore, every remaining UI/golden phase must prove design matching with a
separate spec comparison gate before it can be marked complete or committed.

## Required Gate For Every UI/Golden Target

For each component, atom, chart, screen, state, or transition that has a design
spec:

1. Render the SSOT HTML with Playwright and capture the relevant reference
   screenshot or state.
2. Capture computed CSS/style/layout values from the SSOT HTML where possible.
3. Create or update a focused Flutter golden for the same component/state.
   Prefer component/state-specific goldens over only large composite goldens.
4. Add widget/design-contract tests for measurable requirements.
5. Update the phase verdict with a table containing:
   - Spec value
   - Flutter implementation value
   - Golden or Playwright reference confirmation
   - pass/fail
6. Do not proceed if any row is `fail`, `unchecked`, `pending`, or inferred only
   from retention.

## Minimum Comparison Rows

Use the relevant subset for each target:

- height
- width where fixed or reference-critical
- padding
- gap
- border radius
- selected/active element dimensions and position
- font size
- font weight
- letter spacing
- text color
- background color
- selected/active background color
- border color and width
- shadow
- icon presence
- icon type
- icon size
- label position
- text overflow / clipping / overlap
- extra elements absent

## Playwright Reference Workflow

Existing Phase 4a helper:

```bash
CALC_SPEC_HTML="$CALC_TOOLS_SPEC_HTML" \
CALC_SPEC_REF_DIR="$PWD/tmp/calc_spec_refs" \
PLAYWRIGHT_INDEX_MJS="$PLAYWRIGHT_INDEX_MJS" \
node tmp/capture_calc_spec_refs.mjs
```

If the cached Playwright package path changes, locate it with:

```bash
find "$HOME/.npm/_npx" -path '*/node_modules/playwright/index.mjs' -print
```

If the browser executable is missing:

```bash
npx playwright install chromium
```

Use the original Playwright screenshot as the primary visual reference. The
current helper defaults to `deviceScaleFactor: 4`, so atom-card references are
typically 4x PNGs (for example 1080 px wide for a 270 CSS px card). Downscaled
or resized copies may be kept only as secondary overview images; do not use
them as the primary evidence for typography, icon, border, or spacing judgment.

If a reference still looks too narrow for judging details, do not proceed with
the phase. Increase `CALC_SPEC_DEVICE_SCALE_FACTOR` or capture an additional
state-specific crop/wider reference first, then compare against that higher
fidelity image.

For charts or any component with centered labels at the visual left/right
edges, the crop must include enough logical side padding to prove that edge
labels, rounded ends, markers, and borders are not clipped. Phase 4d chart
refs use 36 px logical left/right padding (DPR 4) after the earlier 24 px crop
looked too tight for BMI/eGFR.

For result screens that combine a classification badge with a chart marker
label, add at least one edge-case golden and a widget geometry assertion for a
minimum 12 px vertical gap. The original SSOT chart CSS places the pin label
above the scale, so the screen-level implementation must reserve extra space
when a badge is present. User correction on 2026-05-10 explicitly overrides
the too-tight badge/chart spacing. Current required Phase 5 edge cases:

- BMI underweight / BMI < 18.5 (`calc_bmi_underweight-edge_*`)
- eGFR low / eGFR <= 30 (`calc_egfr_low-edge_*`)
- BMI chart endpoints (`calc_bmi_min-edge_*`, `calc_bmi_max-edge_*`, and
  focused `calc_chart_bmi_edges_light.png`)
- eGFR chart endpoints. `eGFR = 0` is not reachable from valid screen inputs,
  so it is covered by focused chart atom golden
  `calc_chart_egfr_edges_light.png`; the screen covers the nearest valid lower
  edge (`calc_egfr_min-edge_*`) and right-clamped high value
  (`calc_egfr_max-edge_*`).
- CrCl has no classification badge, but must still cover value-dependent
  patient marker endpoints with `calc_chart_crcl_edges_light.png`,
  `calc_crcl_min-edge_*`, and `calc_crcl_max-edge_*`.
- eGFR and CrCl must include female selected-state screen goldens because sex
  affects both UI state and calculation coefficient:
  `calc_egfr_female_*`, `calc_crcl_female_*`. BMI has no sex input.
- All BMI/eGFR classification badge label patterns must be covered by focused
  atom goldens in light and dark:
  `calc_category_badges_all_light.png` and
  `calc_category_badges_all_dark.png`.
- Phase 5 history states must include `calc_history_collapsed_*`,
  `calc_history_expanded_*`, and `calc_history_empty_*`. A `履歴 (0)` header
  must not appear alone; when the count is zero the `履歴はありません` empty
  state must be visible in screen goldens.
- History boundary screen goldens must cover count `0` as a fixed empty state
  with no open/close interaction, plus counts `1`, `50`, and `51` in both
  closed and open states. The `51` case must assert the persisted cap and
  render as `履歴 (50)`, not as `履歴 (51)`.
- Partial-input screen goldens must cover every non-empty incomplete numeric
  input subset:
  BMI `height-only` / `weight-only`; eGFR `age-only` / `creatinine-only`;
  CrCl `age-only` / `weight-only` / `creatinine-only` / `age-weight` /
  `age-creatinine` / `weight-creatinine`. Sex is not part of partial coverage
  because it always has a selected value; sex-specific calculation coverage is
  handled by the eGFR/CrCl female screen goldens.
- Input field boundary error screen goldens must cover every numeric field's
  lower and upper invalid edge:
  BMI height/weight (4); eGFR age/serum creatinine (4); CrCl age/weight/serum
  creatinine (6). Each golden must assert the matching range label appears.
- CalcView AppBar must not keep decorative or undefined action buttons. The
  original design frame showed a left menu icon and a right history icon, but
  the plan defines no menu behavior and the in-screen history header is the
  canonical history expand/collapse control. User correction on 2026-05-10:
  remove both top AppBar icons and record the difference as a justified
  deviation from the static mock.

## Phase 4a Reference Outputs

Generated references:

- `tmp/calc_spec_refs/spec_segmented_control_card.png`
- `tmp/calc_spec_refs/spec_segmented_control_card_270x524.png`
- `tmp/calc_spec_refs/spec_segmented_tool_row.png`
- `tmp/calc_spec_refs/spec_segmented_sex_row.png`
- `tmp/calc_spec_refs/spec_segmented_metrics.json`

Flutter focused golden:

- `test/ui/calc/widgets/goldens/macos/calc_segmented_control_atom_card_light.png`

The Phase 4a verdict records the current spec comparison table:

- `tmp/calc_phase_4a_verdict.md`

## Continuing The Plan

Before each remaining UI/golden phase:

1. Read this file.
2. Read the relevant SSOT HTML section.
3. Add/update a Playwright helper or extend `tmp/capture_calc_spec_refs.mjs`
   for the new target.
4. Do not close the phase until the verdict table has no failing or unchecked
   rows.

This requirement applies to all future UI/golden phases, not only Phase 4a.
