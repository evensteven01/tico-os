# Readiness Testing Plan

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md). Scope reference:
[08-mvp-definition.md](08-mvp-definition.md). This doc answers **how** each MVP item gets
verified, so "tested" means "there's a specific, named check that passed," not "I used it
for a while and it seemed fine."

## Test layers, and what each one is actually for

Four distinct layers, each catching a different failure mode. Skipping one because another
layer "probably covers it" is exactly the leniency this plan rules out — they overlap in
coverage, not in purpose.

1. **Automated tests** — catch logic errors cheaply, forever.
2. **Manual device/environment QA** — catches what automated tests structurally can't:
   rendering, platform quirks, real interaction, performance in the real environment.
3. **Beta (real humans)** — catches product/UX problems neither of the above can see,
   because it requires someone who isn't the maker and doesn't already know how the product
   expects to be used.
4. **Non-functional checks** (performance, data durability) — catch failure modes that
   don't show up in a quick functional pass, and that are disproportionately severe for
   this specific product's architecture.

## 1. Automated test matrix

<!-- Table: # | Scenario | Why it matters. Target the load-bearing calculation/logic named
in the Coder persona file, plus enough of the persistence layer that a schema/query
regression fails a test instead of shipping silently. Every row should be a named test, not
folded into one "general coverage" test. Include specifically: any scenario involving time
passing (stale state, rollover, recurrence), any scenario involving multiple instances of a
repeating concept (ordering/precedence), and any scenario at a numeric edge (zero, negative,
boundary values). -->

| # | Scenario | Why it matters |
|---|---|---|

## 2. Manual device/environment QA matrix

<!-- Table or list: minimum real-hardware/real-environment coverage (not just
simulator/local dev) — for each, verify the full core loop, empty states, form validation
errors, and behavior under interruption (backgrounded, force-closed, network dropped, etc.
as applicable). -->

## 3. Beta exit criteria

<!-- Explicit, checkable bar for "the beta passed" per
07-beta-testing-program.md — not just "we ran it and got some comments." Typically:
zero known correctness bugs in the core value calculation/output, no crashes across
participating environments, a retention/engagement threshold among niche-fit testers
specifically, and setup-friction feedback either resolved or consciously accepted with a
written reason. -->

## 4. Non-functional checks

### Data durability

<!-- If there's no server-side backup for user data (or even if there is, for the
local-first portion), test: what happens if the app is interrupted mid-write; whether an
update/deploy preserves existing data (test explicitly by upgrading a real installation,
not assuming schema stability); and if a backup/export feature exists, a full round-trip
test (export, wipe, reimport, verify exact match). -->

### Performance under realistic data volume

<!-- Seed/dev data is usually small and clean by design. Test with a larger, messier
dataset resembling real long-term usage before launch — a calculation that's correct but
slow on realistic data is a launch-week discovery worth having now instead. -->

## Go/No-Go gate (run this once, right before submission)

- [ ] Every row in the automated test matrix exists as a named, passing test.
- [ ] Manual device/environment QA completed this week, not "a while ago, should still be
      fine."
- [ ] Beta exit criteria met — not "mostly met" or "the remaining issues are minor."
- [ ] Every **In scope** row in [08-mvp-definition.md](08-mvp-definition.md) is built to its
      stated acceptance bar, including a resolved (not defaulted) decision on every flagged
      gap.
- [ ] Data durability checks run against the actual release build, not an earlier
      development build.
- [ ] Every box in [05-launch-readiness-checklist.md](05-launch-readiness-checklist.md)'s
      operational/store-submission section is checked.

If any box is unchecked, the honest answer is "not ready" — check MASTER_PLAN.md's working
assumption before deciding whether closing that gap is actually as costly as it feels.
