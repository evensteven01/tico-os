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
  `tico-os`. The portfolio board is the Fordsoft Project Hub (GitHub Project #7); use
  `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh` to read or update it.
