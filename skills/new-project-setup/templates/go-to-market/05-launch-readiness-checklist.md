# Launch Readiness Checklist

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md).

Two separate questions get conflated when people ask "is it ready to launch?" —
**product readiness** (does it work correctly, is the MVP feature set actually complete)
and **operational readiness** (all the non-code artifacts a store/distribution submission
requires). Both gate launch; neither is sufficient alone.

## Read this before the checklist: how lenient is "lenient" here?

<!-- State the project's actual leniency stance explicitly, tied to the working assumption
in MASTER_PLAN.md. If dev is cheap/fast relative to distribution, there's no good excuse to
defer a fixable gap "to save time" that isn't actually scarce — every box below should be a
hard requirement, not a stretch goal. If dev genuinely is the bottleneck for this project,
say that instead and be explicit about which gaps are truly acceptable to ship with vs.
which are not — don't copy a zero-leniency stance uncritically onto a resource-constrained
team where it isn't actually the right call. -->

## Product readiness

<!-- Point to 08-mvp-definition.md (exact in/out scope + acceptance bars) and
09-readiness-testing-plan.md (how each item is verified) rather than duplicating that
content here — this section should be a pointer plus whatever launch-blocking items are
genuinely specific to *this* checklist (e.g. "ship on both platforms, not one," if that's a
live question for this project). -->

## Operational / store-submission readiness

<!-- Checklist, adapted to the actual distribution channel(s) — app store(s), web, package
registry, etc. Common items when targeting a mobile app store: -->

- [ ] **Product name locked** and checked for store-name collisions (see
      [01](01-positioning-and-niche.md)).
- [ ] **App icon** — final, all required sizes/formats per platform.
- [ ] **Screenshots** produced per [02](02-app-store-listing.md).
- [ ] **Privacy Policy URL** — required even for an app that collects nothing; write a
      short, honest policy reflecting actual data handling.
- [ ] **Terms of Use / EULA** — explicit decision (custom vs. platform default), not
      discovered at submission time.
- [ ] **Support URL / contact method.**
- [ ] **Privacy nutrition label / data safety form** — filled out accurately against actual
      architecture, revisited the moment that architecture changes (e.g. a new network call
      is added).
- [ ] **Age rating questionnaire.**
- [ ] **In-app purchase / payment configuration** matching [03](03-pricing-strategy.md),
      sandbox-tested before submission.
- [ ] **Developer accounts active** with correct legal/tax/banking info — payout
      verification can take days, budget lead time before the submission crunch.
- [ ] **Crash reporting** wired in so launch-week issues are visible instead of discovered
      via reviews.

## Beta testing (recommended before public submission)

Run the structured beta program in [07-beta-testing-program.md](07-beta-testing-program.md)
and don't move to public launch until its exit criteria are met — it's the cheapest
available check on the plan's biggest open assumptions before spending any marketing effort.

## "Ready to launch" definition

Ready means every box above is checked, **and** the Go/No-Go gate at the end of
[09-readiness-testing-plan.md](09-readiness-testing-plan.md) passes in full — not "mostly
checked" or "checked for the common case." The gate is that checklist, run honestly, right
before submission — not the calendar date, competitive pressure, or sunk time invested.
