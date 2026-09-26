# tico-os Architecture

## Components

- **skills/summarize-file** — a real Claude Code skill. Claude auto-invokes it when a task matches its description (summarizing/compressing a large file), or it can be called directly as `/tico-os:summarize-file`.
- **skills/task-routing** — not executable logic; it's guidance content that tells Claude when a sub-task fits the `tico-cheap` profile and should be delegated rather than done inline.
- **skills/new-project-setup** — bootstraps the three-persona system (Coder, Reviewer, GTM
  Advisor) and the SPEC/TICKETS/go-to-market doc structure onto a new project, first
  developed for `budget-app`. Ships as instructions (`SKILL.md`) plus a `templates/`
  directory of fill-in `.md` files (two persona templates, `SPEC.md`, `TICKETS.md`, and the
  nine-doc go-to-market planning set) — the skill's job is choosing which templates apply,
  gathering real project-specific content through conversation, and refusing to fabricate
  content just to fill a section.
- **agents/tico-cheap** — a subagent definition pinned to `model: haiku` via its frontmatter. When `task-routing` guidance says to delegate, Claude spawns this agent through the Agent tool. This is the actual cost lever — Claude Code has no automatic complexity-detection router; delegation is deliberate, not automatic.
- **AGENTS.md.template** — plain house-rules content, not part of the plugin. Copied per-project. Cursor reads `AGENTS.md` natively in all modes; Claude Code needs a `@AGENTS.md` import line in that project's own CLAUDE.md.

## Delegation flow

```
Task arrives
    │
    ▼
Does it match task-routing's tico-cheap profile?
    │
    ├── Yes → Agent tool spawns tico-cheap (haiku)
    │             │
    │             ▼
    │         Output validates?
    │             │
    │             ├── Yes → done
    │             └── No  → pick up the task directly, using the failed
    │                       output as context for what went wrong
    │
    └── No → handle directly (or with a full-capability subagent)
```

## Why this replaced the original design

The original `.tico/skills/router.md` + `.tico/prompts/summarize.md` + `tico-sync.sh` scheme assumed Claude Code auto-scans arbitrary directories for "skills" and "prompts," and that a session could self-report which model tier it switched to. Neither is true: Claude Code only discovers skills at `<dir>/skills/<name>/SKILL.md` (personal, project, or plugin-scoped), there's no `prompts/` scan, and a session can't change its own underlying model — only subagents can be pinned to a different one via their `model:` frontmatter. This version uses only mechanisms that actually exist.
