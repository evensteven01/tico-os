---
name: evaluate-idea
description: Use when the user wants to scope, research, score, or decide on an existing app idea in proj-incubator ("evaluate <idea>", "scope this idea", "is <idea> worth building", "run phase 2/3") — runs the next unfinished phase of the evaluation playbook (Product & Technical Scoping, then Market Analysis & Feasibility), ending in a Go/Park/Kill recommendation and board update.
---

# Evaluate Idea

Advances one idea spec in `proj-incubator` by **one phase**: Phase 2 if Gate 1 has passed
but Phase 2 hasn't, otherwise Phase 3. Running both phases in one sitting is fine if the
user asks, but finish and gate Phase 2 first — scoping changes what the market analysis
should look at.

## Locations

Same as `new-idea`: incubator at `$TICO_INCUBATOR_DIR` (default
`~/Development/proj-incubator`); read `playbooks/app-evaluation-playbook.md` from the repo
for the phase steps, gates, stack table and scorecard — never from memory. Board via
`${CLAUDE_PLUGIN_ROOT}/scripts/board.sh`.

## Steps

1. **Pull latest** `main`, read the spec `ideas/<slug>.md` (ask which one if not given —
   list the specs with their Status) and the playbook. Work on branch `idea/<slug>-phase-N`.
2. **Determine the phase** from the spec's gate checklists. If the previous gate isn't
   checked, stop and say so — don't skip a gate.

### Phase 2 — Product & Technical Scoping

3. Interview the user for the core loop, then propose the MVP feature table and Non-Goals
   for them to cut or add to — propose, don't decide. Hold the line on ≤ 7 features and ≥ 3
   Non-Goals with reasons.
4. Recommend a stack from the playbook's defaults table and `architecture/` docs. Any
   departure needs a written reason. Fill the cost row with real current prices (search if
   unsure).
5. Fill build phases and the effort estimate, check Gate 2, and on pass:
   `board.sh set <issue-url> Status "Scoped / Tech Spec"`, and ask the user to set Priority
   (`board.sh set <issue-url> Priority "P0 - High"` or `"P1 - Medium"`).

### Phase 3 — Market Analysis & Feasibility

6. **Delegate competitor research** to the `market-researcher` agent with the spec's value
   prop, segment, pain point and smoke-test results. It returns the competitor table with
   sources and dates; paste it into the spec and write the gap / why-now / trade-off prose
   with the user.
7. Fill the technical risk table, walking the playbook's risk prompts against *this*
   idea's stack. Flag any High/High risk as needing a spike before Go.
8. Work through monetization using the playbook's cost-structure table, then the revenue
   math: compute the three scenarios (show the arithmetic), fixed costs and break-even.
   Mark assumed rates as assumptions.
9. Fill the distribution sanity check — push for concrete channels.
10. **Get a counter-case** from the `idea-critic` agent with the filled spec. Show its
    strongest objections to the user before scoring.
11. **Score with the user**, not for them: propose a score and one-line note per criterion,
    let them adjust, compute the total, and apply the playbook's thresholds and the
    High/High-risk block. The user makes the call.
12. **Record the decision** in the spec (Decision section + a Decision log row) and update
    the board:
    - Go → `Status "In Development"`; tell the user next step is `/tico-os:graduate-idea`.
    - Park → Status stays `Idea Backlog`; a revisit trigger is required.
    - Kill → `Status "Archived"`; reasoning paragraph required.

13. Update the spec's Status / last-updated fields, commit, push, and ask before opening the
    PR.
