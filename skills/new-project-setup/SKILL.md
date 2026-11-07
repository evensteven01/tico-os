---
name: new-project-setup
description: Use when starting a new personal side-project (a new app/repo, or a new project directory under project-docs) — bootstraps the three-persona system (Coder, Reviewer, GTM Advisor), the SPEC/TICKETS doc structure, the go-to-market planning doc-set (with mobile or web platform variants), and starter files (CI, GitHub labels/milestone, beta landing page). Also use when asked to "set up personas," "bootstrap go-to-market planning," or "streamline launch planning" for an existing project that doesn't have this structure yet.
---

# New Project Setup

Bootstraps this user's reusable project system onto a new project: three personas, a docs
structure, a go-to-market planning doc-set, GitHub ticket conventions, and a few starter
files. Ask enough questions to fill in real content before creating files — a skeleton
left full of `{{PLACEHOLDER}}` markers is worse than a short pause to ask, because a future
session will read it as already-decided.

## The pattern being replicated

Three personas, each a persistent, condensed context file so future sessions don't
re-derive decisions already made:

1. **Coder** — implements features in the code repo(s).
2. **Reviewer** — reviews PRs/designs in the same code repo(s).
3. **GTM Advisor** — owns go-to-market planning (positioning, pricing, marketing, launch
   readiness, MVP scope) in the docs repo.

Coder and Reviewer live together in one `PERSONA.md` at the code repo's root — two sections
in one file, defaulting to Coder when unspecified, because they share almost all their
context (repo layout, locked architectural decisions, open risks) and only differ in stance.
GTM Advisor lives in its own `PERSONA.md` inside the docs repo's `<project>/go-to-market/`
folder, since it's a genuinely separate scope (business/marketing, not engineering) with a
different audience for its decisions. Each persona file cross-references the other as a
"sibling doc" so a session working in either repo knows the other role and its file exist.

Every persona file, and every planning doc built with this skill, follows the same
recurring sub-structure — this is what keeps the files useful across many sessions instead
of decaying into stale prose:

- **Role** — one paragraph: who this persona is acting as, and why that framing.
- **Operating principles** — a short bulleted list of non-negotiables, each with its *why*
  attached inline. A rule stated without its reason gets silently dropped the first time
  it's inconvenient; a rule with its reason lets a future session judge edge cases instead
  of blindly pattern-matching.
- **Locked decisions table** — decisions already made, one row each, linking to the doc
  with the full reasoning. Exists so settled questions don't get re-litigated from scratch
  every session — checking this table first is what prevents a design detour on a question
  that was already answered.
- **Open questions / open decisions** — explicitly unresolved items, so nothing gets
  silently assumed in either direction.
- **Where things live** — a repo/file map.
- **Doc map** — a table of every other relevant doc, one-line description each.
- **Status snapshot** — dated, with an explicit "reverify before relying on this" caveat.
  This is the one section guaranteed to go stale; the caveat is load-bearing, not boilerplate.

## Template layout

```
templates/
├── PERSONA-code-repo.md, PERSONA-gtm-advisor.md, SPEC.md, TICKETS.md
├── go-to-market/          # shared, platform-neutral GTM docs (no 02 — see platforms/)
├── platforms/
│   ├── mobile/            # PLATFORM.md inserts + go-to-market/02-listing.md (store/ASO)
│   └── web/               # PLATFORM.md inserts + go-to-market/02-listing.md (landing/SEO)
└── scaffolding/
    ├── code-repo/         # AGENTS.md "start here" section + CLAUDE.md (@AGENTS.md)
    ├── ci/node-ci.yml     # GitHub Actions: npm ci, test, typecheck
    ├── github/setup-github.sh   # go-to-market label, tier labels, v1.0 Launch milestone
    ├── mobile/eas.json    # development / preview (APK) / production build profiles
    ├── landing/           # static beta-recruitment page for GitHub Pages
    └── backend-placeholder/README.md   # reserve a deferred-phase repo name
```

