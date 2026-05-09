# Calc Phase 4c Verdict: History Atoms

Gate source: `tmp/ui_golden_design_gate.md`.

## References

- Playwright SSOT atom reference: `tmp/calc_spec_refs/spec_history_atom_card.png`
  - size: 1080 x 2096 (CSS atom card 270 x 524, DPR 4)
- Playwright wider state reference: `tmp/calc_spec_refs/spec_history_phone_swipe.png`
  - size: 1432 x 1020 (iPhone Light swipe-to-delete history section, DPR 4)
- Flutter focused golden: `test/ui/calc/widgets/goldens/macos/calc_history_atoms_light.png`
  - size: 1432 x 1020
- CSS metrics: `tmp/calc_spec_refs/spec_history_metrics.json`
- Tests:
  - `test/ui/calc/widgets/calc_history_atoms_test.dart`
  - `test/ui/calc/widgets/calc_history_atoms_golden_test.dart`

## Spec / Flutter / Golden Table

| Item | Spec value | Flutter implementation value | Golden / Playwright confirmation | Status |
|---|---:|---:|---|---|
| History row content layout | `display:grid; grid-template-columns:1fr auto; gap:8px` | `Row` with `Expanded` content + 8 px gap + 18 px refresh icon | `spec_history_phone_swipe.png` and `calc_history_atoms_light.png` both show trailing refresh icon separated from content | pass |
| Row padding | `8px 12px` | `EdgeInsets.symmetric(horizontal: 12, vertical: 8)` | CSS metrics `defaultRow.style.padding = 8px 12px`; widget test renders row content with same spacing tokens | pass |
| Row text font | `font:500 12px Noto Sans JP` | `AppTypography.labelM` with weight 500 | CSS metrics `defaultRow.style.fontSize = 12px`, `fontWeight = 500`; golden shows same row density at wide width | pass |
| Date font | `font:600 11px JetBrains Mono`, muted color, margin-right 6 | `AppTypography.monoS`, weight 600, `calcMuted`, text span followed by 2-space separator | CSS metrics `defaultWhen.style.fontSize = 11px`, `fontWeight = 600`, `marginRight = 6px`; widget test verifies date text is present in RichText | pass |
| Result font weight | `.res { font-weight:700 }` | result `TextSpan` uses `FontWeight.w700` | CSS metrics `defaultResult.style.fontWeight = 700`; widget test verifies result text is present in RichText | pass |
| Refresh icon | Material Symbols `refresh`, 18 px, muted | `Icon(Symbols.refresh, size: 18, color: calcMuted)` | Widget test finds `Symbols.refresh`; Playwright and Flutter goldens both show trailing refresh icon | pass |
| Swipe viewport | `.list` inline state `height:38px; overflow:hidden` | `CalcHistoryRow(deleteRevealed: true)` clips visible area to 38 px | Widget test expects `CalcHistoryRow` size `240 x 38`; wide golden shows top row clipped like reference | pass |
| Swipe translation | `.swipe-row .row { transform: translateX(-72px) }` | `Transform.translate(offset: Offset(-72, 0))` | CSS metrics `swipeRow.style.transform = matrix(... -72, 0)`; Flutter golden shows left-shifted row and delete action exposure | pass |
| Delete action width | `72px` | `_DeleteAction` width 72 px | Widget test expects `history-delete` width 72; CSS metrics `deleteAction.style.width = 72px` | pass |
| Delete action color | `var(--c6-error)` = `rgb(179,38,30)` in SSOT | `AppPalette.calcError` | Widget test compares delete box color to palette; Playwright and Flutter goldens show red delete panel | pass |
| Delete icon / label | Material Symbols `delete` 18 px + localized label, gap 4 | `Symbols.delete` 18 px + caller-supplied `deleteLabel`, gap 4 | CSS metrics `deleteIcon.style.fontSize = 18px`, `deleteAction.style.gap = 4px`; no production hard-coded label | pass |
| Empty container | `.list.empty` padding `28px 12px`, border hairline, radius 10 | `CalcHistoryEmptyState` padding `28/12`, border `calcHairline`, radius `AppRadii.card` 10 | Widget test expects `240 x 115`; CSS metrics empty padding and radius match; golden shows same empty card structure | pass |
| Empty icon | Material Symbols `history_toggle_off`, 36 px, muted2, margin-bottom 6 | `Symbols.history_toggle_off`, size 36, `calcMuted2`, `SizedBox(height:6)` | Widget test finds icon; CSS metrics `emptyIcon.style.fontSize = 36px`, `marginBottom = 6px` | pass |
| Empty text | `font:500 12px Noto Sans JP`, muted, centered | `AppTypography.labelM`, weight 500, `calcMuted`, centered | Widget test finds message; Playwright and Flutter goldens show centered empty text | pass |
| Golden resolution | Wider component/state screenshot, not narrow atom-only visual | Flutter golden uses 1432 x 1020, same dimensions as wide Playwright state reference | `file` confirms both `calc_history_atoms_light.png` and `spec_history_phone_swipe.png` are 1432 x 1020 | pass |
| Extra elements absent | Atom widgets do not include screen nav/app bar/charts | Golden contains only history states on white inspection background | Focused golden excludes unrelated screen chrome; wider Playwright reference retained separately for state comparison | pass |

## Deviations

- The committed golden is a wide focused history-state composite, not the narrow atom-card image. This is intentional because the narrow atom-card reference was too compressed for reliable review. The narrow Playwright reference is retained for CSS atom-card evidence, while the golden is aligned to the wider history state reference.

## Gate Result

PASS. No `fail`, `unchecked`, or `pending` rows remain for Phase 4c history atoms.
