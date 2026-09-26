# Friends & Trusted-Tester Beta Program

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md). Feeds into
[05-launch-readiness-checklist.md](05-launch-readiness-checklist.md) (product readiness),
[01-positioning-and-niche.md](01-positioning-and-niche.md) (validating the niche bet), and
[04-marketing-and-acquisition.md](04-marketing-and-acquisition.md) (testers become launch
assets, not just QA).

## Why this is worth doing

<!-- Name the specific open uncertainties this de-risks for THIS product — usually some
version of "is the core friction point (named in 01) actually too much friction" and "does
the core mechanic hold up on real, messy data/usage that a developer's own testing won't
surface because the developer already knows how the product expects to be used." -->

## Two tracks, not one undifferentiated group

- **Track A — close friends/family.** Low-pressure, honest feedback, good for catching UX
  confusion and bugs early. Doesn't need to match the target niche.
- **Track B — people who actually fit the niche from [01](01-positioning-and-niche.md).**
  Weight this group's feedback more heavily on the "will a stranger in this niche want
  this" question.

Don't only recruit people motivated to protect the maker's feelings — a beta that only
includes that group won't surface the friction that matters.

## Privacy and comfort — say this explicitly when recruiting

<!-- Two distinct concerns: (1) technical privacy/data-handling — state plainly and
accurately what happens to their data given the actual architecture; (2) social comfort —
if testers include coworkers/acquaintances rather than only close friends, some
categories of data (financial, health, personal) may create awkwardness even when the
technical privacy story is fine. Offer a way to test with non-real/sample data if that
removes friction without weakening the test. -->

## What to actually ask them to do

<!-- Give structure — an unstructured "try it and tell me what you think" produces weak,
generic feedback. Typically: (1) a real setup session, timed, noting where they got stuck;
(2) real usage over a meaningful period (long enough for the core value to actually show
up — a single short session rarely tests this); (3) specific scenarios/edge cases to try
that map to the highest-risk items in 08-mvp-definition.md /
09-readiness-testing-plan.md; (4) checkpoints at more than one point in time (early for
onboarding friction, later for whether they trust/return to the core value), not just a
final debrief. -->

## Collecting feedback

<!-- Keep it low-friction for both sides at this scale — a short form or a shared
thread is enough. Ask about: setup friction, whether they trusted/valued the core output,
any moment they wanted something the product didn't support, informal pricing signal
(asked before showing the actual price), and bugs — kept separate from qualitative
questions so bugs don't crowd out harder-to-articulate UX feedback. -->

## Distribution mechanics

<!-- Name the actual pre-release distribution mechanism for this platform (TestFlight +
Play Internal Testing for mobile; a private beta list/invite code for web/SaaS, etc.) —
prefer whatever also doubles as a dry run of the real submission/deployment process. -->

## Timeline

<!-- Run after the MVP is functionally complete (08-mvp-definition.md), for long enough to
get real repeated usage, ending with enough runway before the public launch window in
MASTER_PLAN.md to act on what's learned. -->

## Turning beta testers into launch assets

<!-- Ask upfront (not as a surprise later) whether testers would leave a public review on
launch day, and whether a positive quote could be used as a testimonial with explicit
consent. If any niche-fit testers had a strong positive reaction, ask if they'd refer
someone else in the same situation — a warm referral converts better than a cold post. -->

## Feeding results back into the rest of the plan

<!-- Explicit trigger conditions: if niche-fit testers still find the core friction point
too heavy, revisit 01 before public launch, not after. If free-tier/paywall boundaries feel
wrong, adjust 03. Treat any correctness bugs found here as launch blockers per
05-launch-readiness-checklist.md, not backlog items. -->