`PLATFORM.md` is never copied into a project. It holds platform-specific content that gets
merged into the shared docs at setup time: early decisions, the payment mechanism (03),
operational checklist items (05), beta distribution (07), the manual QA matrix (09), persona
hints, and which scaffolding applies.

## Steps

1. **Gather context.** Ask, don't assume: project name/working name, a one-sentence
   description of what it does, the code repo(s) and their stack, **the platform (mobile,
   web, or both)**, whether the docs go in the existing `project-docs` repo (one directory
   per project — see that repo's README for the convention) or somewhere new, and roughly
   what stage the project is at (pre-code, mid-build, pre-launch). The stage answer
   determines how much of the rest of this skill applies right now — see step 5's gate.
   If the product name isn't settled, pick an internal codename now and use it in package/
   app config instead of the repo placeholder.

2. **Set up the docs-repo structure** for the project using `templates/SPEC.md` and
   `templates/TICKETS.md` as skeletons, written to `<project>/SPEC.md` and
   `<project>/TICKETS.md` in the docs repo. `TICKETS.md` only becomes meaningful once
   GitHub Issues exist on the code repo — it's fine to create it near-empty at first, and to
   leave out the Tier column until a pricing model exists.

3. **Create the Coder/Reviewer persona** at the code repo's root, from
   `templates/PERSONA-code-repo.md`, filling in the project-specific placeholders (name,
   stack, architectural decisions pulled from the SPEC.md just written, typecheck/test/UI
   verification commands, environment quirks from the platform's `PLATFORM.md` hints). Add
   `scaffolding/code-repo/AGENTS.md` and `CLAUDE.md` so a session in the repo lands on
   `PERSONA.md` first. Leave "known open risk items" and "open questions" genuinely empty
   for a fresh repo rather than inventing content — see "What not to do" below.

4. **Add starter files that apply:**
   - `scaffolding/ci/node-ci.yml` → `.github/workflows/ci.yml` for a Node project, with the
     Node version matching `package.json`'s `engines.node` (pin one if missing). Adapt the
     steps for a non-Node stack rather than skipping CI — it's a 15-minute add that every
     later review otherwise flags.
   - `scaffolding/github/setup-github.sh <owner/repo>` — creates the `go-to-market` label
     and `v1.0 Launch` milestone. Re-run with `--with-tiers` once 03 defines a paid tier.
   - `scaffolding/backend-placeholder/README.md` — only if SPEC.md §5 names a deferred phase
     that will live in its own repo, and the user wants the name reserved now.
   - Platform-specific ones (e.g. `eas.json`) per the platform's `PLATFORM.md`, when that
     step is actually reached — not preemptively.

5. **Set up go-to-market planning — gate this on having a real product concept.** Don't run
   this step for a repo that's still an empty scaffold with no positioning worth stating yet;
   wait until there's enough of a concept to reason about a market. When ready:
   - Copy `templates/go-to-market/` into `<project>/go-to-market/` in the docs repo, **except
     `GTM_WORKPLAN.md`** (that's created later — see step 8).
   - Copy `templates/platforms/<platform>/go-to-market/02-listing.md` in alongside it. For a
     product shipping on both mobile and web, make two: `02-listing.md` from mobile and
     `02b-landing-page.md` from web, and add both to MASTER_PLAN's companion-docs table.
   - Merge `templates/platforms/<platform>/PLATFORM.md` into the copied docs: §05 items
     into 05's `<!-- PLATFORM ITEMS -->` marker, and the §03/§07/§09 content into those docs'
     sections as starting material. Its "Early decisions" become MASTER_PLAN open decisions.

   Then work through the docs with the user in this order — positioning depends on nothing
   else and everything else depends on it, so resolve it first even though a couple of docs
   are numbered ahead of where they're actually needed:
   1. `01-positioning-and-niche.md` — niche and one-sentence positioning first; every other
      doc reinforces or is constrained by this. Naming runs in parallel using its
      shortlist/collision process, but doesn't lock until beta testers have used the product.
   2. `03-pricing-strategy.md` — pricing model, informed by the architecture (does this
      product have recurring costs yet, per its SPEC.md Build Phases?), then the free/paid
      tier split and exact price point.
   3. `08-mvp-definition.md` — exact in/out scope and the SPEC.md cross-check, informed by
      both of the above.
   4. `09-readiness-testing-plan.md`, `05-launch-readiness-checklist.md` — verification plan
      and the operational checklist, informed by 08.
   5. `02-listing.md` — listing/landing copy, needs the name/pricing/positioning settled
      first.
   6. `04-marketing-and-acquisition.md`, `06-revenue-projections.md`,
      `07-beta-testing-program.md` — can be drafted in parallel once positioning is locked.

   These are **reasoning templates** — each one carries the questions that doc needs to
   answer and the structural pattern for answering them (tables, "flagged gap" callouts,
   locked-vs-open framing), not a fill-in-the-blank form. Do the actual positioning/pricing/
   marketing thinking for *this* product; don't mechanically substitute placeholder text
   without reasoning through it.

6. **Create the GTM Advisor persona** at `<project>/go-to-market/PERSONA.md`, from
   `templates/PERSONA-gtm-advisor.md`, once the docs above have real content to condense — a
   persona file summarizing still-empty docs is useless, so do this step last, not in
   parallel with step 5.

7. **Wire up GitHub conventions:**
   - GTM-scoped issues get a `[GTM]` title prefix and the `go-to-market` label, kept
     separate from plain numbered dev issues — mirrors `TICKETS.md` vs. `GTM_TICKETS.md`.
   - Every P0 dev ticket and every Phase B/C `[GTM]` ticket goes on the `v1.0 Launch`
     milestone; feature tickets gated behind a paid tier get `paid-tier`.
   - Set up a GitHub Project board mirroring both ticket streams, if the user wants one (not
     mandatory — TICKETS.md/GTM_TICKETS.md alone are sufficient).
   - Branch+PR discipline (never push straight to `main`) is a standing rule across this
     user's projects already — this skill doesn't need to re-establish it, just make sure
     the new repo's `PERSONA.md` states it under "shared context," since that's where a
     coding session actually looks for it.

8. **When launch work actually starts** (Phase B/C, not at setup): audit the open `[GTM]`
   tickets against reality and create `GTM_WORKPLAN.md` from the template to sequence them.
   It's a temporary execution checklist — delete it when its last step is done. If the beta
   needs recruits beyond the personal network, offer `scaffolding/landing/` as a separate
   `<project>-landing` repo on GitHub Pages; ask whether the network is enough first.

9. **Cross-link everything** — each persona file's sibling-doc pointer, each doc's doc-map
   table, the code repo's `AGENTS.md` "start here" pointer to `PERSONA.md`, and the docs
   repo README's project list.

## Keeping the templates current

These templates are distilled from a live project and will drift behind it. When a
project's docs gain a genuinely reusable pattern (a new doc, a new table, a new process
that prevented a real mistake), port the *pattern* back here with the project-specific
content stripped out, on a branch + PR in this repo. Don't port project content.

## What not to do

- Don't copy a template's placeholder prose verbatim into a real project's docs — every
  `{{PLACEHOLDER}}` and bracketed instruction must be replaced with real, project-specific
  content, or the section explicitly removed if it doesn't apply.
- Don't run step 5 (go-to-market planning) before there's a real product concept to
  position — an empty scaffold repo doesn't need a niche defined yet, and forcing one
  produces fabricated-sounding positioning that has to be redone later anyway.
- Don't invent "locked decisions," "known risks," or "status snapshot" content to fill a
  table — leave those genuinely empty (or omit the section) until real decisions/risks
  exist. A template filled with plausible-sounding fabricated content is worse than an
  honest gap, because a future session will trust it as already-decided.
- Don't copy `PLATFORM.md` into a project, or leave the other platform's content in — merge
  what applies and drop the rest.
- Don't skip asking clarifying questions to save a turn. A wrong guess baked into a persona
  file is expensive to unwind later — every future session treats persona-file content as
  settled unless told otherwise.
