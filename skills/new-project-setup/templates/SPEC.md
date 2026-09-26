# {{PROJECT_NAME}} — Vision & Functional Specification

Context document for humans and AI assistants working on this project. This is the source
of truth for *what the product does and why* — read it before making architecture or
feature decisions in any of the repos below. Keep it updated as decisions solidify; it
should never fall out of sync with reality by more than a spec-review cycle. Every table in
this doc (especially §4) is what `go-to-market/08-mvp-definition.md` cross-checks the
shipped app against — a requirement that's real but missing here is a requirement that can
silently ship missing.

## 0. Repos

<!-- One bullet per code repo: name, one-line role, current phase if the project has
phases (e.g. "Phase 1, current" / "Phase 2, deferred"). -->

## 1. Executive Summary

<!-- One paragraph: what this is. If there's an established category of product this
resembles, name the one or two patterns it deliberately does NOT follow and why — the
"not this" is often as clarifying to a reader as the "this," and it's the seed of the
positioning work in go-to-market/01-positioning-and-niche.md. -->

## 2. Core Philosophy & Design Principles

<!-- The 2-4 mechanics that make this product's approach genuinely different from
alternatives — not a feature list, the *reasoning* behind the core mechanics. One
subsection (§2.1, §2.2, ...) per mechanic. If there's a core formula/algorithm, write it
out explicitly (pseudocode or math), the way a reader could verify an implementation
against it. -->

## 3. Domain Data Model

<!-- The core entities, as a JSON-schema-shaped block: field names, types, enums,
relationships (foreign keys / optional attribution / nullability and what null means).
This is the thing an engineering session greps against to check "does the current code
match what's documented," so keep it literal and current, not aspirational. -->

## 4. Functional Requirements

<!-- A table: Category | Requirement | Description. Exhaustive, not illustrative — every
row here is a thing that must exist somewhere in the shipped product, and the MVP
definition doc treats a requirement's absence from the ticket backlog as a flagged gap to
resolve deliberately, not a thing to silently drop. -->

Also in scope, from the app-level feature list:
<!-- Bullet list of user-facing views/screens/flows, one line each. -->

## 5. Build Phases

<!-- What ships now vs. later, and *why* later phases are deliberately deferred by the
project's own architecture rather than just unstarted work. This section is what the
"don't scope-creep" principle in both persona files points back to — be explicit about
what's out of Phase 1 and why, so cheap/fast development doesn't become an excuse to pull
a later phase forward without a deliberate decision. -->

## 6. Architecture & Tech Stack

<!-- Backend, persistence, frontend, protocol — whichever apply. Name the actual
technology choices, not categories, so both personas can verify code against this section
directly. -->

## 7. Guiding Constraints

<!-- The non-negotiables that shape every other decision: complexity/scale budget (e.g.
"personal/micro-SaaS, optimize for low maintenance over scalability"), privacy/security
stance, and anything else a contributor should treat as a constraint rather than a
preference. This is the section both the Coder/Reviewer persona and the GTM Advisor
persona point back to when flagging scope creep. -->
