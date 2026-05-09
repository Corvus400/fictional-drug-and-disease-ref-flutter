import fs from 'node:fs/promises';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

const specHtml = process.env.CALC_SPEC_HTML;
const outDir = process.env.CALC_SPEC_REF_DIR;
const playwrightIndex = process.env.PLAYWRIGHT_INDEX_MJS;

if (!specHtml || !outDir || !playwrightIndex) {
  throw new Error(
    'Set CALC_SPEC_HTML, CALC_SPEC_REF_DIR, and PLAYWRIGHT_INDEX_MJS.',
  );
}

const { chromium } = await import(pathToFileURL(playwrightIndex).href);

await fs.mkdir(outDir, { recursive: true });

const browser = await chromium.launch();
const page = await browser.newPage({
  viewport: { width: 1440, height: 1100 },
  deviceScaleFactor: 2,
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

await browser.close();
