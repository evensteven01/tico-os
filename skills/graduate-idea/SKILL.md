---
name: graduate-idea
description: Use when an idea in proj-incubator has a Go decision and the user wants to start building it ("graduate <idea>", "start the project for <idea>", "this idea is a go, set it up") — creates the code repo and project docs via new-project-setup, carrying the idea spec's answers over, and links everything back.
---

# Graduate Idea

Turns a **Go** idea spec into a real project. The heavy lifting is the existing
`new-project-setup` skill; this skill's job is making sure the spec's answers flow into it
instead of being re-asked, and that the incubator, the board and the new docs all point at
each other.

## Preconditions

Read `ideas/<slug>.md` from the incubator (`$TICO_INCUBATOR_DIR`, default
`~/Development/proj-incubator`). Its Decision must be **Go** and Phase 3 filled in. If not,
stop and point to `/tico-os:evaluate-idea`.

## Steps

1. **Confirm the basics** with the user: project directory name in `project-docs`, code
   repo name(s) (convention: `<project>-mobile`, `<project>-backend`, `<project>-landing`),
   platform (mobile / web / both), and a codename if the product name isn't locked.
2. **Create the code repo(s)** — ask before creating anything on GitHub. Clone into
   `~/Development/`.
3. **Run `new-project-setup`**, using the spec as the answers to its "gather context" step
   and the mapping table in the playbook's "Graduating an idea" section (read it from
   `playbooks/app-evaluation-playbook.md`) to pre-fill:
   - SPEC.md §1/§2/§4/§5/§6–7 from the pitch, core loop, MVP features, Non-Goals and build
     phases, stack and costs.
   - `go-to-market/01` (niche, competitive map), `03` (monetization), `06` (revenue math)
     from Phase 3 — the idea has a real concept, so step 5 of `new-project-setup` applies.
   - The code repo `PERSONA.md`'s open risk items from the technical risk table.
   Carry content over, rewritten for its new home — not just links back to the spec.
4. **Link everything**:
   - Spec header: fill **Graduated to** with the project-docs SPEC link and code repo link;
     add a Decision log row.
   - Board: the item stays `In Development`; add the code repo's milestone/issues to the
     same board if the user wants one board for everything.
   - New SPEC.md: one line near the top — "Origin: proj-incubator `ideas/<slug>.md`".
   - `project-docs/README.md`: add the project to its list.
5. Every repo touched gets its own branch + commit + push; ask before opening each PR.
6. Remind the user: the spec is now historical — project docs are the source of truth, and
   the board item moves to `Live / Launched` when the app ships.
