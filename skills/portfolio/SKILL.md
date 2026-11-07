---
name: portfolio
description: Use when the user asks about the state of their app portfolio or idea pipeline ("portfolio status", "what's in the pipeline", "what ideas do I have", "what should I work on next", "is the board up to date") — summarizes the Fordsoft Project Hub board and proj-incubator idea specs, and flags drift between them.
---

# Portfolio

A read-only status report across the board and the idea specs. Change nothing unless the
user asks you to fix something it finds.

## Gather

1. Board: `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh list --json` (all items, all
   categories).
2. Specs: pull latest `main` in the incubator (`$TICO_INCUBATOR_DIR`, default
   `~/Development/proj-incubator`), read the header table, Decision section and gate
   checklists of every `ideas/*.md` except the template. This is cheap structured
   extraction — delegate it to `tico-cheap` if there are more than a few specs.
3. For `In Development` items: the graduated project's open `v1.0 Launch` milestone
   progress, if one exists (`gh api repos/<owner>/<repo>/milestones`).

## Report

Keep it short and scannable, in this order:

1. **Pipeline** — counts per Status, then one line per idea: name, status, priority,
   decision, and the next action (`evaluate-idea` for Phase N / `graduate-idea` / waiting
   on revisit trigger).
2. **In development** — each project with launch-milestone progress (`n/m closed`).
3. **Needs attention** — only what's actually wrong:
   - **Drift**: spec Status ≠ board Status; spec with no board item; `App Concept` board
     item with no spec; Go decision without a "Graduated to" link.
   - **Park triggers due**: date-based triggers that have passed, or condition-based ones
     to re-check (say which).
   - **Stalled**: ideas in `Scoped / Tech Spec` untouched for 30+ days (spec last-updated).
4. **Suggested next step** — one recommendation, e.g. the highest-priority scoped idea
   to run Phase 3 on.

Offer to fix any drift found (spec edits on a branch; board updates via `board.sh set`).
