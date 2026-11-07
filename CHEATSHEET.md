# tico-os Cheatsheet

How the portfolio system fits together, and what to type in the Claude panel in VS Code.
Every command below is a slash command, but you can also just describe what you want
("I have an app idea…", "how's the portfolio looking?") and the right skill triggers.

## The big picture

```
                 proj-incubator                                    project-docs + code repos
   ┌─────────────────────────────────────────────┐            ┌──────────────────────────────┐
   │ ideas/<slug>.md                             │            │ project-docs/<project>/      │
   │   Phase 1 ──► Phase 2 ──► Phase 3 ──► Go ───┼──graduate─►│   SPEC, TICKETS, go-to-market│
   │   new-idea    evaluate-idea   (Park/Kill)   │            │ <project>-mobile/ PERSONA.md │
   └─────────────────────────────────────────────┘            └──────────────────────────────┘
        Board (Fordsoft Project Hub, #7):
        Idea Backlog ──► Scoped / Tech Spec ──► In Development ──► Live / Launched
                    └───────────────── Kill ──► Archived
```

| Where | Holds | Source of truth for |
|---|---|---|
| [`proj-incubator`](https://github.com/evensteven01/proj-incubator) | `ideas/`, `playbooks/`, `processes/`, `architecture/` | Idea specs and decisions; the evaluation playbook; shared patterns |
| [Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7) | One card per idea/project | Status at a glance (the spec carries the reasoning) |
| [`project-docs`](https://github.com/evensteven01/project-docs) | `<project>/SPEC.md`, `TICKETS.md`, `go-to-market/` | Everything about a project once it graduates |
| Code repos | `PERSONA.md`, `AGENTS.md`, code | Engineering decisions, risks, workflow |
| `tico-os` (this repo) | Skills, agents, hook, scripts, templates | The automation; edited content stays in the repos above |

## Commands

| Command | Use when | What it does | Touches |
|---|---|---|---|
| `/tico-os:new-idea` | You have a new app idea | Interviews you through Phase 1 (pitch, audience, pain, evidence), runs a 10-min competitor smoke test, scores Gate 1, writes the spec | New `ideas/<slug>.md` on a branch · `[Idea]` issue · board card → Idea Backlog |
| `/tico-os:evaluate-idea <slug>` | An idea is ready for its next phase | Phase 2: core loop, MVP ≤ 7 features, Non-Goals, stack, cost. Phase 3: competitor research, risks, monetization, revenue math, critic review, scorecard → Go/Park/Kill | Spec on a branch · board Status (+ Priority) |
| `/tico-os:graduate-idea <slug>` | An idea got a **Go** | Creates the code repo(s), runs `new-project-setup` pre-filled from the spec, cross-links everything | New repos · `project-docs/<project>/` · spec "Graduated to" link |
| `/tico-os:portfolio` | "What's going on / what next?" | Read-only report: pipeline, launch-milestone progress, drift between specs and board, due Park triggers, one suggested next step | Nothing (offers to fix drift) |
| `/tico-os:new-project-setup` | Starting a project that didn't come through the incubator | Personas, SPEC/TICKETS, go-to-market docs (mobile/web), CI, labels, milestone | Code repo + `project-docs` |
| `/tico-os:extract-pattern` | Something in a project is worth reusing | Writes `architecture/` or `processes/` docs from the real code | `proj-incubator` |
| `/tico-os:summarize-file <path>` | A file is too big to read whole | Compressed view: signatures, types, public API | Nothing |

Every command that changes files works on a branch, commits, pushes, and **asks before
opening the PR**.

## A typical idea, end to end

1. **Capture** — `/tico-os:new-idea`. Answer its questions; don't polish. ~30 min. If Gate 1
   fails, it records Park or Kill with the reason instead of forcing it through.
2. **Merge the spec PR.**
3. **Scope** — `/tico-os:evaluate-idea <slug>` runs Phase 2. It proposes features and
   Non-Goals for you to cut; it holds the line on ≤ 7 features. Board → Scoped / Tech Spec;
   set Priority when asked.
4. **Research & decide** — run `/tico-os:evaluate-idea <slug>` again for Phase 3. The
   `market-researcher` agent does competitor research in the background; the
   `idea-critic` agent argues against the idea; you set the scores and make the call.
5. **Graduate** — on Go, `/tico-os:graduate-idea <slug>`. Code repo + project docs
   created and pre-filled; the spec becomes history.
6. **Build & launch** — normal project work, guided by the project's `PERSONA.md` and
   `go-to-market/` docs. When it ships, move the card to Live / Launched.

## Happens automatically

- **Every session** (any repo) starts with the house rules loaded from
  [`rules/house-rules.md`](rules/house-rules.md): branch + PR, ask before opening PRs,
  reviews on GitHub, the advisor lens, don't fabricate. Edit that file to change them.
- **Sessions in `proj-incubator`** also get a pipeline summary built from the spec headers
  (local, no network). It doesn't check the board; `/tico-os:portfolio` does.

## Agents (used by the skills; you can also ask for them directly)

| Agent | Model | Job |
|---|---|---|
| `market-researcher` | Sonnet | Live competitor research → sourced, dated table; never fills cells from memory |
| `idea-critic` | Sonnet | Strongest honest case against an idea, plus the cheapest test that would change its mind |
| `tico-cheap` | Haiku | Small structured chores (extracting spec headers, format conversions) |

## Board script

`scripts/board.sh` updates the board by **name**, so it keeps working if columns are
renamed. The skills call it; you rarely need it directly.

```bash
board.sh options                                  # valid Status / Category / Priority values
board.sh list                                     # all cards, grouped by status
board.sh get <issue-url>                          # one card's fields
board.sh add <issue-url> --status "Idea Backlog" --category "App Concept"
board.sh set <issue-url> Status "Scoped / Tech Spec"
board.sh set <issue-url> Priority "P0 - High"
```

Config: `TICO_BOARD_OWNER` (default `evensteven01`), `TICO_BOARD_NUMBER` (default `7`).
Needs a `gh` token with the `project` scope.

## Setup (once per machine)

In the Claude panel in VS Code:

```
/plugin install tico-os --marketplace evensteven01/tico-os
```

Then reload the window. Check it worked: typing `/tico-os:` should list the commands.

Optional: if `proj-incubator` isn't at `~/Development/proj-incubator`, set
`TICO_INCUBATOR_DIR` in your shell profile.

## Changing tico-os

1. Edit on a branch in `~/Development/tico-os` → PR → merge.
2. Pull the new version into Claude Code: `/plugin marketplace update tico-os`, then reload
   the window.

What lives where, when you want to change something:

| To change… | Edit |
|---|---|
| The evaluation steps, gates, scorecard, stack defaults | `proj-incubator/playbooks/app-evaluation-playbook.md` (skills read it live, no plugin update needed) |
| The idea spec layout | `proj-incubator/ideas/TEMPLATE-app-spec.md` (read live too) |
| How a skill behaves | `tico-os/skills/<name>/SKILL.md` (needs plugin update) |
| Standing rules for every session | `tico-os/rules/house-rules.md` (needs plugin update) |
| Project bootstrap templates | `tico-os/skills/new-project-setup/templates/` (needs plugin update) |

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/tico-os:` commands don't appear | `/plugin` → check tico-os is installed and enabled; reload the window |
| Changes merged to tico-os aren't showing up | `/plugin marketplace update tico-os`, reload |
| `board.sh` fails with a permissions error | `gh auth status` should list the `project` scope; `gh auth refresh -s project` |
| `board.sh: no option '…'` | The column was renamed or mistyped; `board.sh options` shows current names |
| Portfolio report shows drift | Expected after hand edits; let `/tico-os:portfolio` fix it, or update the spec and card together |
