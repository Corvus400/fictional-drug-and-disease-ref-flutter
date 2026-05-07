# Detail Screen Gap Map

Source plan: `golden-users-todayamar-desktop-claude-de-wondrous-moon.refined.md`.

This document is the Phase 2 input for the TDD cycles. It maps every design
section in `Detail Spec.html` to the current Flutter implementation and the
golden evidence checked at Phase 2 start.

## Evidence Snapshot

- `Detail Spec.html` was read across lines 1-1770. Key design anchors:
  - tokens and frame CSS: L118-L167
  - shared visual primitives: L211-L470
  - tablet two-pane layout: L528-L536 and L1503-L1523
  - Drug D1-D18 builders: L1123-L1243, compact phone bodies L1245-L1323
  - Disease E1-E17 builders: L1324-L1481
  - fixed footer with bookmark and dose calculator: L1497, L1520, L1534, L1656
- Existing golden images were reviewed via a 22-image contact sheet generated
  from `test/ui/drug/goldens/macos/*.png` and
  `test/ui/disease/goldens/macos/*.png`.
- Current golden state: phone-sized tiles render an app bar, header text,
  ChoiceChip-like tab row, sparse flat content, and one full-width bookmark
  footer. Tablet tiles still use the same vertical layout instead of the
  240dp navigation pane + content pane specified by the design.
- Related plan evidence:
  - `linked-bubbling-sun-disease.refined-2.md` L22: `icd10Code` is intentionally
    not stored; Disease detail must use `icd10Chapter` rather than a detailed
    ICD-10 code such as `J18.9`.
  - `linked-bubbling-sun-disease.refined-2.md` L310-L329 defines E1-E18 field
    mapping and display conditions.
  - `linked-bubbling-sun-drug.refined-2.md` L507-L527 defines D1-D19 field
    mapping and display conditions.

## Gap Table

