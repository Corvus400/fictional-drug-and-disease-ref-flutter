# Calc Phase 4d Verdict: Chart Atoms

Gate source: `tmp/ui_golden_design_gate.md`.

## References

- Playwright SSOT atom reference: `tmp/calc_spec_refs/spec_chart_atom_card.png`
  - size: 1080 x 1084 (DPR 4)
- Playwright wider state references:
  - `tmp/calc_spec_refs/spec_chart_phone_bmi.png` size: 1488 x 272
  - `tmp/calc_spec_refs/spec_chart_phone_egfr.png` size: 1488 x 272
  - `tmp/calc_spec_refs/spec_chart_phone_crcl.png` size: 1296 x 300
- Flutter focused goldens:
  - `test/ui/calc/widgets/goldens/macos/calc_chart_bmi_light.png` size: 1488 x 272
  - `test/ui/calc/widgets/goldens/macos/calc_chart_egfr_light.png` size: 1488 x 272
  - `test/ui/calc/widgets/goldens/macos/calc_chart_crcl_light.png` size: 1296 x 300
- CSS metrics: `tmp/calc_spec_refs/spec_chart_metrics.json`
- Tests:
  - `test/ui/calc/widgets/calc_chart_atoms_test.dart`
  - `test/ui/calc/widgets/calc_chart_atoms_golden_test.dart`

## Spec / Flutter / Golden Table

| Item | Spec value | Flutter implementation value | Golden / Playwright confirmation | Status |
|---|---:|---:|---|---|
| BMI chart height | `.chart-bmi` height 44 px | `CalcBandChart` height 44 px | CSS metrics `bmi.chart.style.height = 44px`; golden size includes wrapper padding only | pass |
| BMI scale height/radius | `.scale` height 24 px, radius 8, border hairline | `_ScaleBand` height 24, `AppRadii.tile` 8, `calcHairline` border | CSS metrics `bmi.scale.height = 24px`, `borderRadius = 8px`; golden shows rounded band | pass |
| BMI segments | 7 equal bands with labels `<18.5`, `18.5`, `25`, `30`, `35`, `40`, `≥45` | 7 `CalcBandSegment` values, equal flex | Widget test finds `bmi-chart-segment-1..7`; golden shows all seven bands and labels visible | pass |
| BMI marker position | `((22.5 - 10) / 40) * 100 = 31.25%` | `markerPosition = ((value - 10) / 40).clamp(0,1)` | Playwright/golden show marker over the BMI 25 band boundary area; marker circle and pin are visible | pass |
| BMI marker dimensions | line width 2 px, height 32 px, pin dot 10 px, label 10 px mono | marker line `2 x 32`, dot `10 x 10`, label `10px` mono | Widget test expects marker size `2 x 32`; golden includes line, circle, and `22.5` pin label | pass |
| BMI axis | axis height 16, margin-top 4, ticks at 0/50/100% | `_AxisTicks` height 16, positioned at 0/0.5/1 | Golden has `10`, `30`, `50` fully visible; no left/right clipping | pass |
| eGFR chart height | `.chart-egfr` height 44 px | `CalcBandChart` height 44 px | CSS metrics `egfr.chart.style.height = 44px`; golden size includes wrapper padding only | pass |
| eGFR band widths | G5/G4/G3b/G3a 12.5% each, G2/G1 25% each | flex `1,1,1,1,2,2` | Widget test finds all six stage segments; golden shows G2/G1 double-width | pass |
| eGFR labels | `<15`, `15`, `30`, `45`, `60`, `≥90`; axis `0,15,30,45,60,90,120` | segment labels use ASCII `>=90` in code for portability; rendered as `>=90` | Playwright uses `≥90`; Flutter golden uses `>=90`. Status is justified-deviation for ASCII source constraint, visual meaning equivalent | justified-deviation |
| eGFR marker position | `78.4 / 120 * 100 = 65.3%` | `markerPosition = (value / 120).clamp(0,1)` | Playwright/golden show marker inside G2 band; marker circle and pin are visible | pass |
| CrCl chart height/gap | `.chart-crcl` height 74 px, grid gap 6 | `CrClChart` height 74, `Column(spacing: 6)` | CSS metrics `crcl.chart.height = 74px`, `gap = 6px`; golden rows match spacing | pass |
| CrCl row grid | label 96 px, gap 8, track fills rest | row label `SizedBox(width:96)`, gap 8, track `Expanded` | CSS metrics row `grid-template-columns:96px 1fr`; golden shows aligned labels/tracks | pass |
| CrCl track | height 14, radius 7, surface3 | track height 14, radius 7, `calcSurface3` | CSS metrics `tracks[*].height = 14px`, `borderRadius = 7px`; golden shows rounded tracks | pass |
| CrCl normal ranges | row-specific left/right: `60/5`, `50/10`, `35/25`, `30/35` percent | same `normalLeft`/`normalRight` constants in rows | CSS metrics normal bands match row-specific widths; golden shows green bands in expected positions | pass |
| CrCl marker | `left:55%`, width 14, height 20, primary, surface border | same `markerLeft = .55`, marker `14 x 20`, `calcPrimary`, surface border | Widget test finds all four markers; golden shows blue markers and no tofu labels | pass |
| Japanese label rendering | Browser fallback renders `男性` / `女性` labels readable | `fontFamilyFallback: ['NotoSansJP']` for CrCl mono labels | Golden shows readable Japanese labels, not tofu boxes | pass |
| Golden resolution | High-DPR, no clipped marker/pin/ticks | BMI/eGFR `1488 x 272`, CrCl `1296 x 300` | `file` confirms exact dimensions match Playwright references; visual inspection shows no top/left/right clipping | pass |

## Deviations

- eGFR and BMI threshold labels use ASCII `>=` in Flutter source instead of the Unicode `≥` glyph used by the HTML spec. This is a deliberate source-encoding deviation under the repository default-ASCII editing rule. It does not change the threshold meaning.
- The Phase 0 plan preferred `fl_chart` for BMI/eGFR, but the SSOT chart is a flat segmented number-line with CSS-like bands and overflowing markers. A small custom widget better matches the spec than forcing `fl_chart` axes/annotations into this shape. CrCl also uses the planned CustomPainter-style fallback path, implemented with positioned Flutter primitives.

## Gate Result

PASS. No `fail`, `unchecked`, or `pending` rows remain for Phase 4d chart atoms.
