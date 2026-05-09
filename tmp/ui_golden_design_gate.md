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
