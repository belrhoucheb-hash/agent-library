#!/usr/bin/env node
// Genereert company/zendiq-afdelingen.html uit de markdown-bronnen in
// company/. De HTML is een afgeleide: nooit met de hand bewerken.
//
//   node company/build-page.js            schrijft de pagina
//   node company/build-page.js --check    exit 1 als de pagina niet in sync is
"use strict";

const fs = require("fs");
const path = require("path");

const DIR = __dirname;
const OUT = path.join(DIR, "zendiq-afdelingen.html");
const URL = "https://claude.ai/code/artifact/4377020a-e400-41b4-a43e-07a0a37d78ac";
const MAANDEN = ["jan", "feb", "mrt", "apr", "mei", "jun", "jul", "aug", "sep", "okt", "nov", "dec"];

// ── Helpers ──────────────────────────────────────────────────

function read(rel) {
  return fs.readFileSync(path.join(DIR, rel), "utf8").replace(/\r\n/g, "\n");
}

function esc(s) {
  return String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

/** Inline opmaak: **vet**, `code` (of tijd-span in ritme). */
function inline(s, codeClass = null) {
  let out = esc(s);
  out = out.replace(/\*\*(.+?)\*\*/g, "<b>$1</b>");
  out = out.replace(/`([^`]+)`/g, codeClass ? `<span class="${codeClass}">$1</span>` : "<code>$1</code>");
  return out;
}

/** "ok: geïnstalleerd 3 sep" → <span class="chip ok">geïnstalleerd 3 sep</span> */
function chip(s) {
  const m = /^(ok|warn|crit|info|own|acc):\s*(.+)$/.exec(s.trim());
  if (!m) return esc(s);
  return `<span class="chip ${m[1]}">${esc(m[2])}</span>`;
}

function fmtDate(iso) {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(iso.trim());
  if (!m) return esc(iso);
  return `${Number(m[3])} ${MAANDEN[Number(m[2]) - 1]}`;
}

function fmtDates(s) {
  return s.split(",").map((d) => fmtDate(d)).join(" · ");
}

function parseTable(lines) {
  const rows = lines.filter((l) => l.trim().startsWith("|")).map((l) =>
    l.trim().replace(/^\||\|$/g, "").split("|").map((c) => c.trim())
  );
  if (rows.length < 2) return [];
  return rows.slice(2); // kop en scheidingsregel eraf
}

/** Splitst markdown in { title, keys, sections: { Naam: [regels] } }. */
function parseDoc(text) {
  const lines = text.split("\n");
  const doc = { title: "", keys: {}, sections: {} };
  let current = null;
  for (const line of lines) {
    if (line.startsWith("# ")) { doc.title = line.slice(2).trim(); continue; }
    if (line.startsWith("## ")) { current = line.slice(3).trim(); doc.sections[current] = []; continue; }
    if (current) { doc.sections[current].push(line); continue; }
    const kv = /^([a-z]+):\s*(.*)$/.exec(line);
    if (kv) doc.keys[kv[1]] = kv[2].trim();
  }
  return doc;
}

function text(sec) {
  return (sec || []).map((l) => l.trim()).filter(Boolean).join(" ");
}

function slugOf(file) {
  return file.replace(/^\d+-/, "").replace(/\.md$/, "");
}

// ── Bronnen ──────────────────────────────────────────────────

function loadAfdelingen() {
  const dir = path.join(DIR, "afdelingen");
  return fs.readdirSync(dir)
    .filter((f) => /^\d+-.*\.md$/.test(f))
    .sort()
    .map((f) => ({ slug: slugOf(f), ...parseDoc(read(path.join("afdelingen", f))) }));
}

// ── Renderers ────────────────────────────────────────────────

function renderStrip(afdelingen) {
  return afdelingen.map((a) => {
    const [cls, txt] = (a.keys.strip || "info: ").split("|").map((s) => s.trim());
    return `    <a${a.keys.lead === "true" ? ' class="lead"' : ""} href="#${a.slug}"><span class="name">${esc(a.title)}</span><span class="meta">${esc(a.keys.meta || "")}</span><span><span class="chip ${esc(cls)}">${esc(txt)}</span></span></a>`;
  }).join("\n");
}

function renderFacts(a) {
  const rows = [
    ["doel", inline(text(a.sections.Doel))],
    ["meetlat", inline(text(a.sections.Meetlat))],
    ["ritme", inline(text(a.sections.Ritme), "t")],
  ];
  if (a.sections.Regel) rows.push(["regel", inline(text(a.sections.Regel))]);
  return `<dl class="facts">\n${rows.map(([k, v]) => `        <dt>${k}</dt><dd>${v}</dd>`).join("\n")}\n      </dl>`;
}

function renderSkills(a) {
  const rows = parseTable(a.sections.Skills || []);
  const body = rows.map(([skill, detail, bron, status, beoordelen]) =>
    `        <tr><td class="skill">${inline(skill)}<small>${inline(detail)}</small></td><td>${inline(bron)}</td><td>${chip(status)}</td><td class="date">${inline(beoordelen)}</td></tr>`
  ).join("\n");
  return `<div class="skills">\n      <table>\n        <tr><th>Skill</th><th>Bron</th><th>Status</th><th>Beoordelen</th></tr>\n${body}\n      </table>\n    </div>`;
}

function renderLus(a) {
  const items = (a.sections.Lus || []).filter((l) => l.trim().startsWith("- "));
  const steps = items.map((l) => {
    let s = l.trim().slice(2);
    const missing = s.startsWith("!");
    if (missing) s = s.slice(1).trim();
    const [naam, who, state] = s.split("|").map((x) => x.trim());
    return `          <div class="step${missing ? " missing" : ""}"><span class="s">${esc(naam)}</span><span class="who">${esc(who)}</span><span class="state">${inline(state)}</span></div>`;
  }).join("\n");
  return `<div class="loop-wrap">\n        <div class="loop">\n${steps}\n        </div>\n      </div>`;
}

function renderProduct(a) {
  return `  <h2 id="${a.slug}">${esc(a.title)} <small>de verbeterlus</small></h2>
  <section class="dept" style="border-top:0; padding-top:0">
    <div>
      ${renderFacts(a)}
    </div>
    <div>
      ${renderLus(a)}
      <p class="rule">${inline(text(a.sections.Bevinding))}</p>
      <div style="margin-top:16px">${renderSkills(a)}</div>
    </div>
  </section>`;
}

function renderDept(a, last) {
  return `  <section class="dept${last ? " last" : ""}" id="${a.slug}">
    <div>
      <h3>${esc(a.title)}</h3>
      ${renderFacts(a)}
    </div>
    ${renderSkills(a)}
  </section>`;
}

function renderNulmeting() {
  const d = parseDoc(read("nulmeting.md"));
  const rows = parseTable(Object.values(d.sections)[0] || d.sections[""] || []);
  const tableLines = read("nulmeting.md").split("\n");
  const cells = parseTable(tableLines);
  const tiles = cells.map(([v, l, kleur]) =>
    `    <div><span class="v${kleur ? " " + esc(kleur) : ""}">${esc(v)}</span><span class="l">${inline(l)}</span></div>`
  ).join("\n");
  return `  <h2>Nulmeting <small>${esc(d.keys.datum || "")} · ${esc(d.keys.bron || "")}</small></h2>
  <div class="baseline">
${tiles}
  </div>
  <p class="note">Meting met <code>${esc(d.keys.script || "")}</code>, alleen aantallen, geen persoonsgegevens.</p>`;
}

function renderExperimenten() {
  const rows = parseTable(read("experimenten.md").split("\n"));
  const body = rows.map(([nr, naam, detail, ph, crit, meten, status]) =>
    `      <tr><td class="num">${esc(nr)}</td><td class="skill">${inline(naam)}<small>${inline(detail)}</small></td><td>${inline(ph)}</td><td>${inline(crit)}</td><td class="date">${fmtDates(meten)}</td><td>${chip(status)}</td></tr>`
  ).join("\n");
  return `  <h2>Experimenten <small>succescriterium vooraf · meetdatum vast</small></h2>
  <div class="skills">
    <table>
      <tr><th>Nr</th><th>Experiment</th><th>Probleem en hypothese</th><th>Succescriterium</th><th>Meten</th><th>Status</th></tr>
${body}
    </table>
  </div>`;
}

function renderLogboek() {
  const lines = read("logboek.md").split("\n");
  const entries = [];
  let cur = null;
  for (const line of lines) {
    if (line.startsWith("## ")) {
      const parts = line.slice(3).split("|").map((s) => s.trim());
      cur = { datum: parts[0], chips: parts.slice(1), velden: {} };
      entries.push(cur);
      continue;
    }
    const kv = cur && /^(probleem|hypothese|wijziging|resultaat|regel):\s*(.*)$/.exec(line);
    if (kv) cur.velden[kv[1]] = kv[2].trim();
  }
  const html = entries.map((e) => {
    const chips = e.chips.map((c) => { const [afd, kleur] = c.split(":"); return `<span class="chip ${esc(kleur || "ok")}">${esc(afd)}</span>`; }).join(" ");
    const dd = (k) => {
      const v = e.velden[k] || "";
      const open = /^open:/i.test(v) || v === "n.v.t.";
      return `      <dt>${k}</dt><dd class="${k === "regel" && !open ? "regel" : open ? "open" : ""}">${inline(v.replace(/^open:\s*/i, "open: "))}</dd>`;
    };
    return `  <div class="entry">
    <div class="d">${esc(e.datum)}<span>${chips}</span></div>
    <dl class="loopgrid">
${["probleem", "hypothese", "wijziging", "resultaat", "regel"].map(dd).join("\n")}
    </dl>
  </div>`;
  }).join("\n\n");
  return `  <h2>Logboek <small>probleem · hypothese · wijziging · resultaat · regel · nieuwste bovenaan</small></h2>\n\n${html}`;
}

function renderBesluiten() {
  const items = read("besluiten.md").split("\n").filter((l) => /^\d+\.\s/.test(l));
  return `  <h2>Open besluiten <small>aan Badr</small></h2>
  <ul class="decisions">
${items.map((l) => { const m = /^(\d+)\.\s+(.*)$/.exec(l); return `    <li><span class="q">${m[1]}</span><span>${inline(m[2])}</span></li>`; }).join("\n")}
  </ul>`;
}

function stamp(now) {
  const ams = new Date(now.toLocaleString("en-US", { timeZone: "Europe/Amsterdam" }));
  const bijgewerkt = `${ams.getDate()} ${MAANDEN[ams.getMonth()]} ${ams.getFullYear()}, ${String(ams.getHours()).padStart(2, "0")}:${String(ams.getMinutes()).padStart(2, "0")}`;
  const zondag = new Date(ams);
  zondag.setDate(ams.getDate() + ((7 - ams.getDay()) % 7 || 7));
  return { bijgewerkt, triage: `zo ${zondag.getDate()} ${MAANDEN[zondag.getMonth()]}` };
}

// ── Pagina ───────────────────────────────────────────────────

const CSS = read("page.css");

function build(now = new Date()) {
  const afdelingen = loadAfdelingen();
  const product = afdelingen.find((a) => a.slug === "product");
  const rest = afdelingen.filter((a) => a.slug !== "product");
  const st = stamp(now);
  return `<title>Zendiq Afdelingen</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600&family=IBM+Plex+Sans:ital,wght@0,400;0,500;0,600;1,400&family=IBM+Plex+Mono:wght@400;500&display=swap">
<style>
${CSS}
</style>

<div class="page">
  <header class="top">
    <div>
      <p class="eyebrow">Bedrijfsoverzicht · gegenereerd uit company/</p>
      <h1>Zendiq Afdelingen</h1>
      <p class="lede">Negen afdelingen, elk met een doel, een meetlat en een ritme. Product is de motor: elke week aantoonbaar makkelijker, betrouwbaarder of waardevoller voor chauffeurs. Onderaan het logboek in de vorm probleem, hypothese, wijziging, resultaat, regel.</p>
    </div>
    <div class="stamp">
      bijgewerkt <b>${st.bijgewerkt}</b><br>
      bron <b>agent-library/company/*.md</b><br>
      volgende triage <b>${st.triage}</b>
    </div>
  </header>

  <nav class="strip" aria-label="Afdelingen">
${renderStrip(afdelingen)}
  </nav>

${renderProduct(product)}

${renderNulmeting()}

${renderExperimenten()}

  <h2>Afdelingen <small>doel · meetlat · ritme · skills</small></h2>

${rest.map((a, i) => renderDept(a, i === rest.length - 1)).join("\n\n")}

${renderLogboek()}

${renderBesluiten()}
</div>
`;
}

if (require.main === module) {
  const html = build();
  if (process.argv.includes("--check")) {
    const huidig = fs.existsSync(OUT) ? fs.readFileSync(OUT, "utf8").replace(/\r\n/g, "\n") : "";
    const strip = (s) => s.replace(/bijgewerkt <b>[^<]*<\/b>/, "").replace(/volgende triage <b>[^<]*<\/b>/, "");
    if (strip(huidig) !== strip(html)) { console.error("zendiq-afdelingen.html loopt achter op de markdown: draai node company/build-page.js"); process.exit(1); }
    console.log("pagina in sync");
  } else {
    fs.writeFileSync(OUT, html);
    console.log(`geschreven: ${path.relative(process.cwd(), OUT)} (${html.length} tekens) · publiceer op ${URL}`);
  }
}

module.exports = { build };
