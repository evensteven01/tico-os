---
name: graduate-idea
description: Use when an idea in proj-incubator has a Go decision and the user wants to start building it ("graduate <idea>", "start the project for <idea>", "this idea is a go, set it up") — asks which code repos to create, runs new-project-setup with the idea spec's answers carried over, puts the app on the Fordsoft Development board, and links the Hub card, repos, project docs and spec to each other.
---

# Graduate Idea

Turns a **Go** idea spec into a real project. The heavy lifting is the existing
`new-project-setup` skill and the shared
[connect-project procedure](${CLAUDE_PLUGIN_ROOT}/procedures/connect-project.md); this
skill's job is making sure the spec's answers flow into them instead of being re-asked.

## Preconditions

Read `ideas/<slug>.md` from the incubator (`$TICO_INCUBATOR_DIR`, default
`~/Development/proj-incubator`). Its Decision must be **Go** and Phase 3 filled in. If not,
stop and point to `/tico-os:evaluate-idea`. Its **Hub card** field gives the `[Idea]` issue.

## Steps

1. **Confirm the basics** with the user: the app slug (used for the `project-docs` folder,
   the App option and the board view), the display name (a working name is fine if the real
   one isn't locked) and the platform (mobile / web / both).
2. **Decide the repos, one at a time.** For each candidate, recommend whether it's needed
   **now** and suggest a name, then ask the user to confirm, rename or skip it:
   - main code repo, needed now: `<slug>-mobile` for mobile, `<slug>-web` for web. This
     repo holds every issue for the app, go-to-market ones included.
   - `<slug>-landing`: usually not yet. It's needed once the beta needs recruits beyond the
     personal network (`new-project-setup` step 8).
   - `<slug>-backend`: only if a Non-Goal that needs a server has been lifted for v1.
     Otherwise skip it, or reserve the name with the backend placeholder if the user wants.

   Create only the confirmed repos, and ask before each one (it's a GitHub write). Clone
   them into `~/Development/`.
3. **Run `new-project-setup`**, using the spec as the answers to its "gather context" step
   and the mapping table in the playbook's "Graduating an idea" section (read it from
   `playbooks/app-evaluation-playbook.md`) to pre-fill:
   - SPEC.md §1/§2/§4/§5/§6–7 from the pitch, core loop, MVP features, Non-Goals and build
     phases, stack and costs.
   - `go-to-market/01` (niche, competitive map), `03` (monetization), `06` (revenue math)
     from Phase 3. The idea has a real concept, so step 5 of `new-project-setup` applies.
   - The code repo `PERSONA.md`'s open risk items from the technical risk table.

   Carry content over, rewritten for its new home, not just links back to the spec.
4. **Connect the project**: follow `procedures/connect-project.md` with Hub stage
   `In Development`. It retitles the `[Idea]` issue to `[App]`, rewrites its body with the
   links, adds the app to the work board, and adds the README, project-docs and spec links.
5. **File the launch work.** Turn each item of the new `go-to-market/05` checklist into an
   issue on the main repo, in the `v1.0 Launch` milestone (`[GTM]` prefix and
   `go-to-market` label for business and launch work), and add each to the board with
   `board.sh --board dev add <url> --app <slug>`. Show the list before creating it.
6. Every repo touched gets its own branch + commit + push; ask before opening each PR.
7. Remind the user: the spec is now history and the project docs are the source of truth.
   The Hub card moves to **Beta** when testers have the app and to **Live / Launched** when
   it ships (then fill the card's Launched date and close the issue). `/tico-os:launch-retro`
   is due about 30 and 90 days after launch.
