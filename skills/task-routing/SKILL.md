---
name: task-routing
description: Use when deciding whether to hand a sub-task off to the tico-cheap subagent (Haiku) instead of doing it directly. Consult this before starting a sub-task that looks simple, deterministic, or structured.
---

Before doing a sub-task yourself, check whether it fits the `tico-cheap` profile below. If it does, delegate it to the `tico-cheap` subagent via the Agent tool instead of doing it inline.

## Route to tico-cheap when most of these hold

- Single lookup, format conversion, or template fill — not multi-step or open-ended
- High determinism — there's one clearly correct answer
- Expected to resolve in 1–2 turns
- Output is structured (JSON/YAML/list) rather than narrative or design reasoning
- Task requirements are explicit, not underspecified
- A wrong answer is cheap to spot-check, not something that causes downstream failure
- Needs ≤4k tokens of context and touches 0–2 files

## Keep it yourself (or use a full-capability agent) when

- The task is multi-step, open-ended, or novel
- Requirements are ambiguous and need judgment calls
- Output is narrative, logic-heavy code, or a design decision
- A wrong answer would be expensive to catch downstream
- It needs >10k tokens of context or touches ≥3 files

Default to `tico-cheap` unless one of the "keep it yourself" signals is present.

## If tico-cheap's output looks wrong

If the delegated output fails validation, is truncated, or the subagent expresses uncertainty ("not sure", "cannot determine"), don't just retry it — pick the task up yourself with the failed output as context so you can address why it failed.
