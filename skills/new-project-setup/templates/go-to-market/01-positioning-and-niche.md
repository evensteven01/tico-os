# Positioning & Niche

Parent plan: [MASTER_PLAN.md](MASTER_PLAN.md).

## The mistake this doc exists to prevent

The most common way a side project dies isn't bad code — it's trying to be "a
[category] app for everyone" and getting ignored, because the store already has
established incumbents fighting for that exact phrase. A generic pitch loses to incumbents
with more money and more reviews. A sharp pitch to a specific, underserved group can win
even with zero marketing budget, because that group is actively searching for exactly this
and not finding it.

## What the product actually does differently (from SPEC.md, not aspiration)

<!-- Numbered list, each point grounded in a specific SPEC.md section — not marketing
copy, the actual mechanic. Pull these directly from SPEC §2 (Core Philosophy) and §7
(Guiding Constraints). If a mechanic is also a source of friction (e.g. no
integration/sync where competitors have it), say so here too — it becomes both a filter
and a differentiator, not a hidden weakness. -->

## Recommended niche

<!-- Ranked segments: -->

1. **Primary:** <!-- the segment whose specific, recognizable pain this product's core
   mechanic solves better than any generic alternative. Should be large enough to matter
   but underserved by existing options — the "underserved" part is what makes a
   zero-budget launch viable. -->
2. **Secondary:** <!-- segments actively frustrated with an incumbent's specific failure
   mode — high intent, easy to find (they post about their frustration publicly), smaller
   in absolute numbers but converts well. -->
3. **Secondary:** <!-- any values-driven segment (privacy, ownership, offline-first,
   anti-subscription, etc.) if the architecture genuinely supports it. -->
4. **Explicitly not the target at launch:** <!-- name the segment whose expectations this
   product will NOT meet (e.g. wants full automation, wants what a specific friction-heavy
   feature is deliberately not providing). Filtering them out in the listing prevents bad
   reviews from people who were never going to be happy customers. -->

## One-sentence positioning statement

> <!-- The single sentence every channel reuses verbatim (or near-verbatim): store
> subtitle, screenshots, community posts, launch-day tagline. Consistency compounds; a
> different pitch in every channel doesn't. -->

## Competitive map (internal reference, not listing copy)

| Competitor | Their strength | Their weakness (our opening) |
|---|---|---|
<!-- 3-5 rows. Do not build feature-for-feature comparison marketing against the strongest
incumbent — that invites a fight on their turf instead of the niche's actual pain point. -->

## Naming

<!-- Note the current placeholder name (repo/package name) and what the real name should
telegraph — usually a word tied to the core differentiator or feeling rather than a generic
category word that drowns in search. Until it locks, use an internal codename in
package/app config so the repo placeholder doesn't leak into builds. -->

### Collision rule

A store or search hit isn't automatically disqualifying — what matters is whether the
colliding product sits in the *same or adjacent category*, which creates real
user-confusion and trademark risk, versus an unrelated category, which is basically
harmless no matter how many hits show up. Record the check result for every candidate.

### Candidate shortlist

<!-- Keep every candidate in one of these tables so nothing is re-proposed or re-checked
from scratch. Columns: Name | Why | Collision check. -->

**Live candidates**

| Name | Why | Collision check |
|---|---|---|

**Dropped — same/adjacent-category collision**

| Name | Why it was appealing | Why dropped |
|---|---|---|

**Deprioritized, not disqualified** (no direct collision, but generic, borderline, or hard
to own in search)

| Name | Why | Status |
|---|---|---|

**Being considered — not yet collision-checked**

<!-- Holding area. Promote to Live or Dropped once checked. -->

### Raw word bank

<!-- Uncleaned vocabulary captured while brainstorming, so nothing gets lost while
combining words into candidates: the product's core metaphor(s) in English and other
languages, plus any personal/cultural sources worth drawing on (places, folklore, words
with personal meaning). Not organized, not checked. -->

### Outside feedback

<!-- Reactions from other people (or other AI reviewers) on the live/favorite candidates —
kept separate from collision data, and attributed, so opinions don't masquerade as checks. -->

**Plan:** don't pick from the armchair — run the live candidates by real people once
they've actually used the product (see [07-beta-testing-program.md](07-beta-testing-program.md));
reaction to a name pre-use vs. post-use can differ meaningfully. Once a name is chosen, do a
final, careful store/domain collision pass and a basic trademark search before committing —
the brainstorming checks are quick gut-checks, not a substitute.
