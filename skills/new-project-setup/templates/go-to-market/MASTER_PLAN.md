# Go-To-Market Master Plan — {{PRODUCT_NAME}}

Source of truth for taking `{{CODE_REPO_NAME}}` from "in development" to "launched and
making money." This doc indexes and sequences the other docs in this folder — for a
shorter, denser starting point once real content exists, see `PERSONA.md` instead. Keep
both in sync with reality the same way `SPEC.md` is — update them when a decision
solidifies, don't let either drift into aspirational fiction.

This plan is written against the product as it actually is today per
`{{PROJECT_DIR}}/SPEC.md` and `{{PROJECT_DIR}}/TICKETS.md`:

<!-- 2-4 bullets: current phase/architecture in one line, what core loop is built vs. open,
what's genuinely not started yet (no store listing, no pricing, no name locked, etc.). -->

Everything below is written for <!-- the actual resourcing reality: solo indie dev with no
marketing budget? small team? funded? Calibrate every tactic/expectation in this folder to
this, explicitly. -->

## Working assumption: <!-- name the actual cost/resource asymmetry that shapes this plan -->

<!-- If dev is cheap/fast relative to distribution (e.g. AI-assisted, or a strong existing
team) state that explicitly and draw the consequence: no leniency on launch-readiness
quality, because the "ship rough, fix later" tradeoff assumed dev was the scarce resource.
If instead dev IS the bottleneck here, say that instead and adjust downstream docs'
expectations accordingly — don't copy the budget-app assumption uncritically. Either way,
be explicit that this working assumption does NOT license scope creep beyond what SPEC.md's
current build phase defines. -->

## Companion docs

| Doc | Answers |
|---|---|
| [01-positioning-and-niche.md](01-positioning-and-niche.md) | Who is this for, and why would *they specifically* care? |
| [02-app-store-listing.md](02-app-store-listing.md) | How do we describe it so a stranger stops and taps/clicks? |
| [03-pricing-strategy.md](03-pricing-strategy.md) | What do we charge, and why that model? |
| [04-marketing-and-acquisition.md](04-marketing-and-acquisition.md) | How do people actually find it? |
| [05-launch-readiness-checklist.md](05-launch-readiness-checklist.md) | How do we know it's ready, and what has to happen before we ship? |
| [06-revenue-projections.md](06-revenue-projections.md) | What can this realistically make — in dollars, not vibes? |
| [07-beta-testing-program.md](07-beta-testing-program.md) | How do we use a small trusted group to de-risk launch before it's public? |
| [08-mvp-definition.md](08-mvp-definition.md) | Exactly what feature set ships in v1? |
| [09-readiness-testing-plan.md](09-readiness-testing-plan.md) | How is each MVP item actually verified? |
| [GTM_TICKETS.md](GTM_TICKETS.md) | Point-in-time index of the actual `[GTM]`-labeled GitHub issues |

## The core strategic bet

<!-- One sentence: the entire differentiation this product is betting on. Everything else
in this folder should reinforce this sentence, not dilute it by trying to compete
feature-for-feature with incumbents. State the corollary too, if the differentiator also
creates real friction (a common pattern: the thing that makes it different is also the
thing a first-time user might resist) — name that tradeoff honestly rather than ignoring it. -->

## Phased roadmap

<!-- Adapt phase count/order to the actual project, but keep the separation between
"finish the product" (engineering), "decide the business" (positioning/pricing/listing),
"get launch-ready" (operational checklist + beta), "launch," "post-launch growth," and any
later monetization-expansion phase tied to a future build phase. Each phase should name
what doc(s) it depends on and what "done" means for that phase — not just a label. -->

### Phase A — Finish the MVP (dev work, not GTM)

### Phase B — Decide the business

### Phase C — Get launch-ready (checklist-driven)

### Phase D — Launch

### Phase E — Post-launch growth loop

### Phase F — Later monetization expansion (if the project has a deferred later phase with new cost/value structure)

## Ticket labeling convention

Go-to-market tickets carry a **`[GTM]`** title prefix and a `go-to-market` GitHub label on
`{{CODE_REPO_NAME}}`, so they're visually and filterably distinct from plain numbered dev
tickets in `{{PROJECT_DIR}}/TICKETS.md`. They're tracked in [GTM_TICKETS.md](GTM_TICKETS.md)
in this folder, mirroring TICKETS.md's format, rather than interleaved into the dev ticket
list — both index the same repo's issues, just partitioned by kind. Product/engineering
gaps discovered *during* GTM planning stay plain numbered dev tickets in TICKETS.md, not
`[GTM]` ones — the prefix is for marketing/business/launch-operations work, not engineering
work that GTM planning happened to surface.

## Open decisions that need input

<!-- Bullet list, called out inline in the relevant docs too but flagged here so nothing is
missed. Typically: final product name, exact price point, available marketing time/budget.
Remove/replace items as they get resolved — don't let this list silently go stale. -->
