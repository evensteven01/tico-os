# tico-os

A local agentic workflow system for Claude Code. tico-os enforces model-tier routing, token efficiency guardrails, and a Think-Step-Check discipline on every task in a session.

## What it does

- Routes tasks to the right model tier (High-Reasoning vs Low-Cost) based on complexity, determinism, and expected turns
- Enforces token budgets: summarizes large files, chunks oversized inputs, caps Low-Cost output
- Escalates failed Low-Cost tasks to High-Reasoning automatically, with context preserved
- Installs itself into `~/.claude/` via symlinks so it loads on every Claude Code session

## Project Structure

```
tico-os/
├── CLAUDE.md               # Session init — loaded automatically by Claude Code
├── tico-sync.sh            # Symlink installer for ~/.claude/ integration
├── docs/
│   └── architecture.md     # Task flow diagram and token budget table
└── .tico/
    ├── skills/
    │   └── router.md       # Routing matrix, guardrails, escalation protocol
    └── prompts/
        └── summarize.md    # File compression prompt (≤15% of original lines)
```

## tico Commands

| Command | Description |
|---|---|
| `tico scan` | Re-scan `.tico/skills/` and `.tico/prompts/` and print loaded assets |
| `tico route <task>` | Print which model tier the router selects for a given task |
| `tico summarize <file>` | Compress a file to ≤15% of its original line count |
| `tico status` | Show current session state: tier, context size, escalation count |
| `tico sync` | Run `tico-sync.sh` to symlink tico assets into `~/.claude/` |
| `tico check` | Validate that all required tico assets are present and well-formed |

## Setup

```bash
# Symlink tico assets into ~/.claude/
./tico-sync.sh

# Preview what will be linked without making changes
./tico-sync.sh --dry-run
```

After running `tico-sync.sh`, CLAUDE.md will be active in your `~/.claude/` directory and tico-os will initialize on every Claude Code session.

## Model Tiers

| Tier | Model | Default? |
|---|---|---|
| Low-Cost | `claude-haiku-4-5` / local MCP | Yes |
| High-Reasoning | `claude-sonnet-4-20250514` | Only when routing matrix requires it |

## Token Guardrails

| Condition | Action |
|---|---|
| File > 400 lines | Summarize before processing |
| Input > 60k tokens | Chunk sequentially |
| Low-Cost output > 2,000 tokens | Truncate and escalate |
