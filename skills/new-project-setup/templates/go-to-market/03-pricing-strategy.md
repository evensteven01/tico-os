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

<!-- State the model plainly: one-time purchase, freemium with a paid unlock, subscription,
ad-supported, pay-what-you-want, etc. — and justify it against the constraint above and
the niche in 01, not against what's fashionable. Split into "now" (current build phase) and
"later" (if a future phase changes the cost/value structure) sections if relevant, the way
a local-only product might add an optional subscription only once sync/server costs exist.
If there's an existing early-adopter/free-tier cohort by the time a pricing model changes,
address explicitly whether they're grandfathered — breaking that promise is a fast way to
burn a loyal early user base. -->

### Now

<!-- Start with the gating principle, then the tier split. -->

**Gating principle:** <!-- One sentence naming what must never be gated, derived from the
product's core promise in SPEC.md §1. Pattern: "never gate anything that would make the core
[number/output/result] incomplete or inaccurate for an ordinary user." A cap that forces
someone to leave out real data doesn't make the free tier "less powerful," it makes the core
result wrong — a trust failure in the product's own core mechanic. Every paid gate below
must sit outside this boundary. -->

**Free, unlimited:**
<!-- Bullets, each with its *why*. Typical never-gate candidates: anything feeding the core
result; onboarding/activation; and any data-safety/trust feature (backup, export) — charging
to prevent data loss turns a trust feature into leverage, which damages exactly the
privacy/control-minded segment a niche product often targets. -->

**Paid unlock — ranked by expected conversion:**

| Feature | Expected conversion | Why |
|---|---|---|
<!-- One row per gated feature. Best gates extend the exact thing that hooked the user ("let
me see further / do more of what I already love") rather than withholding the basics. -->

<!-- Note explicitly: being a paid-tier feature doesn't change whether something ships for
v1 — pricing only decides whether *access* to a built feature requires the unlock. Mirror
the split onto tickets with `paid-tier` / `subscription-tier` labels and TICKETS.md's Tier
column. -->

**Price point:** <!-- the exact number and why that number (comparable products, how much
the free tier already gives away), plus any launch discount with an explicit end date. -->

### Later (if a future build phase changes the cost/value structure)

<!-- If a later phase adds recurring cost (sync, hosting, an API bill), decide *now* what
early one-time buyers get when it ships — e.g. a "founder" promise that they keep everything
and get the new tier free. Stating it at purchase time removes "will I have to pay again"
hesitation and avoids a bait-and-switch story later. Price any new tier against the marginal
cost of the new feature, and prefer adding a tier over converting the whole product. -->

## Alternative models considered and rejected (for now)

| Model | Why not, for this product at this stage |
|---|---|
<!-- 3-5 rows: full subscription, free+ads, tip-jar-only, paid-upfront-no-free-tier, etc.,
each with the specific reason it doesn't fit *this* niche/cost-structure/stage — not a
generic pros/cons list. -->

## Regional/promotional pricing

<!-- Payment mechanism: see platforms/<platform>/PLATFORM.md §03. Standard store/processor price localization is usually sufficient. Consider a launch-week
discount as a low-risk lever, especially for a one-time-purchase model with no subscriber
cohort to confuse. -->

## What to decide before launch readiness work starts

<!-- Bullet list: exact price point within a stated range, exact free-tier
limits/gates (what's free forever vs. what's paywalled — bias toward not gating the
everyday core utility, only gating power/convenience features), whether to run a
launch-week discount. -->
