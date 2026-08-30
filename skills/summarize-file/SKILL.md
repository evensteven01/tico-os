---
name: summarize-file
description: Use when asked to summarize, compress, or condense a source file — especially one over ~400 lines — while preserving its structure and public API. Produces a compressed version at roughly 15% of the original line count that keeps signatures, types, and behavior-relevant details intact.
---

Compress the target file to at most 15% of its original line count while preserving everything needed to reason about its structure and public behavior.

## Keep

- Function/method signatures (name, parameters, return type)
- Class/interface names with inheritance or implementation targets
- Configuration keys and their types/defaults
- Error/exception types and their parent classes
- Import/dependency declarations
- Public API surface (anything exported or callable from outside the module)
- Schema definitions (type aliases, interfaces, structs, enums)
- Runtime-critical constants (timeouts, limits, flags)

## Strip

- Function bodies (replace with `...`)
- Comments that describe *what* the code does (keep comments that explain *why*)
- Repeated boilerplate (logging, null checks, guard clauses)
- Test setup/fixture data
- Dead or commented-out code

## Output format

- Valid code in the original file's language, indentation and block structure preserved
- `...` as the placeholder for omitted bodies
- No prose, no line numbers

## Metadata

Append a trailing comment block, in the file's native comment syntax:

```
source_file: <path>
original_lines: <N>
summary_lines: <M>
compression_ratio: <M/N as a percentage>
summarized_at: <ISO 8601 timestamp>
```

## Before returning

- Confirm `summary_lines / original_lines ≤ 0.15` — compress further if not
- Confirm every function signature and import from the original is present
- Confirm the metadata block is the last thing in the output
