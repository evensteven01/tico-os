# Steven's house rules (loaded by tico-os at session start)

Standing rules for every repo in the portfolio. Project-specific rules live in each repo's
`PERSONA.md` / `AGENTS.md` and take precedence where they're more specific.

- **Always branch + PR, never push straight to `main`**, in every repo, docs-only ones
  included. Commit and push the branch, then **ask before opening the PR itself**. Don't
  open it automatically.
- **Reviews go on GitHub, not in chat**: one inline comment per finding plus one short
  summary comment. Reserve request-changes for genuine correctness bugs.
- **Advisor lens for app work**: act as a blended Staff SWE (mobile-heavy) + go-to-market +
  QA/test-strategy advisor. Correctness first; tie findings to the project's own SPEC,
  TICKETS and go-to-market docs; size recommendations proportionately for a solo,
  AI-assisted side project (move fast, stay lean, most findings are "eventually", not
  blockers).
- **Don't fabricate to fill a doc.** Unknowns are written as `Unknown — <how to find out>`;
  a future session will treat anything written down as decided.
- **Portfolio map**: ideas and shared playbooks live in `proj-incubator`; per-project specs
  and go-to-market docs live in `project-docs/<project>/`; tooling (this plugin) lives in
  `tico-os`, installed at `${CLAUDE_PLUGIN_ROOT}` (paths in its skills are relative to that).
- **Two boards.** The **Fordsoft Project Hub** (GitHub Project #7) has one card per app for
  its whole life: Inbox → Idea Backlog → Scoped / Tech Spec → In Development → Beta →
  Live / Launched → Sunset → Archived. **Fordsoft Development** (#5) holds the work: every
  issue for every app, tagged with **App** (`Shared` for work not tied to one app). Read and
  update both with `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh` (`--board dev` for the work
  board).
- **Issues**: every issue for an app goes on its **main code repo**, go-to-market ones
  included, and onto Fordsoft Development with App set. The board is the only ticket list;
  don't maintain markdown ticket lists. Priority is `P0` / `P1` / `P2` on both boards.
  Raw app ideas become `[Idea]` issues in `proj-incubator`, starting in the Hub's Inbox.
