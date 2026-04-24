# tico-os Router — Decision Matrix

## Model Tiers

| Tier | Model | Use When |
|---|---|---|
| High-Reasoning | `claude-sonnet-4-20250514` | Complex, multi-step, ambiguous, or high-stakes tasks |
| Low-Cost | `claude-haiku-4-5` / local MCP | Simple, deterministic, short-turn, structured output |

---

## Routing Decision Matrix

| Signal | High-Reasoning | Low-Cost |
|---|---|---|
| **Complexity** | Multi-step reasoning, open-ended analysis, novel problem | Single lookup, format conversion, template fill |
| **Determinism** | Low — output varies by interpretation | High — one correct answer exists |
| **Expected turns** | ≥3 turns likely | 1–2 turns sufficient |
| **Output type** | Narrative, code with logic, design decisions | JSON, YAML, structured data, list extraction |
| **Ambiguity** | Task requirements are underspecified | Task requirements are explicit |
| **Validation risk** | Incorrect output causes downstream failure | Output can be spot-checked cheaply |
| **Context depth** | Requires >10k tokens of context | Works within 4k tokens |
| **File count** | Touches ≥3 files | Touches 0–2 files |

**Default:** route to Low-Cost unless any High-Reasoning signal is present.

---

## Token Guardrails

### Large File Rule
If any input file exceeds **400 lines**, do not pass it raw to the model.
1. Run `.tico/prompts/summarize.md` on that file first.
2. Pass the summary as context instead of the full file.
3. Keep the original available for targeted lookups only.

### Input Token Ceiling
If the total input (system prompt + context + task) exceeds **60,000 tokens**:
1. Identify the largest context block.
2. Chunk it into sequential segments of ≤50k tokens each.
3. Process each chunk in order, carrying a running summary forward.
4. Never process all chunks simultaneously.

### Low-Cost Output Cap
If Low-Cost model output exceeds **2,000 tokens**:
1. Truncate the response at the 2,000-token boundary.
2. Append `[FLAGGED: output truncated — escalation required]` to the result.
3. Escalate to High-Reasoning (see Escalation Protocol below).

---

## Escalation Protocol

Trigger escalation when any of the following occur:
- Low-Cost output fails validation (schema mismatch, assertion error, empty result)
- Low-Cost output is truncated and flagged
- Low-Cost model returns an uncertainty signal ("I'm not sure", "cannot determine")
- Task turns exceed 2 without resolution

### Escalation Steps
1. Preserve the full Low-Cost output (do not discard).
2. Construct an escalation payload:
   ```
   ESCALATION CONTEXT:
   - Original task: <task>
   - Low-Cost model used: <model>
   - Low-Cost output (failed): <output>
   - Failure reason: <validation_error | truncation | uncertainty>
   ```
3. Pass the escalation payload as the first block of the High-Reasoning prompt.
4. High-Reasoning model must explicitly address the failure before producing its own output.
5. Log the escalation event with timestamp and reason.
