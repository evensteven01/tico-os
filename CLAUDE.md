# tico-os — Claude Code Session Init

## Startup Sequence

On every session start in this directory, execute the following:

1. **Scan `.tico/skills/`** — list all `.md` files found and log them as `[SKILL LOADED]`
2. **Scan `.tico/prompts/`** — list all `.md` files found and log them as `[PROMPT LOADED]`
3. **Report session readiness:**
   ```
   tico-os ready
   Skills: <N> loaded
   Prompts: <M> loaded
   Default tier: Low-Cost (claude-haiku-4-5)
   ```

If `.tico/skills/router.md` is missing, halt and warn: `[WARN] Router not found — all tasks will default to High-Reasoning.`

---

## Think-Step-Check Loop

Every task — no exceptions — follows this loop:

### THINK
Before touching any file or tool:
- State the task in one sentence.
- Identify which model tier to use (consult `.tico/skills/router.md`).
- List the files or tools you will touch.
- Flag any file >400 lines (requires summarize before processing).
- Estimate token cost. If input >60k tokens, plan chunking.

### STEP
Execute exactly one unit of work:
- One file edit, one command, one API call, one search.
- Do not batch multiple logical changes into a single step.
- After each step, state what changed and what the next step will be.

### CHECK
After each step:
- Verify the output matches the expected result.
- If output is invalid, do not proceed — surface the error and re-plan.
- If Low-Cost output is flagged for escalation, stop and escalate before continuing.
- Only move to the next step when the current step passes CHECK.

---

## tico Commands

| Command | What it does |
|---|---|
| `tico scan` | Re-scan `.tico/skills/` and `.tico/prompts/` and print loaded assets |
| `tico route <task>` | Print which model tier the router selects for a given task description |
| `tico summarize <file>` | Run `.tico/prompts/summarize.md` on the given file and output the compressed version |
| `tico status` | Show current session state: tier, active context size, escalation count |
| `tico sync` | Run `tico-sync.sh` to symlink tico assets into `~/.claude/` |
| `tico check` | Validate that all required tico assets are present and well-formed |

---

## Token Efficiency Rules

1. **Route first** — before processing any task, determine the correct model tier. Never skip routing.
2. **Summarize large files** — any file >400 lines must be summarized via `.tico/prompts/summarize.md` before being passed as context.
3. **Prefer Low-Cost by default** — use High-Reasoning only when the routing matrix explicitly calls for it.
4. **No padding** — do not add filler text, unnecessary caveats, or redundant explanations. Every token in a prompt must earn its place.
5. **No speculative context** — do not include files or sections "just in case." Include only what the current step requires.
6. **Chunk large inputs** — never pass >60k tokens at once. Chunk sequentially and carry a running summary.

---

## Session Behavior

- All responses follow the Think-Step-Check loop. No exceptions.
- Escalations are logged with a timestamp and reason before proceeding.
- If a tico command is invoked, execute it immediately and report the result before continuing with any other work.
- The routing decision must be stated explicitly at the start of every non-trivial task.