| ID (D/E番号) | Detail Spec.html 該当 line | 現実装 (lib/ui/<entity>/widgets/<tab>_tab.dart) | 既存 Golden の状態 | 仕様との差分 | 必要 widget (Phase 0 共通 widget で吸収可否) | TDD 種別 (bugfix/cycle) | 担当 Phase |
|---|---:|---|---|---|---|---|---|
| D1 | L1126-L1131, L1248-L1253 | `drug_detail_view.dart` header text uses generic/brand/kana above tabs; tab widget does not own hero. | Header text appears, but no image hero block. | Missing `.hero`, `imageUrl` visual, exact meta typography, and design hierarchy. | `detail_panel` is not enough; needs detail hero/header widget. | bugfix | A1 |
| D2 | L1132-L1138, L1254-L1257 | Header badges are partially present in view-level layout via chips. | Some small chips appear near the header. | Badge colors/shape/order, manufacturer/revisedAt line, route/dosage/regulatory density do not match spec. | `detail_badge`, `detail_chip`, detail hero/header widget. | bugfix | A1 |
| D3 | L1141-L1146, L1260-L1262 | `drug_detail_overview_tab.dart` renders warning title + plain text list. | Warning appears as flat text. | Missing red bordered `.warn-banner`, dot icon, compact one-line primary mock treatment, exact padding/color/radius. | `detail_warn_banner`, `detail_panel`. | cycle | A1 |
| D4 | L1147-L1152, L1263-L1271 | `drug_detail_overview_tab.dart` renders ATC code/category/YJ as plain text. | ATC is visible but not in key-value panel. | Missing D index, ATC hierarchy formatting, `.kv` rows, panel border and typography. | `detail_panel`, `detail_kv_row`, `detail_expand_tile` for compact grouping. | cycle | A1 |
| D5 | L1154-L1160, L1263-L1271 | `drug_detail_overview_tab.dart` renders active ingredient/appearance/id code only. | Composition is visible but sparse. | Missing exact key-value layout, additives row when present, D5 grouping, dosageForm badge integration. | `detail_panel`, `detail_kv_row`, `detail_badge`. | cycle | A1 |
| D6 | L1172-L1173, L1286-L1291 | `drug_detail_caution_tab.dart` currently starts with D10-like precautions; contraindications are not rendered in this tab. | Caution golden lacks a D6 contraindication panel. | Missing D6 panel, numbered contraindications, and spec ordering before D10/D11. | `detail_panel`, numbered list helper if introduced. | cycle | A3 |
| D7 | L1163-L1164, L1273-L1275 | `drug_detail_dose_tab.dart` focuses on dosage; indications are not rendered. | Dose golden lacks an indications panel. | Missing D7 section in dose tab before D8. | `detail_panel`. | cycle | A2 |
| D8 | L1165-L1168, L1276-L1279 | `drug_detail_dose_tab.dart` has ChoiceChip inner tabs for standard/pediatric/renal/hepatic. | Inner tabs exist but look like chips. | Needs `.tabs.inner` visual, labels standard/age/renal/hepatic per spec, exact padding, indicator, and body typography. | Existing Material TabBar or styled segmented tab, `detail_panel`. | bugfix | A2 |
| D9 | L1169-L1170, L1280-L1284 | Dosage related precautions are not shown in current dose tab. | Dose golden lacks D9 accordion/panel. | Missing D9 section and compact accordion behavior. | `detail_panel`, `detail_accordion`. | cycle | A2 |
| D10 | L1174-L1182 | `drug_detail_caution_tab.dart` renders ExpansionTile list for precautions. | Caution golden shows expandable rows. | Needs `.acc` radius/background/padding, seven expected groups where present, chevron behavior, D index and grouping. | `detail_accordion`, `detail_panel`, `detail_badge`. | bugfix | A3 |
| D11 | L1183-L1186 | `drug_detail_caution_tab.dart` renders two ChoiceChips but no interaction body. | Caution golden shows interaction controls with little/no body. | Needs `.tabs.inner`, prohibited/caution content, empty state text, and domain-driven rows. | Styled inner tabs, `detail_panel`, optional table/list helper. | cycle | A3 |
| D12 | L1188-L1191, L1293-L1296 | `drug_detail_adverse_effects_tab.dart` renders serious adverse effects. | Serious adverse effects are visible as flat/standard content. | Needs `.serious-card` danger styling, metadata row, exact spacing/radius and D index. | `detail_panel`, `detail_warn_banner` or `detail_serious_card`. | bugfix | A4 |
| D13 | L1192-L1197, L1297-L1300 | `drug_detail_adverse_effects_tab.dart` renders other adverse effects. | Frequency groups are visible but not spec-styled. | Needs frequency row layout, chip-like values, and inner frequency tab compact mode. | `detail_panel`, frequency row helper or detail chip. | bugfix | A4 |
| D14 | L1199-L1214, L1301-L1308 | `drug_detail_pharmacokinetics_tab.dart` renders pharmacokinetics and parameters. | PK content is visible but not a spec table. | Needs key-value rows plus PK parameter table with exact table style. | `detail_panel`, `detail_kv_row`, `detail_pk_table`. | bugfix | A5 |
| D15 | L1215-L1219, L1308-L1309 | `drug_detail_pharmacokinetics_tab.dart` renders D15 as accordions according to existing test. | Accordions are visible. | Needs spec `.acc` styling and exact clinical/pharmacology/overdose grouping. | `detail_accordion`, `detail_panel`. | bugfix | A5 |
| D16 | L1221-L1228, L1311-L1322 | `drug_detail_related_tab.dart` renders related-tab content. | Related golden shows sparse related content. | Needs handling/package/insurance table before references/related diseases. | `detail_panel`, `detail_exam_table` or generic table widget. | cycle | A6 |
| D17 | L1229-L1235 | Current related tab has references/approval only partially or flat. | References are not visibly spec-aligned. | Needs approval conditions, reference ExpansionTile rows, and revisedAt line. | `detail_expand_tile`, `detail_panel`. | cycle | A6 |
| D18 | L1236-L1242 | Current related tab has related disease navigation support in tests for comparable patterns. | Related disease cards are not a spec carousel. | Needs horizontal 184dp cards with image placeholder, id, badges, and tap to disease detail. | `detail_carousel`, `detail_badge`. | cycle | A6 |
| D19 | L164-L167, L1497, L1520, L1534, L1656 | `detail_bookmark_footer.dart` renders one bookmark button only. | Every golden has one full-width bookmark footer. | Must become two buttons: `ブックマーク` + `用量計算`, 44dp height, 22dp radius, calc icon/path/primary color, `/calc` navigation. | `detail_footer`, `detail_dose_calc_button`, updated bookmark footer. | cycle | A7 |
| E1 | L1394-L1397, L1325-L1329 | `disease_detail_view.dart` header renders id/name/kana above tabs; English name not shown in hero style. | Header text appears but no hero/meta structure. | Needs hero meta hierarchy, nameEnglish where available, exact typography; no ICD-10 fine code. | detail hero/header widget, `detail_panel` not enough. | bugfix | B1 |
| E2 | L1398-L1404, L1330-L1331 | Classification badges are incomplete and not spec-styled. | Some header chips appear. | Must render `icd10Chapter`, medical departments, chronicity, infectious as badges; detailed ICD-10 code is intentionally excluded. | `detail_badge`, `detail_chip`, detail hero/header widget. | bugfix | B1 |
| E3 | L1406-L1407, L1333-L1334 | `disease_detail_overview_tab.dart` renders synonyms. | Synonyms are visible. | Needs D/E index, panel shell, exact badge styling and wrapping. | `detail_panel`, `detail_badge`. | bugfix | B1 |
| E4 | L1408-L1409, L1335-L1336 | `disease_detail_overview_tab.dart` renders summary. | Summary is visible as plain content. | Needs panel typography, compact summary behavior, exact spacing. | `detail_panel`. | bugfix | B1 |
| E5 | L1410-L1415, L1337-L1343 | Epidemiology is not covered by existing overview test name and appears absent from current sparse overview. | Overview golden lacks a clear epidemiology key-value card. | Needs prevalence/onset age/sex ratio key-value card or compact accordion. | `detail_panel`, `detail_kv_row`, `detail_accordion`. | cycle | B1 |
| E6 | L1417-L1418, L1344-L1346 | `disease_detail_diagnosis_tab.dart` includes diagnosis-related content; etiology may be absent or flat. | Diagnosis golden has sparse text/sections. | Needs E6 cause/pathophysiology panel before symptoms/diagnosis details. | `detail_panel`. | bugfix | B2 |
| E7 | L1419-L1425, L1347-L1349 | Symptoms are partially rendered. | Symptom chips are visible but not spec-styled. | Needs main symptom badges, outline associated symptoms, onset pattern line, exact badge wrapping. | `detail_panel`, `detail_badge`, `detail_chip`. | cycle | B2 |
| E8 | L1426-L1428, L1350-L1355 | Diagnosis criteria inner tabs exist according to tests. | Diagnosis criteria appear but compact structure differs. | Needs numbered required criteria, helper text, and spec panel styling. | `detail_panel`, styled inner tabs. | bugfix | B2 |
| E9 | L1429-L1438 | Required exams are not spec-aligned. | Diagnosis golden lacks a full exam table. | Needs exam/category/finding table with category pills. | `detail_exam_table`, `detail_badge`, `detail_panel`. | cycle | B2 |
| E10 | L1439-L1445 | Severity grading is present only if implemented in diagnosis tab; current golden is not spec grade cards. | Diagnosis golden lacks four grade cards. | Needs grade blocks for severity levels and exact `.grade` layout. | `detail_severity_grade`, `detail_panel`. | cycle | B2 |
| E11 | L1447-L1451, L1356-L1359 | `disease_detail_treatment_tab.dart` covers treatment-side content. | Treatment golden has sparse differential/complication text. | Needs two-row key-value panel for differential diagnoses and complications. | `detail_panel`, `detail_kv_row`. | bugfix | B3 |
| E12 | L1452-L1460, L1360-L1368 | Treatment tab has inner tab behavior according to current patterns/tests. | Treatment golden has controls but not table-styled spec. | Needs drug/non-drug/acute inner tabs and treatment table. | Styled inner tabs, `detail_exam_table`, `detail_panel`. | cycle | B3 |
| E13 | L1461-L1463, L1369-L1371 | `disease_detail_clinical_course_tab.dart` renders prognosis. | Clinical course golden has sparse prognosis content. | Needs exactly E13 panel in clinical course tab, no treatment content mixed in. | `detail_panel`. | bugfix | B4 |
| E14 | L1464-L1465, L1372-L1373 | `disease_detail_clinical_course_tab.dart` renders prevention. | Prevention appears but not spec-styled. | Needs E14 numbered prevention panel, exact panel spacing. | `detail_panel`. | bugfix | B4 |
| E15 | L1467-L1472, L1375-L1384 | `disease_detail_related_tab.dart` has related drug navigation test. | Related drug content appears as sparse cards/list. | Needs carousel cards with image placeholder, id, badges, and drug-detail navigation. | `detail_carousel`, `detail_badge`. | cycle | B5 |
| E16 | L1473-L1478 | `disease_detail_related_tab.dart` likely renders related diseases. | Related disease carousel is not spec-aligned. | Needs second carousel for related diseases with disease-detail navigation. | `detail_carousel`, `detail_badge`. | cycle | B5 |
| E17 | L1479 | Revised date is not a dedicated spec row in current related golden. | Revised date is not prominent. | Needs mono revisedAt line within related tab. | `detail_panel` or footer metadata helper. | cycle | B5 |
| E18 | L164-L167, L1497, L1520, L1534, L1656 | `detail_bookmark_footer.dart` renders one bookmark button only. | Every disease golden has one full-width bookmark footer. | Must reuse common footer with bookmark + dose calculator and `/calc` navigation argument. | `detail_footer`, `detail_dose_calc_button`. | cycle | B6 |

