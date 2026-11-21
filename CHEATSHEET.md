# tico-os Cheatsheet

What to type in the Claude Code chat in VS Code, and where everything lives. Every command
below is a slash command, but you can also just describe what you want ("jot down an idea…",
"how's the portfolio looking?") and the right skill triggers. For the full explanation of
how and why it all works, read [GUIDE.md](GUIDE.md).

## The big picture

```
 Hub (#7): one card per app, its whole life
 Inbox ─► Idea Backlog ─► Scoped / Tech Spec ─► In Development ─► Beta ─► Live / Launched ─► Sunset ─► Archived
 --quick   new-idea        evaluate-idea         evaluate-idea →                      launch-retro
                                                 graduate-idea                         at 30 / 90 days
                                                 (or adopt-project)
 Kill at any gate ─► Archived

 Fordsoft Development (#5): every issue for every app, tagged App (or Shared)
```

| Where | Holds | Source of truth for |
|---|---|---|
| [`proj-incubator`](https://github.com/evensteven01/proj-incubator) | `[Idea]`/`[App]` issues (the Hub cards), `ideas/`, `playbooks/`, `processes/`, `architecture/` | Idea specs and decisions; the playbook; ticket conventions; shared patterns |
| [Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7) | One card per idea/app | What stage each app is at (the spec carries the reasoning) |
| [Fordsoft Development](https://github.com/users/evensteven01/projects/5) | Every issue, with App, Status, Priority, Size | The work: the only ticket list |
| [`project-docs`](https://github.com/evensteven01/project-docs) | `<app>/SPEC.md`, `TICKETS.md` (conventions), `go-to-market/` | Everything about an app once it graduates |
| Code repos | `<app>-mobile` (main: code + all issues), `-landing`, `-backend` when needed | Code, `PERSONA.md` (engineering decisions, risks) |
| `tico-os` (this repo) | Skills, agents, hook, scripts, templates | The automation; content stays in the repos above |

## Commands

| Command | Use when | What it does | Touches |
|---|---|---|---|
| `/tico-os:new-idea --quick "<idea>"` | An idea pops into your head | Duplicate check, then a one-line issue | `[Idea]` issue · Hub card → **Inbox** |
| `/tico-os:new-idea` | You want to pitch an idea (new or from the Inbox) | Phase 1 interview (pitch, audience, pain, evidence), 10-min competitor smoke test, Gate 1, spec | `ideas/<slug>.md` on a branch · Hub card → **Idea Backlog** |
| `/tico-os:evaluate-idea <slug>` | An idea is ready for its next phase | Phase 2: core loop, MVP ≤ 7 features, Non-Goals, stack, cost. Phase 3: competitor research, risks, monetization, revenue math, critic review, scorecard → Go/Park/Kill | Spec on a branch · Hub Status (+ Priority) |
| `/tico-os:graduate-idea <slug>` | An idea got a **Go** | Asks about each repo (suggests names), runs `new-project-setup` pre-filled from the spec, files launch issues, connects everything | New repos · `project-docs/<app>/` · both boards · README and spec links |
| `/tico-os:adopt-project` | An existing app should join the system | Works out its real stage, connects it like graduation, reports doc gaps | Hub card · Dev board · README and doc links |
| `/tico-os:portfolio` | "What's going on / what next?" | Read-only report: pipeline, launch progress, drift, Beta/retro/Park reminders, one suggested next step | Nothing (offers to fix drift) |
| `/tico-os:launch-retro` | ~30 and ~90 days after launch | Actual funnel and revenue vs. Phase 3 predictions; proposes playbook rate updates | `06-revenue-projections.md` · spec · maybe the playbook |
| `/tico-os:new-project-setup` | Just the project docs and starter files | Personas, SPEC, TICKETS conventions, go-to-market docs (mobile/web), CI, labels, milestone | Code repo + `project-docs` |
| `/tico-os:extract-pattern` | Something in a project is worth reusing | Writes `architecture/` or `processes/` docs from the real code | `proj-incubator` |
| `/tico-os:summarize-file <path>` | A file is too big to read whole | Compressed view: signatures, types, public API | Nothing |

Every command that changes files works on a branch, commits, pushes, and **asks before
opening the PR**. Board updates and new repos are shown to you before they happen.

## A typical app, end to end

1. **Capture**: `/tico-os:new-idea --quick "…"`. Seconds. It sits in the Inbox until you're ready.
2. **Pitch**: `/tico-os:new-idea` on the Inbox card. ~30 min. If Gate 1 fails, it records
   Park or Kill with the reason instead of forcing it through. Merge the spec PR.
3. **Scope**: `/tico-os:evaluate-idea <slug>` runs Phase 2. It proposes features and
   Non-Goals for you to cut, and holds the line on ≤ 7 features. Set Priority when asked.
4. **Research and decide**: run `/tico-os:evaluate-idea <slug>` again for Phase 3. The
   `market-researcher` agent researches competitors, the `idea-critic` agent argues against
   the idea, and you set the scores and make the call.
5. **Graduate**: on Go, `/tico-os:graduate-idea <slug>`. Repos and project docs are
   created and pre-filled, launch-checklist items become milestone issues, everything is
   linked, and the spec becomes history.
6. **Build**: work the app's view on Fordsoft Development (Ready → In progress → In review →
   Done). Each issue's milestone says which release it's for: `v1.0 Launch`, `v1.1`,
   `Later`, or none (not decided yet).
7. **Beta**: testers have it and the milestone is down to launch-day work → move the Hub card
   to Beta.
8. **Launch**: card → Live / Launched; put the launch date in the card's issue and close it.
9. **Retro**: `/tico-os:launch-retro` at ~30 and ~90 days.
10. **Retire, if it comes to that**: card → Sunset while winding down, then Archived.

## After graduation: what exists and how it's linked

```
 Hub card [App] <name>  ──►  project docs · code repos · board view · launch milestone
 (proj-incubator issue)

 project-docs/<app>/SPEC.md      "Origin: ideas/<slug>.md" · "Board: <view>"
 project-docs/<app>/TICKETS.md   conventions + board link (no ticket list)
 <app>-mobile/README.md          "Project docs · Board" line
 <app>-mobile/PERSONA.md         board view under "Where things live"
 ideas/<slug>.md                 "Graduated to" → project docs + main repo
 Fordsoft Development            App option <app> + a "<app>" view; every issue tagged
```

The shared steps behind this are in [procedures/connect-project.md](procedures/connect-project.md),
used by both `graduate-idea` and `adopt-project`.

## Happens automatically

- **Every session** (any folder) starts with the house rules from
  [`rules/house-rules.md`](rules/house-rules.md): branch + PR, ask before opening PRs,
  reviews on GitHub, the advisor lens, don't fabricate, the two boards and where issues go.
  Edit that file to change them.
- **Sessions in `proj-incubator`** also get a pipeline summary built from the spec headers,
  plus the Hub's Inbox (one quick network call, skipped if it fails). It doesn't check for
  drift; `/tico-os:portfolio` does.
- On Fordsoft Development, merging a PR and closing an issue move cards, and sub-issues of
  an epic on the board are added automatically. Other new issues are **not** added on their
  own (free-plan limit): the skills add theirs, and for hand-made ones use the issue's
  Projects sidebar or `board.sh --board dev add`.

## Agents (used by the skills; you can also ask for them directly)

| Agent | Model | Job |
|---|---|---|
| `market-researcher` | Sonnet | Live competitor research → sourced, dated table; never fills cells from memory |
| `idea-critic` | Sonnet | Strongest honest case against an idea, plus the cheapest test that would change its mind |
| `tico-cheap` | Haiku | Small structured chores (extracting spec headers, format conversions) |

## Board scripts

`scripts/board.sh` works with both boards by **name**, so it keeps working if columns are
renamed. The skills call it; you rarely need it directly.

```bash
board.sh options                                   # Hub fields and valid values
board.sh list                                      # Hub cards, grouped by status
board.sh add <issue-url> --status Inbox            # new Hub card
board.sh set <issue-url> Status "Scoped / Tech Spec"
board.sh set <issue-url> Priority P0
board.sh remove <issue-url>                        # take a card off (issue untouched)

board.sh --board dev list --app budget-app         # one app's work
board.sh --board dev add <issue-url> --app budget-app --status Ready
board.sh --board dev app-add <app>                 # new App option + its board view
```

`setup-github.sh <owner/repo> --app <app> [--skip <n,n>] [--dry-run]` (in
`skills/new-project-setup/templates/scaffolding/github/`) creates the main repo's labels and
launch milestone, links it to Fordsoft Development and puts all its issues on the board
(cards that already have an App, like `Shared`, keep it). For a `-landing` or `-backend`
repo, add `--secondary`: it only links the repo to the board.

Config: `TICO_BOARD_OWNER` (default `evensteven01`), `TICO_HUB_BOARD` (default `7`),
`TICO_DEV_BOARD` (default `5`). Needs a `gh` token with the `project` scope.

## Setup (once per machine)

From a terminal (the VS Code chat doesn't accept `/plugin` commands):

```bash
~/Development/tico-os/scripts/plugin.sh install
```

Then reload the window (Cmd+Shift+P → Developer: Reload Window) and open a new chat. Check
it worked: typing `/tico-os:` should list the commands. Full details are in
[INSTALL.md](INSTALL.md).

Optional: if `proj-incubator` isn't at `~/Development/proj-incubator`, set
`TICO_INCUBATOR_DIR` in your shell profile.

## Changing tico-os

1. Edit on a branch in `~/Development/tico-os`, **bump `version` in
   `.claude-plugin/plugin.json`**, then PR → merge. Without a bump, `update` sees nothing
   new.
2. Pull the new version into Claude Code: `scripts/plugin.sh update`, then type
   `/reload-plugins` in each open chat (no window reload or new chat needed).

What lives where, when you want to change something:

| To change… | Edit |
|---|---|
| The stages, gates, scorecard, stack defaults, retro, sunset | `proj-incubator/playbooks/app-evaluation-playbook.md` (skills read it live, no plugin update needed) |
| The idea spec layout | `proj-incubator/ideas/TEMPLATE-app-spec.md` (read live too) |
| How issues are filed and tracked | `proj-incubator/processes/ticket-conventions.md` |
| How a skill behaves | `tico-os/skills/<name>/SKILL.md` (needs plugin update) |
| How projects get connected to the boards | `tico-os/procedures/connect-project.md` (needs plugin update) |
| Standing rules for every session | `tico-os/rules/house-rules.md` (needs plugin update) |
| Project bootstrap templates | `tico-os/skills/new-project-setup/templates/` (needs plugin update) |

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/tico-os:` commands don't appear | `scripts/plugin.sh status` → check it's installed and enabled; reload the window; open a new chat |
| Changes merged to tico-os aren't showing up | Check the PR bumped the version; `scripts/plugin.sh update`; `/reload-plugins` in the chat |
| `board.sh` fails with a permissions error | `gh auth status` should list the `project` scope; `gh auth refresh -s project` |
| `board.sh: no option '…'` | The value was renamed or mistyped; `board.sh options` (or `--board dev options`) shows current names |
| `board.sh: the dev board needs --app` | Every work-board card needs an App; pass `--app <app>` (or `Shared`) |
| An issue isn't on Fordsoft Development | Expected for hand-made issues; add it from the issue's Projects sidebar or with `board.sh --board dev add` |
| Portfolio report shows drift | Expected after hand edits; let `/tico-os:portfolio` fix it, or update the spec and card together |
