# tico-os

Personal Claude Code plugin for running an app portfolio: an idea pipeline wired to
[`proj-incubator`](https://github.com/evensteven01/proj-incubator) and the
[Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7) board, a project
bootstrap skill, standing house rules, and research subagents. Installed from GitHub, so it
works the same in VS Code and the terminal.

**→ [CHEATSHEET.md](CHEATSHEET.md)** for how everything fits together and what to type.

## Install

In the Claude panel (VS Code) or the CLI:

```
/plugin install tico-os --marketplace evensteven01/tico-os
```

After merging changes here: `/plugin marketplace update tico-os`, then reload.

## What's in here

```
tico-os/
├── .claude-plugin/
│   ├── plugin.json            # Plugin manifest
│   └── marketplace.json       # Lets GitHub serve this repo as a one-plugin marketplace
├── skills/
│   ├── new-idea/              # Phase 1: capture + pitch an idea → spec, issue, board card
│   ├── evaluate-idea/         # Phases 2–3: scoping, market analysis, Go/Park/Kill
│   ├── graduate-idea/         # Go idea → code repo + project docs via new-project-setup
│   ├── portfolio/             # Read-only pipeline report + drift check (board vs. specs)
│   ├── extract-pattern/       # Project pattern → proj-incubator architecture/ or processes/
│   ├── new-project-setup/     # Personas, SPEC/TICKETS, go-to-market docs, starter files
│   │   └── templates/         #   shared docs, platforms/{mobile,web}, scaffolding/
│   ├── summarize-file/        # Compress a large file, preserving signatures
│   └── task-routing/          # When to delegate to tico-cheap
├── agents/
│   ├── market-researcher.md   # Sonnet: live, sourced competitor research
│   ├── idea-critic.md         # Sonnet: devil's advocate before scoring
│   └── tico-cheap.md          # Haiku: cheap structured sub-tasks
├── hooks/
│   ├── hooks.json             # SessionStart → session-start.sh
│   └── session-start.sh       # Loads house rules; pipeline summary in proj-incubator
├── rules/
│   └── house-rules.md         # Standing rules injected into every session
├── scripts/
│   └── board.sh               # Read/update the Project board by field/option name
├── AGENTS.md.template         # House-rules template for Cursor/other tools, per repo
├── CHEATSHEET.md
└── docs/
    └── architecture.md
```

## Design rule: content in the repos, automation here

The evaluation playbook and idea template live in `proj-incubator` and the skills read them
live, so editing a playbook never needs a plugin update. This repo holds only behavior
(skills, agents, hook, scripts) and the bootstrap templates. Don't copy content in either
direction; link it.

## Using the house rules outside Claude Code

`rules/house-rules.md` reaches every Claude Code session through the SessionStart hook. For
Cursor or other tools, `AGENTS.md.template` is the per-project opt-in equivalent: copy it
into a repo as `AGENTS.md` (Cursor reads it natively; for Claude Code, add `@AGENTS.md` to
that repo's `CLAUDE.md`).
