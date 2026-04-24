# tico-os Architecture

## Task Flow

```
User Input
    │
    ▼
CLAUDE.md (session init + Think-Step-Check enforcement)
    │
    ├── tico scan       → lists loaded skills and prompts
    ├── tico route      → determines model tier
    ├── tico summarize  → compresses large files before routing
    ├── tico status     → reports session state
    ├── tico sync       → symlinks assets to ~/.claude/
    └── tico check      → validates asset integrity
    │
    ▼
.tico/skills/router.md (routing decision matrix)
    │
    ├── File >400 lines? ──► .tico/prompts/summarize.md ──► compressed context
    │
    ├── Input >60k tokens? ──► sequential chunking
    │
    ├── Task signals? ──────────────────────────────────────────────┐
    │                                                               │
    ▼                                                               ▼
Low-Cost Tier                                           High-Reasoning Tier
claude-haiku-4-5 / local MCP                           claude-sonnet-4-20250514
    │                                                               │
    ▼                                                               │
CHECK Phase ◄───────────────────────────────────────────────────────┘
    │
    ├── PASS → next step
    │
    └── FAIL / truncation / uncertainty
            │
            ▼
        Escalation payload constructed
            │
            ▼
        High-Reasoning Tier (with failed output as context)
            │
            ▼
        CHECK Phase → PASS → continue
```

---

## Token Budget Table

| Stage | Limit | Action on Breach |
|---|---|---|
| Single file input | 400 lines | Summarize via `summarize.md` before processing |
| Total prompt input | 60,000 tokens | Chunk sequentially; carry running summary |
| Low-Cost output | 2,000 tokens | Truncate, flag, escalate to High-Reasoning |
| High-Reasoning output | No hard cap | Prefer concise; no padding rule applies |
| Summary compression | ≤15% of original lines | Re-compress if threshold not met |

---

## Asset Map

```
tico-os/
├── CLAUDE.md                    # Session init, Think-Step-Check, tico commands
├── tico-sync.sh                 # Symlink installer for ~/.claude/ integration
├── docs/
│   └── architecture.md          # This file
└── .tico/
    ├── skills/
    │   └── router.md            # Routing matrix, token guardrails, escalation
    └── prompts/
        └── summarize.md         # File compression prompt (≤15% lines)
```

---

## Model Tier Summary

| Tier | Model ID | Token Cost | Use Case |
|---|---|---|---|
| High-Reasoning | `claude-sonnet-4-20250514` | Higher | Complex, ambiguous, multi-step, high-stakes |
| Low-Cost | `claude-haiku-4-5` | Lower | Deterministic, structured, 1–2 turn tasks |
| Local MCP | Configured per environment | Minimal | Offline, privacy-sensitive, or high-volume tasks |

---

## Escalation Flow Detail

```
Low-Cost attempt
    │
    └── Validation fail / truncation / uncertainty
            │
            ▼
    Escalation payload:
    {
      original_task,
      low_cost_model,
      low_cost_output,       ← preserved, not discarded
      failure_reason
    }
            │
            ▼
    High-Reasoning processes payload
    (must address failure before producing output)
            │
            ▼
    CHECK phase repeated
```
