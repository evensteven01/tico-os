# tico-os

Personal Claude Code plugin for running an app portfolio from idea to live and beyond: an
idea pipeline wired to [`proj-incubator`](https://github.com/evensteven01/proj-incubator),
the [Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7) (one card per
app) and [Fordsoft Development](https://github.com/users/evensteven01/projects/5) (the
work), plus project bootstrap and adoption, launch retros, standing house rules, and
research subagents. Installed from GitHub, so it works the same in VS Code and the
terminal.

**→ [GUIDE.md](GUIDE.md)** explains how the whole system works, from idea to launched app,
in plain language for engineers and non-engineers alike. Start there.

**→ [CHEATSHEET.md](CHEATSHEET.md)** is the one-page reference: commands, setup,
troubleshooting.

**→ [INSTALL.md](INSTALL.md)** covers installing, updating and troubleshooting the plugin.

## Install

```bash
scripts/plugin.sh install   # once per machine
scripts/plugin.sh update    # after merging changes here (bump the version in plugin.json)
```

Then reload VS Code and open a new chat. The VS Code chat doesn't accept `/plugin`
commands, which is why this goes through a script; [INSTALL.md](INSTALL.md) explains the
details.

## What's in here

```
tico-os/
├── .claude-plugin/
│   ├── plugin.json            # Plugin manifest
│   └── marketplace.json       # Lets GitHub serve this repo as a one-plugin marketplace
├── skills/
│   ├── new-idea/              # Inbox quick capture; Phase 1 pitch → spec, Hub card
│   ├── evaluate-idea/         # Phases 2–3: scoping, market analysis, Go/Park/Kill
│   ├── graduate-idea/         # Go idea → repos + project docs, connected to both boards
│   ├── adopt-project/         # Existing app → onto both boards, linked, doc-gap report
│   ├── launch-retro/          # 30/90 days after launch: actuals vs. predictions
│   ├── portfolio/             # Read-only report across both boards + specs, drift checks
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
├── procedures/
│   └── connect-project.md     # Shared by graduate-idea + adopt-project: wire an app up
├── rules/
│   └── house-rules.md         # Standing rules injected into every session
├── scripts/
│   ├── board.sh               # Read/update both boards by field/option name
│   └── plugin.sh              # Install / update / status for this plugin
├── AGENTS.md.template         # House-rules template for Cursor/other tools, per repo
├── GUIDE.md                   # How the whole system works, in plain language
├── CHEATSHEET.md              # One-page command reference
├── INSTALL.md                 # Install, update, troubleshooting
└── docs/
    └── architecture.md
```

## Design rule: content in the repos, automation here

The evaluation playbook and idea template live in `proj-incubator` and the skills read them
live, so editing a playbook never needs a plugin update. This repo holds only behavior
(skills, procedures, agents, hook, scripts) and the bootstrap templates. Don't copy content in either
direction; link it.

## Using the house rules outside Claude Code

`rules/house-rules.md` reaches every Claude Code session through the SessionStart hook. For
Cursor or other tools, `AGENTS.md.template` is the per-project opt-in equivalent: copy it
into a repo as `AGENTS.md` (Cursor reads it natively; for Claude Code, add `@AGENTS.md` to
that repo's `CLAUDE.md`).
