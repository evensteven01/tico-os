---
name: new-idea
description: Use when the user has a new app idea to capture or pitch ("I have an idea for…", "add an idea", "new app concept") — runs Phase 1 (Brainstorming & Core Pitch) of the proj-incubator evaluation playbook conversationally, writes ideas/<slug>.md from the template, opens a tracking issue, and adds it to the portfolio board as Idea Backlog / App Concept.
---

# New Idea

Captures an app idea into `proj-incubator` and takes it through **Phase 1 only** of the
evaluation playbook. Phases 2–3 are `evaluate-idea`'s job — don't run ahead into scoping or
market analysis here, even if the user is excited; a captured idea with an honest Phase 1 is
the goal.

## Locations

- Incubator repo: `$TICO_INCUBATOR_DIR`, default `~/Development/proj-incubator` (GitHub
  `evensteven01/proj-incubator`). If it isn't cloned, clone it with `gh repo clone`.
- **Read these from the repo every time; never use a remembered copy** — they're edited
  there: `playbooks/app-evaluation-playbook.md` (Phase 1 steps + Gate 1) and
  `ideas/TEMPLATE-app-spec.md`.
- Board: `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh` (`options` lists valid values).

## Steps

1. **Pull latest** `main` in the incubator repo and read the playbook's Phase 1 and the
   template.
2. **Check for duplicates**: grep `ideas/` for a similar concept, including parked and
   killed ones. If one exists, show its decision and reasoning and ask whether this is a
   new angle or a revisit before creating anything.
3. **Interview, don't invent.** Ask for the raw idea, the target segment and where they
   gather, the pain point in the audience's words, evidence, current workaround, and
   frequency/intensity — a few questions at a time, not a form dump. Draft the value
   proposition from the answers and let the user correct it. Anything the user doesn't know
   is written `Unknown — <how to find out>`.
4. **Run the 10-minute competitor smoke test** with web search: search the pain-point
   phrase and the obvious category terms, record the top results with dates. This is a
   smoke test only — no full competitor table.
5. **Score Gate 1** honestly against the playbook's checklist and tell the user which
   boxes pass. Failing Gate 1 is a fine outcome: record it (Decision = Park or Kill with the
   reason) rather than inflating answers to pass.
6. **Write the spec**: on a new branch `idea/<slug>`, copy the template to
   `ideas/<slug>.md` (short kebab-case slug), fill the header table and Phase 1, leave
   Phases 2–3 as template placeholders, set Status = `Idea Backlog` (or `Archived` if
   killed), Decision = `Pending` / `Park` / `Kill`, today's date. Delete the template's
   how-to comment block.
7. **Open the tracking issue** on `evensteven01/proj-incubator`: title `[Idea] <name>`,
   body = the one-sentence value prop + a link to `ideas/<slug>.md` on `main`. Then add it
   to the board:
   `board.sh add <issue-url> --status "Idea Backlog" --category "App Concept"`
   (killed at Gate 1 → `--status "Archived"`). Put the issue URL into the spec's
   **Board item** field.
8. **Commit and push the branch**, then ask before opening the PR (house rule).
9. Close with the next step: `/tico-os:evaluate-idea <slug>` when ready to scope it.
