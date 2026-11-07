# Ticket Tracker — {{CODE_REPO_NAME}}

Source of truth for planning is GitHub Issues on `{{CODE_REPO_NAME}}`; this file is a
point-in-time index for quick scanning. Update it whenever a ticket's status changes
(opened, PR up, merged) or the plan is reordered. Rows are sorted by **Priority first**
(highest on top; matches the Priority field on the Project board, if one exists), then
planned/execution order within a priority tier — not issue-number order.

**Tier column:** which pricing tier (from `go-to-market/03-pricing-strategy.md`) a ticket's
feature is gated behind, mirroring the `paid-tier`/`subscription-tier` GitHub labels. Blank
means free/unlimited — the default. Leave the column out until a pricing model exists.

For "what's left before launch," use the **v1.0 Launch** GitHub milestone rather than
reading this file — it spans this file and `go-to-market/GTM_TICKETS.md`.

| # | Priority | Tier | Description | PR | Status |
|---|---|---|---|---|---|
<!-- One row per issue: [#](issue URL) | **P0** / P1 / — | Paid / blank | short description |
[PR#](PR URL) or — | status (Open / In progress / In review / Merged / Done). Keep
descriptions short enough to scan; the issue body holds the detail. P0 = required for v1
launch (and on the v1.0 Launch milestone). -->

**Decided: deferred to a later version**

<!-- Same columns. Tickets that were explicitly decided out of v1 — kept in their own table
so "not prioritized yet" and "deliberately later" don't blur together. Omit until one
exists. -->

<!-- If a `go-to-market` label + `[GTM]` prefix are in use for this repo (see
go-to-market/GTM_TICKETS.md), leave those issues out of this file entirely — they get their
own index, not a mixed-in row here. -->
