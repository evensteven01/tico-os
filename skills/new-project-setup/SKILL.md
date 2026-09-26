---
name: new-project-setup
description: Use when starting a new personal side-project (a new app/repo, or a new project directory under project-docs) — bootstraps the three-persona system (Coder, Reviewer, GTM Advisor), the SPEC/TICKETS doc structure, and the go-to-market planning doc-set this user has used before (first built out for budget-app). Also use when asked to "set up personas," "bootstrap go-to-market planning," or "streamline launch planning" for an existing project that doesn't have this structure yet.
---

# New Project Setup

Bootstraps the reusable project system first built for `budget-app` (mobile app + docs
repo) onto a new project: three personas, a docs structure, a go-to-market planning
doc-set, and the associated GitHub ticket conventions. Ask enough questions to fill in real
content before creating files — a skeleton left full of `{{PLACEHOLDER}}` markers is worse
than a short pause to ask, because a future session will read it as already-decided.

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
recurring sub-structure — this is what kept the budget-app version useful across many
sessions instead of decaying into stale prose:

- **Role** — one paragraph: who this persona is acting as, and why that framing.
- **Operating principles** — a short bulleted list of non-negotiables, each with its *why*
  attached inline. A rule stated without its reason gets silently dropped the first time
  it's inconvenient; a rule with its reason lets a future session judge edge cases instead
  of blindly pattern-matching.
- **Locked decisions table** — decisions already made, one row each, linking to the doc
  with the full reasoning. Exists so settled questions don't get re-litigated from scratch
  every session (this actually happened once on budget-app — see
  `templates/go-to-market/08-mvp-definition.md`'s primary-income discussion — and checking
  the locked-decisions table first would have saved a design detour).
- **Open questions / open decisions** — explicitly unresolved items, so nothing gets
  silently assumed in either direction.
- **Where things live** — a repo/file map.
- **Doc map** — a table of every other relevant doc, one-line description each.
- **Status snapshot** — dated, with an explicit "reverify before relying on this" caveat.
  This is the one section guaranteed to go stale; the caveat is load-bearing, not boilerplate.

## Steps

1. **Gather context.** Ask, don't assume: project name/working name, a one-sentence
   description of what it does, the code repo(s) and their stack, whether a docs repo
   already exists for this user's projects (their convention: one shared `project-docs`
   repo, one directory per project — see that repo's own README for the exact pattern) or a
   new one is needed, and roughly what stage the project is at (pre-code, mid-build,
   pre-launch). The stage answer determines how much of the rest of this skill applies right
   now — see step 4's gate.

2. **Set up the docs-repo structure** for the project using `templates/SPEC.md` and
   `templates/TICKETS.md` as skeletons, written to `<project>/SPEC.md` and
   `<project>/TICKETS.md` in the docs repo. `TICKETS.md` only becomes meaningful once
   GitHub Issues exist on the code repo — it's fine to create it near-empty at first.

3. **Create the Coder/Reviewer persona** at the code repo's root, from
   `templates/PERSONA-code-repo.md`, filling in the project-specific placeholders (name,
   stack, architectural decisions pulled from the SPEC.md just written, git/test workflow
   specifics). Leave "known open risk items" and "open questions" genuinely empty for a
   fresh repo rather than inventing content to fill the section — see "What not to do" below.

4. **Set up go-to-market planning — gate this on having a real product concept.** Don't run
   this step for a repo that's still an empty scaffold with no positioning worth stating yet;
   wait until there's enough of a concept to reason about a market. When ready, copy the
   entire `templates/go-to-market/` directory into `<project>/go-to-market/` in the docs
   repo, and work through the docs with the user in this order — positioning depends on
   nothing else and everything else depends on it, so resolve it first even though a couple
   of docs are numbered ahead of where they're actually needed:
   1. `01-positioning-and-niche.md` — niche and one-sentence positioning first; every other
      doc reinforces or is constrained by this.
   2. `03-pricing-strategy.md` — pricing model, informed by the architecture (does this
      product have recurring costs yet, per its SPEC.md Build Phases?).
   3. `08-mvp-definition.md` — exact in/out scope and the SPEC.md cross-check, informed by
      both of the above.
   4. `09-readiness-testing-plan.md`, `05-launch-readiness-checklist.md` — verification plan
      and the operational checklist, informed by 08.
   5. `02-app-store-listing.md` — listing copy, needs the name/pricing/positioning settled
      first.
   6. `04-marketing-and-acquisition.md`, `06-revenue-projections.md`,
      `07-beta-testing-program.md` — can be drafted in parallel once positioning is locked.

   These are **reasoning templates** — each one carries the questions that doc needs to
   answer and the structural pattern for answering them (tables, "flagged gap" callouts,
   locked-vs-open framing), not a fill-in-the-blank form. Do the actual positioning/pricing/
   marketing thinking for *this* product; don't mechanically substitute placeholder text
   without reasoning through it the way the original budget-app docs did.

5. **Create the GTM Advisor persona** at `<project>/go-to-market/PERSONA.md`, from
   `templates/PERSONA-gtm-advisor.md`, once the docs above have real content to condense — a
   persona file summarizing still-empty docs is useless, so do this step last, not in
   parallel with step 4.

6. **Wire up GitHub conventions:**
   - Create a `go-to-market` label on the code repo; new GTM-scoped issues get a `[GTM]`
     title prefix and that label, kept separate from plain numbered dev issues — mirrors
     `TICKETS.md` vs. `GTM_TICKETS.md` (`templates/go-to-market/GTM_TICKETS.md`).
   - Set up a GitHub Project board mirroring both ticket streams, if the user wants one (not
     mandatory — TICKETS.md/GTM_TICKETS.md alone are sufficient).
   - Branch+PR discipline (never push straight to `main`) is a standing rule across this
     user's projects already — this skill doesn't need to re-establish it, just make sure
     the new repo's `PERSONA.md` states it under "shared context," since that's where a
     coding session actually looks for it.

7. **Cross-link everything** — each persona file's sibling-doc pointer, each doc's doc-map
   table, and (if the code repo uses `AGENTS.md`) a one-line pointer to `PERSONA.md` from
   wherever that repo's `CLAUDE.md`/`AGENTS.md` lives, the way budget-app-mobile's
   `AGENTS.md` gained a "start here" section pointing at its `PERSONA.md`.

## What not to do

- Don't copy a template's placeholder prose verbatim into a real project's docs — every
  `{{PLACEHOLDER}}` and bracketed instruction must be replaced with real, project-specific
  content, or the section explicitly removed if it doesn't apply.
- Don't run step 4 (go-to-market planning) before there's a real product concept to
  position — an empty scaffold repo doesn't need a niche defined yet, and forcing one
  produces fabricated-sounding positioning that has to be redone later anyway.
- Don't invent "locked decisions," "known risks," or "status snapshot" content to fill a
  table — leave those genuinely empty (or omit the section) until real decisions/risks
  exist. A template filled with plausible-sounding fabricated content is worse than an
  honest gap, because a future session will trust it as already-decided.
- Don't skip asking clarifying questions to save a turn. A wrong guess baked into a persona
  file is expensive to unwind later — every future session treats persona-file content as
  settled unless told otherwise.
