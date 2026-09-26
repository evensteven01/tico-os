# MVP Definition

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md). This doc answers one question precisely:
**what exact feature set ships in v1**, so "is it ready" stops being a judgment call and
becomes a checklist against this list. Testing methodology for verifying each item lives in
[09-readiness-testing-plan.md](09-readiness-testing-plan.md).

## What "MVP" means here (and what it doesn't)

MVP = **the smallest feature set that fully and correctly delivers the core promise in
[01-positioning-and-niche.md](01-positioning-and-niche.md)** — not "everything in SPEC.md
minus whatever's inconvenient," and not "a rough version of everything, to be finished
later." Two failure modes to rule out explicitly:

- **Too broad** — building a later phase's features before launch wastes effort that
  doesn't move launch readiness at all. See MASTER_PLAN.md's working assumption on scope
  discipline.
- **Too shallow** — shipping a documented SPEC requirement half-finished, or without tests.
  See [05-launch-readiness-checklist.md](05-launch-readiness-checklist.md).

Every item below is either **In scope** (fully done, tested, polished — no partial credit)
or **Out of scope** (deliberately not built for v1, with a stated reason). No third
"partially done is fine" category.

## In scope for v1

<!-- Table: Feature | Source (SPEC section / ticket #) | Acceptance bar. Cross-reference
SPEC.md §4's functional-requirements table row by row — every SPEC requirement should map
to either a ticket or a flagged gap below, never silently missing. -->

| Feature | Source | Acceptance bar |
|---|---|---|

## Flagged gaps: SPEC requirements or obvious needs with no ticket

<!-- For each gap found while cross-referencing SPEC.md against the actual ticket backlog:
name it, explain why it matters, and resolve it deliberately — either "add a ticket, keep
in MVP" or "defer, and update SPEC.md to say so explicitly so the spec doesn't quietly
diverge from the shipped product." A spec that silently stops matching the app is a bigger
long-term risk than the missing feature itself. Recurring category worth checking on any
product with no server-side backup: is there a recovery path if the local copy of a user's
data is lost? If not, that's usually worth flagging the same way it was for a fully-local
architecture — unrecoverable data loss is often a worse trust failure than a bug. -->

## Functional completeness: behavioral questions SPEC doesn't answer

<!-- The gaps above are missing *screens*. This section is for gaps in what the core
mechanic actually *does over time / under real usage* — these are the ones that only
surface once a real person uses the product past the first session, and get them wrong and
the core promise quietly breaks without any single test catching it, because each is a
design decision, not a bug. Before writing this section, actually read the relevant source
code rather than reasoning from SPEC.md alone — SPEC describes intent, not necessarily
current implementation, and checking the code can change the recommendation entirely.
Recurring categories worth checking on most products: -->

### Does any state that's supposed to auto-update actually auto-update, or does it silently go stale without user action?

### If there's more than one instance of a repeating/scheduled concept, what defines precedence or ordering between them?

### Is there a fast, low-friction way to do the single most common repeated user action, or does it require the full edit/detail flow every time?

### Does a first-time user understand the core mental model without explanation, especially if it differs from the category's usual mental model?

## Out of scope for v1 (deliberately, with reasons)

| Feature | Why deferred |
|---|---|
<!-- Table, each row with the SPEC section/phase or explicit product reasoning that
justifies the deferral — not just "not important." -->

## How this doc gets used

The "finish the MVP" phase in MASTER_PLAN.md is done when every **In scope** row above is
built to its stated acceptance bar and verified per
[09-readiness-testing-plan.md](09-readiness-testing-plan.md) — not when the obviously-open
tickets are closed and everything else is assumed fine. Re-check this table against
TICKETS.md whenever a ticket closes, and update it if scope changes in either direction —
don't let this file drift out of sync with reality any more than SPEC.md is allowed to.
