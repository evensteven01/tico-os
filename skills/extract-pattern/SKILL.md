---
name: extract-pattern
description: Use when the user wants to document a reusable architecture or engineering pattern from one of their projects into the shared proj-incubator architecture/ or processes/ folders ("extract this pattern", "document how we do X for other apps", "add an architecture doc").
---

# Extract Pattern

Writes a portfolio-level doc from a pattern that's proven in a real project, so the next
app (and `evaluate-idea`'s stack recommendations) start from it.

## Steps

1. **Pick the destination** in the incubator (`$TICO_INCUBATOR_DIR`, default
   `~/Development/proj-incubator`): `architecture/<pattern>.md` for system design (data,
   auth, sync, payments, testing strategy), `processes/<topic>.md` for workflow and
   environment SOPs. Read that folder's `README.md` first — it defines the required
   sections and what doesn't belong there (e.g. starter files stay in `tico-os`
   scaffolding; link to them instead of copying).
2. **Read the actual source**, not the project docs' description of it: the code, tests
   and any PERSONA.md locked-decision / risk rows about it. A pattern doc that disagrees
   with the running code is worse than none.
3. **Write the doc** with the README's sections — when to use it (and not), the design and
   its reasons, "Proven in" with links to the files, known pitfalls with the rule that now
   prevents each. Strip project-specific naming where it doesn't help understanding.
4. If the pattern changes a default stack, update the stack table in
   `playbooks/app-evaluation-playbook.md` Phase 2 and the candidate list in
   `architecture/README.md` in the same branch.
5. Branch `pattern/<name>`, commit, push, ask before opening the PR.