## Cross-Cutting Gaps

| Area | Detail Spec.html line | Current state | Required action | Phase |
|---|---:|---|---|---|
| Theme tokens | L118-L147, L621-L658 | Existing app theme does not expose detail-specific token extension. | Add detail `ThemeExtension` and map light/dark tokens without raw color use in UI. | 0 |
| Shared visual primitives | L211-L470 | Existing shared widgets are limited to chip, bookmark footer, responsive layout. | Add/repair panel, accordion, badge, carousel, kv row, dose calc button, warn banner, tables, severity grade, expand tile. | 0 |
| Static guard | L118-L470 | Guards exist but do not cover all new detail primitives. | Extend hardcoded color and magic-number detection across `lib/ui/drug`, `lib/ui/disease`, `lib/ui/detail`. | 0 |
| Disease tab order | L1481 | Current enum/view order is overview, diagnosis, clinical course, treatment, related. | Render as overview, diagnosis, treatment, clinical course, related without renaming files. | B |
| Tablet two-pane | L528-L536, L1503-L1523 | Golden contact sheet shows tablet cases using phone-style vertical layout. | Implement 240dp nav pane + content pane in `detail_responsive_layout.dart`. | C |
| Footer action | L164-L167, L1497, L1520, L1534, L1656 | One bookmark button only. | Two-button footer with bookmark and dose calculator on both Drug and Disease. | A7/B6 |

## Phase 2 Notes For Red Design

- Treat `Detail Spec.html` compact phone bodies as the phone golden target and
  all-expanded/tablet builders as coverage references for hidden subtab and
  accordion content.
- Use `icd10Chapter` for E2. Do not add or fake `icd10Code`.
- Use repository domain models as typed SSOT. Do not introduce
  `Map<String, dynamic>` or `dynamic>` in detail domain code.
- Golden Red steps must read the relevant existing PNG before changing
  production UI, then update goldens only in Green.
