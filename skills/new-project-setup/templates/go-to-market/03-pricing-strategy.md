# Pricing Strategy

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md).

## Constraint that should drive this decision: what does the current build phase actually cost to run?

<!-- Check SPEC.md §5/§6/§7: does the current phase have real recurring infrastructure
cost (a server, a third-party API bill, storage), or is it fully local/static with zero
marginal cost per user? This single fact determines whether a subscription is justified
now or is premature — a subscription model for a product with no recurring cost to cover
invites "why am I paying monthly for this" reviews; a one-time purchase or freemium model
for a product with real hosting costs will eventually not cover them. Name which situation
this project is actually in before picking a model, and name the trigger point (a future
build phase, per SPEC.md §5) that would change the answer. -->

## Recommended model

<!-- State the model plainly: one-time purchase, freemium with IAP unlock, subscription,
ad-supported, pay-what-you-want, etc. — and justify it against the constraint above and
the niche in 01, not against what's fashionable. Split into "now" (current build phase) and
"later" (if a future phase changes the cost/value structure) sections if relevant, the way
a local-only product might add an optional subscription only once sync/server costs exist.
If there's an existing early-adopter/free-tier cohort by the time a pricing model changes,
address explicitly whether they're grandfathered — breaking that promise is a fast way to
burn a loyal early user base. -->

### Now

### Later (if a future build phase changes the cost/value structure)

## Alternative models considered and rejected (for now)

| Model | Why not, for this product at this stage |
|---|---|
<!-- 3-5 rows: full subscription, free+ads, tip-jar-only, paid-upfront-no-free-tier, etc.,
each with the specific reason it doesn't fit *this* niche/cost-structure/stage — not a
generic pros/cons list. -->

## Regional/promotional pricing

<!-- Standard store price-tier localization is usually sufficient. Consider a launch-week
discount as a low-risk lever, especially for a one-time-purchase model with no subscriber
cohort to confuse. -->

## What to decide before launch readiness work starts

<!-- Bullet list: exact price point within a stated range, exact free-tier
limits/gates (what's free forever vs. what's paywalled — bias toward not gating the
everyday core utility, only gating power/convenience features), whether to run a
launch-week discount. -->
