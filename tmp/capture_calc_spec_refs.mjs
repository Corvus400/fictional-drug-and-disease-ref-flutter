import fs from 'node:fs/promises';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

const specHtml = process.env.CALC_SPEC_HTML;
const outDir = process.env.CALC_SPEC_REF_DIR;
const playwrightIndex = process.env.PLAYWRIGHT_INDEX_MJS;
const deviceScaleFactor = Number.parseFloat(
  process.env.CALC_SPEC_DEVICE_SCALE_FACTOR ?? '4',
);

if (!specHtml || !outDir || !playwrightIndex) {
  throw new Error(
    'Set CALC_SPEC_HTML, CALC_SPEC_REF_DIR, and PLAYWRIGHT_INDEX_MJS.',
  );
}

if (!Number.isFinite(deviceScaleFactor) || deviceScaleFactor < 1) {
  throw new Error('CALC_SPEC_DEVICE_SCALE_FACTOR must be a number >= 1.');
}

const { chromium } = await import(pathToFileURL(playwrightIndex).href);

await fs.mkdir(outDir, { recursive: true });

const browser = await chromium.launch();
const page = await browser.newPage({
  viewport: { width: 1440, height: 1100 },
  deviceScaleFactor,
});

await page.goto(pathToFileURL(specHtml).href);
await page.waitForSelector('#atom-root .atom-card');
await page.evaluate(() => document.fonts.ready);

const segmentedCard = page
  .locator('#atom-root .atom-card')
  .filter({ hasText: 'Segmented control' })
  .first();
await segmentedCard.screenshot({
  path: path.join(outDir, 'spec_segmented_control_card.png'),
});

const toolRow = segmentedCard.locator('.row').filter({ hasText: 'tool' }).first();
const sexRow = segmentedCard.locator('.row').filter({ hasText: 'sex' }).first();
await toolRow.screenshot({
  path: path.join(outDir, 'spec_segmented_tool_row.png'),
});
await sexRow.screenshot({
  path: path.join(outDir, 'spec_segmented_sex_row.png'),
});

const metrics = await segmentedCard.evaluate((card) => {
  const rect = (element) => {
    const r = element.getBoundingClientRect();
    return {
      x: Math.round(r.x * 100) / 100,
      y: Math.round(r.y * 100) / 100,
      width: Math.round(r.width * 100) / 100,
      height: Math.round(r.height * 100) / 100,
    };
  };
  const style = (element) => {
    const s = window.getComputedStyle(element);
    return {
      backgroundColor: s.backgroundColor,
      borderRadius: s.borderRadius,
      boxShadow: s.boxShadow,
      color: s.color,
      display: s.display,
      fontFamily: s.fontFamily,
      fontSize: s.fontSize,
      fontWeight: s.fontWeight,
      gap: s.gap,
      height: s.height,
      letterSpacing: s.letterSpacing,
      padding: s.padding,
    };
  };
  const query = (selector) => {
    const element = card.querySelector(selector);
    if (!element) {
      throw new Error(`Missing selector: ${selector}`);
    }
    return element;
  };

  const tool = query('.seg');
  const toolSelected = query('.seg .opt.on');
  const toolOption = query('.seg .opt:not(.on)');
  const sex = query('.sex-seg');
  const sexSelected = query('.sex-seg .opt.on');
  const sexOption = query('.sex-seg .opt:not(.on)');
  const sexIcon = query('.sex-seg .opt.on .ico');

  return {
    tool: {
      rect: rect(tool),
      style: style(tool),
      selectedRect: rect(toolSelected),
      selectedStyle: style(toolSelected),
      optionStyle: style(toolOption),
      labels: [...tool.querySelectorAll('.opt')].map((e) => e.textContent),
    },
    sex: {
      rect: rect(sex),
      style: style(sex),
      selectedRect: rect(sexSelected),
      selectedStyle: style(sexSelected),
      optionStyle: style(sexOption),
      iconRect: rect(sexIcon),
      iconStyle: style(sexIcon),
      labels: [...sex.querySelectorAll('.opt')].map((e) => e.textContent),
    },
  };
});

await fs.writeFile(
  path.join(outDir, 'spec_segmented_metrics.json'),
  `${JSON.stringify(metrics, null, 2)}\n`,
);

const resultCard = page
  .locator('#atom-root .atom-card')
  .filter({ hasText: 'Result card' })
  .first();
await resultCard.screenshot({
  path: path.join(outDir, 'spec_result_card_atom_card.png'),
});

