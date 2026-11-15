# Tickets — {{PROJECT_NAME}}

The work for {{PROJECT_NAME}} lives in **GitHub issues on
[`{{CODE_REPO_NAME}}`](https://github.com/{{OWNER}}/{{CODE_REPO_NAME}}/issues)**, tracked on
the **[Fordsoft Development board → {{APP_SLUG}}]({{BOARD_VIEW_URL}})**. That board is the
only list of tickets: this file holds the conventions, not the tickets, so there's nothing
here to keep in sync.

Portfolio-wide conventions (labels, epics, priority and size, where issues are filed) are
in [proj-incubator's ticket conventions](https://github.com/evensteven01/proj-incubator/blob/main/processes/ticket-conventions.md).
This file only records what's specific to {{PROJECT_NAME}}.

## Where to look

| Question | Look at |
|---|---|
| What's being worked on? | The board's **Current focus** view (Ready + In progress, all apps) |
| What's left before launch? | The **[v1.0 Launch milestone](https://github.com/{{OWNER}}/{{CODE_REPO_NAME}}/milestone/{{MILESTONE_NUMBER}})**, or the board's **Launch readiness** view |
| Everything for this app | The **{{APP_SLUG}}** board view |
| What was deliberately left out of v1? | Issues labelled [`deferred`](https://github.com/{{OWNER}}/{{CODE_REPO_NAME}}/labels/deferred) |

## Project-specific conventions

<!-- Only what differs from, or adds to, the portfolio conventions. Typical entries:

- **Tiers:** which pricing tier a feature is gated behind, as labels (`paid-tier`,
  `subscription-tier`), defined by `go-to-market/03-pricing-strategy.md`. Add once a
  pricing model exists (`setup-github.sh <repo> --with-tiers`).
- **Other repos:** if the app has a `-landing` or `-backend` repo, issues still go on
  `{{CODE_REPO_NAME}}`; say so here, and how PRs in the other repo reference them
  (`Fixes {{OWNER}}/{{CODE_REPO_NAME}}#123`).
- **Starter go-to-market issues** to file once 01/03/08 are drafted (each `[GTM]`-prefixed,
  `go-to-market` label, Phase B/C ones in `v1.0 Launch`): lock the final product name;
  finalize price point and free-tier limits; decide seller identity (personal vs. business
  entity: a portfolio-wide decision, so file it under App = `Shared` if it isn't already
  settled); listing copy; screenshots; final icon; privacy policy and EULA decision;
  support channel; developer/payment accounts and product config; beta program (plus a
  recruiting landing page only if the personal network isn't enough); launch-day channels;
  a post-launch landing page or first content piece. Platform-specific items come from
  platforms/<platform>/PLATFORM.md §05, and every 05-checklist item should have an issue.

Delete this comment once the section has real entries, or delete the section if there's
nothing project-specific. -->
