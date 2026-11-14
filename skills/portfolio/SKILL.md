---
name: portfolio
description: Use when the user asks about the state of their app portfolio or idea pipeline ("portfolio status", "what's in the pipeline", "what ideas do I have", "what should I work on next", "is the board up to date") — summarizes the Fordsoft Project Hub (one card per app), the Fordsoft Development work board, and the proj-incubator idea specs, and flags drift between them.
---

# Portfolio

A read-only status report across both boards and the idea specs. Change nothing unless the
user asks you to fix something it finds.

## Gather

1. **Hub** (one card per app): `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh list --json`.
2. **Work board**: `board.sh --board dev list --json` (every issue, with App).
3. **Specs**: pull latest `main` in the incubator (`$TICO_INCUBATOR_DIR`, default
   `~/Development/proj-incubator`), read the header table, Decision section and gate
   checklists of every `ideas/*.md` except the template. This is cheap structured
   extraction; delegate it to `tico-cheap` if there are more than a few specs.
4. For apps in **In Development** or **Beta**: the main repo's `v1.0 Launch` milestone
   (`gh api repos/<owner>/<repo>/milestones`), found from the Hub card's issue body.
5. For **Live** apps: the **Launched** date in the Hub card's issue body.

## Report

Keep it short and scannable, in this order:

1. **Pipeline**: counts per Hub Status (Inbox → Archived), then one line per card: name,
   status, priority, and the next action:
   - Inbox → `new-idea` (full interview)
   - Idea Backlog → `evaluate-idea` (Phase 2), or "parked until <trigger>"
   - Scoped / Tech Spec → `evaluate-idea` (Phase 3)
   - In Development → `graduate-idea` if it hasn't graduated yet, else the launch milestone
   - Beta / Live → the launch milestone, or the next retro
2. **Apps in flight**: for each In Development / Beta / Live app: launch-milestone progress
   (`n/m closed`), the work board's In progress and Ready cards for that App, and anything
   P0 still open.
3. **Needs attention**: only what's actually wrong:
   - **Drift**: spec Status ≠ Hub Status; spec with no Hub card; Hub card in Idea Backlog
     or later with no spec (adopted apps are exempt: their Origin row says "Adopted"); Go
     decision with no "Graduated to" link.
   - **Hub hygiene**: Hub cards that aren't `[Idea]` or `[App]` issues (the Hub is app
     cards only; other work belongs on the work board under App = `Shared`); `[App]` cards
     whose body still has placeholders.
   - **Work board hygiene**: cards with no App; an app at In Development or later with no
     App option or no board view.
   - **Stage suggestions**: an In Development app whose launch milestone has nothing left
     but launch-day work → suggest **Beta**; a Live app with no Launched date.
   - **Retros due**: Live apps at 30+ or 90+ days since launch with no matching retro row
     (see `launch-retro`).
   - **Park triggers due**: date-based triggers that have passed, or condition-based ones
     to re-check (say which).
   - **Stalled**: ideas in Scoped / Tech Spec untouched for 30+ days (spec last-updated);
     Inbox ideas older than 60 days (evaluate, or close as not worth it).
4. **Suggested next step**: one recommendation, e.g. the highest-priority scoped idea to
   run Phase 3 on, or the P0 blocking an app's launch.

Offer to fix any drift found (spec edits on a branch; board updates via `board.sh set`).