const resultMetrics = await resultCard.evaluate((card) => {
  const rect = (element) => {
    const r = element.getBoundingClientRect();
    return {
      x: Math.round(r.x * 100) / 100,
      y: Math.round(r.y * 100) / 100,
      width: Math.round(r.width * 100) / 100,
      height: Math.round(r.height * 100) / 100,
    };
  };
  const style = (element) => {
    const s = window.getComputedStyle(element);
    return {
      backgroundColor: s.backgroundColor,
      border: s.border,
      borderRadius: s.borderRadius,
      boxShadow: s.boxShadow,
      color: s.color,
      display: s.display,
      fontFamily: s.fontFamily,
      fontSize: s.fontSize,
      fontWeight: s.fontWeight,
      gap: s.gap,
      height: s.height,
      letterSpacing: s.letterSpacing,
      lineHeight: s.lineHeight,
      padding: s.padding,
    };
  };
  const query = (selector) => {
    const element = card.querySelector(selector);
    if (!element) {
      throw new Error(`Missing selector: ${selector}`);
    }
    return element;
  };

  const result = query('.result');
  const title = query('.result .ttl');
  const formula = query('.result .formula-tag');
  const value = query('.result .value');
  const unit = query('.result .value .unit');
  const badge = query('.result .cbadge');
  const badgeShape = query('.result .cbadge .shape');

  return {
    result: { rect: rect(result), style: style(result) },
    title: { rect: rect(title), style: style(title), text: title.textContent },
    formula: {
      rect: rect(formula),
      style: style(formula),
      text: formula.textContent,
    },
    value: { rect: rect(value), style: style(value), text: value.textContent },
    unit: { rect: rect(unit), style: style(unit), text: unit.textContent },
    badge: { rect: rect(badge), style: style(badge), text: badge.textContent },
    badgeShape: { rect: rect(badgeShape), style: style(badgeShape) },
  };
});

await fs.writeFile(
  path.join(outDir, 'spec_result_card_metrics.json'),
  `${JSON.stringify(resultMetrics, null, 2)}\n`,
);

const historyCard = page
  .locator('#atom-root .atom-card')
  .filter({ hasText: 'History row' })
  .first();
await historyCard.screenshot({
  path: path.join(outDir, 'spec_history_atom_card.png'),
});

const historyMetrics = await historyCard.evaluate((card) => {
  const rect = (element) => {
    const r = element.getBoundingClientRect();
    return {
      x: Math.round(r.x * 100) / 100,
      y: Math.round(r.y * 100) / 100,
      width: Math.round(r.width * 100) / 100,
      height: Math.round(r.height * 100) / 100,
    };
  };
  const style = (element) => {
    const s = window.getComputedStyle(element);
    return {
      backgroundColor: s.backgroundColor,
      border: s.border,
      borderBottom: s.borderBottom,
      borderRadius: s.borderRadius,
      color: s.color,
      display: s.display,
      fontFamily: s.fontFamily,
      fontSize: s.fontSize,
      fontWeight: s.fontWeight,
      gap: s.gap,
      gridTemplateColumns: s.gridTemplateColumns,
      height: s.height,
      lineHeight: s.lineHeight,
      marginBottom: s.marginBottom,
      marginRight: s.marginRight,
      overflow: s.overflow,
      padding: s.padding,
      position: s.position,
      transform: s.transform,
      width: s.width,
    };
  };
  const query = (selector) => {
    const element = card.querySelector(selector);
    if (!element) {
      throw new Error(`Missing selector: ${selector}`);
    }
    return element;
  };
  const defaultRow = query('.history .list .row');
  const defaultWhen = query('.history .list .row .when');
  const defaultRes = query('.history .list .row .res');
  const defaultIcon = query('.history .list .row .ico');
  const swipeContainer = query('.history .list .swipe-row');
  const swipeRow = query('.history .list .swipe-row .row');
  const deleteAction = query('.history .list .swipe-row .delete');
  const deleteIcon = query('.history .list .swipe-row .delete .ico');
  const empty = query('.history .list.empty');
  const emptyIcon = query('.history .list.empty .ico');

  return {
    defaultRow: {
      rect: rect(defaultRow),
      style: style(defaultRow),
      text: defaultRow.textContent,
    },
    defaultWhen: {
      rect: rect(defaultWhen),
      style: style(defaultWhen),
      text: defaultWhen.textContent,
    },
    defaultResult: {
      rect: rect(defaultRes),
      style: style(defaultRes),
      text: defaultRes.textContent,
    },
    defaultIcon: {
      rect: rect(defaultIcon),
      style: style(defaultIcon),
      text: defaultIcon.textContent,
    },
    swipeContainer: {
      rect: rect(swipeContainer),
      style: style(swipeContainer),
    },
    swipeRow: {
      rect: rect(swipeRow),
      style: style(swipeRow),
    },
    deleteAction: {
      rect: rect(deleteAction),
      style: style(deleteAction),
      text: deleteAction.textContent,
    },
    deleteIcon: {
      rect: rect(deleteIcon),
      style: style(deleteIcon),
      text: deleteIcon.textContent,
    },
    empty: {
      rect: rect(empty),
      style: style(empty),
      text: empty.textContent,
    },
    emptyIcon: {
      rect: rect(emptyIcon),
      style: style(emptyIcon),
      text: emptyIcon.textContent,
    },
  };
});

await fs.writeFile(
  path.join(outDir, 'spec_history_metrics.json'),
  `${JSON.stringify(historyMetrics, null, 2)}\n`,
);

const phoneHistoryExpanded = page
  .locator('[data-frame-label="iPhone × Light × history-expanded (BMI)"] .history')
  .first();
const phoneHistorySwipe = page
  .locator('[data-frame-label="iPhone × Light × swipe-to-delete (BMI)"] .history')
  .first();
const phoneHistoryEmpty = page
  .locator('[data-frame-label="iPhone × Light × history-empty (BMI)"] .history')
  .first();

await phoneHistoryExpanded.screenshot({
  path: path.join(outDir, 'spec_history_phone_expanded.png'),
});
await phoneHistorySwipe.screenshot({
  path: path.join(outDir, 'spec_history_phone_swipe.png'),
});
await phoneHistoryEmpty.screenshot({
  path: path.join(outDir, 'spec_history_phone_empty.png'),
});

await browser.close();
