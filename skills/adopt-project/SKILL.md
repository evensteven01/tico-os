---
name: adopt-project
description: Use when an app that didn't come through proj-incubator should join the portfolio system ("adopt <project>", "bring <app> onto the boards", "backfill <project>", "connect <repo> to the hub") — creates its Hub card at the right stage, puts its issues on the Fordsoft Development board, links repos and project docs, and reports what's missing from its docs.
---

# Adopt Project

Brings an existing project into the system without pretending it went through the
incubator. It reuses the shared
[connect-project procedure](${CLAUDE_PLUGIN_ROOT}/procedures/connect-project.md), the same
wiring `graduate-idea` does, and then checks the project's docs against the structure
`new-project-setup` would have created. It **reports** gaps; it doesn't fill them unless
asked.

## Steps

1. **Find the project.** Ask for, or discover, the repos (`gh repo list evensteven01`),
   which one is the main code repo, and whether a `project-docs/<slug>/` folder exists.
   Clone anything not already in `~/Development/`.
2. **Read before deciding.** Read the code repo(s) (README, PERSONA/AGENTS if present,
   recent commits, open issues, milestones) and any project docs. Work out the stage from
   the evidence, not from what the docs claim:
   - **In Development**: being built; no testers yet.
   - **Beta**: testers have it (a TestFlight/APK build, a beta program running).
   - **Live / Launched**: publicly available.
   - **Sunset** / **Archived**: being wound down / finished.

   Propose the stage with the evidence for it; the user confirms. Also confirm the app slug
   and display name.

   **Never built?** If there's no working code (an empty or hello-world repo, issues that
   are only research notes), it's an idea, not an app: don't connect it. Propose capturing
   it as an `[Idea]` issue in the Hub's **Inbox**, as `new-idea` quick mode does, with a
   short summary and links to the repo and its most useful research issues. Then stop here
   (skip steps 3–6). Its old issues stay in its repo as research notes; leave them off
   Fordsoft Development, close any that are already done, and close any old per-project
   board. Optionally add a README line in the repo pointing to the new card. The Phase 1
   interview (`new-idea` on the card) comes later, when the user wants to evaluate it.
3. **Check for an existing card.** `board.sh list` (Hub) and
   `board.sh --board dev list --app <slug>`: don't create a second Hub card, and note any
   of its issues already on the work board.
4. **Connect the project**: follow `procedures/connect-project.md` with the confirmed
   stage. Adoption creates the `[App] <name>` issue in `proj-incubator` (step 1 of the
   procedure). In step 2, show the dry-run list and ask about issues that don't belong to
   this app: business tasks shared across apps belong under App = `Shared`, and stray or
   finished items may be better closed.
5. **Docs gap report.** Compare what exists with what `new-project-setup` produces, and
   list each item as present / partial / missing, with one line on what's missing:
   - `project-docs/<slug>/SPEC.md`, `TICKETS.md` (conventions version), `go-to-market/`
     (01–09 for its platform, MASTER_PLAN, PERSONA)
   - code repo `PERSONA.md`, `AGENTS.md` + `CLAUDE.md`, CI workflow
   - labels and the `v1.0 Launch`, `v1.1` and `Later` milestones (step 4 fixed these if
     missing)
   - **Old ticket lists:** if `TICKETS.md` or `GTM_TICKETS.md` still hold ticket rows,
     propose replacing them with the conventions version. First rescue anything that
     isn't already on the issues (decisions, groupings, "decide v1 or later" notes) into
     issue comments, or into the `v1.1` / `Later` milestones for "decided: after v1"
     notes, and show what will be rescued.
   - **Launch checklist vs. milestone:** every `go-to-market/05` item should be an issue
     in `v1.0 Launch`; list the ones that aren't.

   Offer to fix each gap, one at a time; the user picks.
6. **Optional retroactive idea spec.** Ask whether to write `ideas/<slug>.md` as a
   historical record (pitch, audience, MVP, Non-Goals, competitors and revenue scenarios
   taken from the existing docs, Decision = Go, marked "retroactive"). Without one,
   `launch-retro` still works but compares against the project's own
   `06-revenue-projections.md` instead of Phase 3 scenarios.
7. Every repo touched gets its own branch + commit + push; ask before opening each PR.
   Finish with what changed, the PRs to open, and the gaps still open.
