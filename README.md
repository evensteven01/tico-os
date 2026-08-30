# tico-os

Personal Claude Code plugin, plus a reusable house-rules template, synced across machines via git.

## What's in here

```
tico-os/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/
│   ├── summarize-file/
│   │   └── SKILL.md         # Compress a large file to ~15% of its lines, preserving signatures
│   └── task-routing/
│       └── SKILL.md         # Guidance for when to delegate to tico-cheap instead of working inline
├── agents/
│   └── tico-cheap.md        # Haiku-pinned subagent for cheap, deterministic sub-tasks
├── AGENTS.md.template       # House-rules template — copy into any repo as AGENTS.md
└── docs/
    └── architecture.md
```

## Using the plugin (Claude Code)

On any machine:

```bash
git clone <this-repo-url> ~/Development/tico-os
git -C ~/Development/tico-os pull   # keep it current
claude --plugin-dir ~/Development/tico-os
```

This loads the `summarize-file` and `task-routing` skills and the `tico-cheap` subagent for that session. Skills are namespaced as `/tico-os:summarize-file` etc.

## Using the house rules (Claude Code + Cursor)

`AGENTS.md.template` is not auto-applied — it's per-project opt-in:

1. Copy it into a target repo as `AGENTS.md`.
2. Cursor reads it natively, no further setup.
3. For Claude Code to pick it up in that repo too, add one line to that repo's own `CLAUDE.md`:
   ```
   @AGENTS.md
   ```

## Why not a symlink installer?

The previous version of this repo (`tico-sync.sh`) symlinked flat `.md` files into `~/.claude/skills/` and `~/.claude/prompts/`. That's not the shape Claude Code actually reads — skills need a `<name>/SKILL.md` directory, and there's no `~/.claude/prompts/` convention. `--plugin-dir` against a synced clone is the supported mechanism for this.
