# Procedure: connect a project

Shared by `graduate-idea` (a Go idea becoming a project) and `adopt-project` (an existing
project joining the system). It wires one app into both boards and links every place that
describes it. It's written once here so the two skills can't drift apart.

Run the steps in order. Show the user what each write will do before doing it, and ask
before anything on GitHub. Every file change in a repo goes on a branch + PR (house rule).

## Inputs

| Input | Example | Notes |
|---|---|---|
| **App slug** | `budget-app` | Lower-case kebab. Used for the App option, the board view, the `project-docs` folder. |
| **Display name** | Budget App | Working name if the real one isn't locked. |
| **Hub card issue** | `proj-incubator#3` | Graduation: the idea's `[Idea]` issue. Adoption: created in step 1. |
| **Hub stage** | `In Development` | Graduation is always `In Development`. Adoption: whatever the user confirms. |
| **Code repos** | `budget-app-mobile` (main), `budget-app-landing` | The **main** repo holds every issue for the app, go-to-market ones included. |
| **Docs folder** | `project-docs/budget-app/` | One folder per project in the shared `project-docs` repo. |
| **Idea spec** | `proj-incubator/ideas/budget-app.md` | Graduation only (or a retroactive one, if the user wants it). |

Board tools: `${CLAUDE_PLUGIN_ROOT}/scripts/board.sh` and
`${CLAUDE_PLUGIN_ROOT}/skills/new-project-setup/templates/scaffolding/github/setup-github.sh`.

## 1. Hub card

One card per app, for its whole life.

- **Graduation:** retitle the `[Idea] <name>` issue to `[App] <name>`. Keep the same issue:
  its history is the app's history.
- **Adoption:** create an issue in `evensteven01/proj-incubator` titled `[App] <name>`, then
  `board.sh add <issue-url> --status "<stage>"`.
- Set Priority if the user gives one: `board.sh set <issue-url> Priority P0|P1|P2`.
- Replace the issue body with the block below. Fill each line or delete it; never leave a
  placeholder.

  ```markdown
  **<Display name>**: <one-sentence value proposition>

  | | |
  |---|---|
  | Project docs | [project-docs/<slug>](https://github.com/evensteven01/project-docs/tree/main/<slug>) |
  | Code | [<main-repo>](https://github.com/evensteven01/<main-repo>) (main) · [<other-repo>](…) |
  | Work board | [Fordsoft Development → <slug>](<view-url>) |
  | Launch milestone | [v1.0 Launch](https://github.com/evensteven01/<main-repo>/milestone/<n>) |
  | Origin | [ideas/<slug>.md](https://github.com/evensteven01/proj-incubator/blob/main/ideas/<slug>.md) (or "Adopted <date>; not incubated") |
  | Launched | — |

  Close this issue when the app reaches **Live / Launched**; the card stays on the board.
  ```

  `Launched` gets the launch date when the app goes live; `launch-retro` and `portfolio`
  count from it.

## 2. Work board

1. `board.sh --board dev app-add <slug>`: creates the App option and a board view filtered
   to this app (both idempotent). Record the view URL it prints; it goes in steps 1, 3 and 4.
2. For **each** code repo, preview first, then run:

   ```bash
   setup-github.sh evensteven01/<repo> --app <slug> --dry-run
   setup-github.sh evensteven01/<repo> --app <slug>
   ```

   This creates the labels and the `v1.0 Launch` milestone if missing, links the repo to
   the board (so it shows in the repo's Projects tab), and puts every issue on the board
   with App set. Issues already on the board keep their Status. Show the user the dry-run
   list and ask about anything that looks wrong for this app (e.g. a business task that
   belongs under App = `Shared`, or a stray issue that should be closed instead).
3. New issues opened by hand later won't join the board automatically: the free plan
   allows one auto-add rule per board. Skills that create issues add them with
   `board.sh --board dev add <url> --app <slug>`. Sub-issues of an epic already on the board
   are added automatically by the board's "Auto-add sub-issues" workflow.

## 3. Code repo READMEs

In **each** code repo, add this near the top of `README.md` (create the README if there
isn't one), on a branch + PR:

```markdown
**Project docs:** [project-docs/<slug>](https://github.com/evensteven01/project-docs/tree/main/<slug>) · **Board:** [Fordsoft Development → <slug>](<view-url>)
```

Also make sure the repo's `PERSONA.md` "Where things live" names the board view and says
that GitHub issues on the board are the list of work (see `new-project-setup` templates).

## 4. Project docs

In `project-docs/<slug>/`, on a branch + PR:

- `SPEC.md`: near the top, `Origin:` (the idea spec link, or "Adopted <date>") and
  `Board:` (the view URL).
- `TICKETS.md`: the conventions version from `new-project-setup/templates/TICKETS.md`,
  with the view URL filled in. No ticket list: the board holds the tickets.
- `go-to-market/PERSONA.md`: "Where things live" names the board view.
- `project-docs/README.md`: the project is in its project list.

## 5. Idea spec (graduation only)

In `proj-incubator/ideas/<slug>.md`, on a branch + PR: fill **Graduated to** (project docs
and main repo links) and add a Decision log row. From here the project docs are the source
of truth; the spec is history.

## 6. Check

- `board.sh get <hub-issue-url>` shows the stage, and the issue body has no placeholders.
- `board.sh --board dev list --app <slug>` lists the app's issues; nothing for this app's
  repos appears with App `-` in `board.sh --board dev list`.
- List every branch pushed in steps 3–5 back to the user, and ask before opening each PR
  (house rule).
