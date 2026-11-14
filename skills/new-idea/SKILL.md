---
name: new-idea
description: Use when the user has a new app idea to capture or pitch ("I have an idea for…", "add an idea", "new app concept", "jot down an idea"), or wants to evaluate an idea sitting in the Hub's Inbox — quick mode logs a one-line idea as an [Idea] issue in the Inbox; full mode runs Phase 1 (Brainstorming & Core Pitch) of the proj-incubator evaluation playbook conversationally, writes ideas/<slug>.md from the template, and moves the Hub card to Idea Backlog.
---

# New Idea

Captures an app idea into `proj-incubator`. Two modes:

- **Quick** (`--quick "<one line>"`, or "just jot this down"): an `[Idea]` issue and an
  **Inbox** card on the Hub. No interview, no spec file. Seconds, not minutes.
- **Full** (default): **Phase 1 only** of the evaluation playbook, ending in a spec file and
  the card in **Idea Backlog**, or Park/Kill. Phases 2–3 are `evaluate-idea`'s job; don't
  run ahead into scoping or market analysis here, even if the user is excited.

## Locations

- Incubator repo: `$TICO_INCUBATOR_DIR`, default `~/Development/proj-incubator` (GitHub
  `evensteven01/proj-incubator`). If it isn't cloned, clone it with `gh repo clone`.
- **Read these from the repo every time; never use a remembered copy**, since they're edited
  there: `playbooks/app-evaluation-playbook.md` (life cycle, Phase 1 steps, Gate 1) and
  `ideas/TEMPLATE-app-spec.md`.
- Hub board: `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh` (`options` lists valid values).

## Quick mode

1. **Check for duplicates**: `board.sh list` (Hub cards) and grep `ideas/` for the concept,
   including parked and killed ones. If one exists, show it and ask before adding another.
2. **Create the issue** on `evensteven01/proj-incubator`, titled `[Idea] <short name>`,
   with this body:

   ```markdown
   **Inbox idea, not yet evaluated.**

   <the user's one line, in their words>

   - Captured: <YYYY-MM-DD>
   - Next step: `/tico-os:new-idea` on this issue to run the Phase 1 interview.
   ```

3. `board.sh add <issue-url> --status Inbox`. No branch or PR: nothing in the repo changed.
4. Reply with the issue link, in one line. Don't start the interview unless asked.

## Full mode

1. **Pull latest** `main` in the incubator repo and read the playbook's Phase 1 and the
   template.
2. **Find the idea's Hub card.** If the user names an Inbox card (or one matches), use that
   issue from here on instead of creating a new one. Otherwise check for duplicates as in
   quick mode: grep `ideas/` and the Hub, including parked and killed ideas. If one exists,
   show its decision and reasoning and ask whether this is a new angle or a revisit before
   creating anything.
3. **Interview, don't invent.** Ask for the raw idea, the target segment and where they
   gather, the pain point in the audience's words, evidence, current workaround, and
   frequency/intensity: a few questions at a time, not a form dump. Draft the value
   proposition from the answers and let the user correct it. Anything the user doesn't know
   is written `Unknown — <how to find out>`.
4. **Run the 10-minute competitor smoke test** with web search: search the pain-point
   phrase and the obvious category terms, record the top results with dates. This is a
   smoke test only: no full competitor table.
5. **Score Gate 1** honestly against the playbook's checklist and tell the user which
   boxes pass. Failing Gate 1 is a fine outcome: record it (Decision = Park or Kill with the
   reason) rather than inflating answers to pass.
6. **Write the spec**: on a new branch `idea/<slug>`, copy the template to
   `ideas/<slug>.md` (short kebab-case slug), fill the header table and Phase 1, leave
   Phases 2–3 as template placeholders, set Status = `Idea Backlog` (or `Archived` if
   killed), Decision = `Pending` / `Park` / `Kill`, today's date. Delete the template's
   how-to comment block.
7. **Issue and Hub card.**
   - From an Inbox card: replace the issue body (below), then
     `board.sh set <issue-url> Status "Idea Backlog"` (killed → `Archived`).
   - New idea: create the `[Idea] <name>` issue on `evensteven01/proj-incubator`, then
     `board.sh add <issue-url> --status "Idea Backlog"` (killed → `--status Archived`).

   Issue body: the one-sentence value prop, plus a link to `ideas/<slug>.md` on `main`. Put
   the issue URL in the spec's **Hub card** field.
8. **Commit and push the branch**, then ask before opening the PR (house rule).
9. Close with the next step: `/tico-os:evaluate-idea <slug>` when ready to scope it.
