# How the Fordsoft App System Works

This guide explains how app ideas at Fordsoft go from a first thought to a launched
product, and beyond, and how the tools, documents and boards involved fit together. It is
written to be read start to finish by anyone, whether or not they write software. If you
only need a list of commands to type, the [cheatsheet](CHEATSHEET.md) is the quicker
reference, and [INSTALL.md](INSTALL.md) covers setting the tools up. Unfamiliar terms are
defined in the [glossary](#glossary) at the end.

The guide lives in `tico-os` because `tico-os` is what drives the process. The ideas,
playbooks and project documents it works on live in the other places described below.

## Contents

1. [The short version](#the-short-version)
2. [Why the system is built this way](#why-the-system-is-built-this-way)
3. [The five places things live](#the-five-places-things-live)
4. [The life of an app, stage by stage](#the-life-of-an-app-stage-by-stage)
5. [How a decision gets made](#how-a-decision-gets-made)
6. [The two boards](#the-two-boards)
7. [What Claude does, and what it won't do](#what-claude-does-and-what-it-wont-do)
8. [How the system learns](#how-the-system-learns)
9. [A normal working session](#a-normal-working-session)
10. [Changing the system itself](#changing-the-system-itself)
11. [Glossary](#glossary)
12. [Where to read more](#where-to-read-more)

---

## The short version

A new app idea starts as a one-line note in an **Inbox**, so nothing gets lost and nothing
gets an hour of work before it has earned it. When you're ready to take an idea seriously,
it is written up as a single document, called an **idea spec**, and passes through three
short evaluation phases. Each phase asks a harder question than the last, and each ends
with a checkpoint, called a **gate**, that the idea must pass before more time is spent on
it. At the end of the third phase the idea receives one of three decisions: **Go** (build
it), **Park** (not now, but revisit when a named condition is met), or **Kill** (don't build
it, and record why).

An idea that gets a Go **graduates**. It gets its own code repository and its own set of
planning documents for the product, pricing and launch, and from then on it is managed as a
real project. It goes through a **beta** with real testers, **launches**, and is checked
against its own predictions about 30 and 90 days later in a **launch retro**. Those real
numbers feed back into how the next idea is judged. If an app stops being worth running, it
is **sunset** deliberately, with its users looked after, rather than abandoned.

Two online boards keep all of this visible. The **Hub** has one card per app for its whole
life, showing what stage it's at. The **Development** board holds the actual work, every
task for every app, so you can see what's in progress and what's left before a launch.
Claude, working inside VS Code, does most of the clerical work: it interviews you, fills in
documents, researches competitors, keeps both boards up to date and prepares changes for
your review. Every judgment call stays with you.

```
 Inbox ─► Idea Backlog ─► Scoped / Tech Spec ─► In Development ─► Beta ─► Live / Launched ─► Sunset ─► Archived
 a note   pitch passed    scope passed          Go decision       testers  public            retiring   done
          (Phase 1)       (Phase 2)             (Phase 3)
                                                                          launch retro at
 A Kill at any gate goes straight to Archived, with the reason written down.   30 and 90 days
```

## Why the system is built this way

A few beliefs shape every part of the process, and knowing them makes the rest of this
guide easier to follow.

**Building software is no longer the hard part.** With AI-assisted development, almost any
reasonable app can be built by one person in a few weekends. The hard part is getting real
people to find the app, trust it and pay for it. For that reason the evaluation spends much
more effort on the audience, the competition and distribution than on whether something can
be built.

**It is cheaper to kill an idea on paper than in code.** Two hours of honest evaluation
that ends in "no" is a good outcome, because it saves the two months that building the
wrong thing would have cost. The gates exist to make stopping easy and normal.

**Decisions should be written down along with their reasons.** A parked or killed idea
keeps its document forever, including why it was stopped. When the same idea comes up
again a year later, the earlier thinking is already there and does not have to be redone.

**Nothing gets made up to fill a gap.** If a fact is not known, such as a competitor's
price or how many people search for a phrase, the document says `Unknown` and notes how to
find out. A guess written down tends to be treated as a fact later, by people and by Claude
alike.

**Small scope is a feature.** The first version of any app is deliberately limited to a
handful of features, and the evaluation requires a written list of what the app will *not*
do yet. That list is what keeps a quick project from turning into an endless one.

**Predictions should be checked.** Every evaluation guesses how many people will find,
install and pay for an app. The launch retro compares those guesses with what actually
happened, so the guesses get better with each app instead of staying optimistic forever.

## The five places things live

The system keeps information in five places. Each one is the single authority for a
particular kind of information, so it is always clear where to look and where to make a
change.

**1. [`proj-incubator`](https://github.com/evensteven01/proj-incubator): ideas and shared know-how.**
Inbox ideas live here as issues titled `[Idea] <name>`, and evaluated ideas get a spec in
the `ideas/` folder. It also holds the knowledge that applies across all apps: the
[App Evaluation Playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md),
which describes every stage in detail; working procedures in `processes/`, such as the
[ticket conventions](https://github.com/evensteven01/proj-incubator/blob/main/processes/ticket-conventions.md);
and proven technical designs that new apps can reuse in `architecture/`. If you want to
know how Fordsoft decides or does things in general, the answer is here.

**2. The [Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7): one card per app.**
A GitHub Project board with one card for every idea and app, from the moment it's captured
until it's archived, arranged in columns by stage. It answers "where does everything
stand?" in a few seconds. It deliberately holds very little detail: the reasoning lives in
the specs, and the work lives on the next board.

**3. [Fordsoft Development](https://github.com/users/evensteven01/projects/5): the work.**
A second board holding every task (a GitHub issue) for every app, tagged with which app it
belongs to, plus a `Shared` group for work that serves all apps, such as setting up
developer accounts or improving these tools. It answers "what's being worked on, and what's
left before launch?" It has a view for each app, a **Current focus** view and a
**Launch readiness** view.

**4. [`project-docs`](https://github.com/evensteven01/project-docs) and each app's code repositories: everything about one app.**
Once an idea graduates, it gets a folder in the shared `project-docs` repository with the
product specification (`SPEC.md`), the app's ticket conventions (`TICKETS.md`) and a set of
go-to-market documents covering positioning, pricing, store listing, marketing, launch
readiness and revenue projections. The app's code lives in its own repositories, named
after the app: the main one (such as `budget-app-mobile`) holds all of the app's issues,
and smaller ones (such as a `-landing` beta page) exist only when needed. Each code
repository has a `PERSONA.md` file that records the technical decisions already made and
the known risks, so that anyone working on it, human or Claude, starts from the same
understanding.

**5. `tico-os` (this repository): the automation that drives everything.**
`tico-os` is a plugin for Claude Code, the AI assistant that runs inside VS Code. It teaches
Claude the steps of this process, such as how to capture and evaluate an idea, how to set
up a new project and connect it to both boards, and how to run a launch retro. It also
holds the templates new projects start from and the scripts that update the boards. It
contains automation only, never the content itself. When Claude evaluates an idea, it reads
the playbook from `proj-incubator` at that moment instead of keeping its own copy, so an
improvement to the playbook takes effect the next time anyone uses it.

| If you want to know… | Look in |
|---|---|
| How ideas are evaluated, and how apps launch and retire, in general | `proj-incubator/playbooks/` |
| What we concluded about one specific idea | `proj-incubator/ideas/<idea>.md` |
| What stage every idea and app is at | The Fordsoft Project Hub |
| What's being worked on, and what's left before a launch | Fordsoft Development |
| One app's product spec and launch plan | `project-docs/<app>/` |
| Technical decisions and risks for one app | That app's main code repo, `PERSONA.md` |
| How the automation behaves | `tico-os` |

## The life of an app, stage by stage

This section follows a single app through the whole process. For each stage it explains
what happens, who does what and what exists afterward. The stages correspond directly to
the [playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md),
which has the full checklists.

### Stage 0: Capture (seconds)

Ideas arrive at inconvenient times. When one does, tell Claude to jot it down, or type
`/tico-os:new-idea --quick "calorie tracker"`. Claude checks that it isn't a duplicate,
creates an `[Idea]` issue in `proj-incubator` with your one line and the date, and puts its
card in the Hub's **Inbox**. There's no interview and no document yet.

The Inbox is a holding pen, not a commitment. Look through it now and then: start Stage 1
on an idea that still seems interesting, or close it with a one-line reason. Claude
mentions the Inbox when you start a session in `proj-incubator`, and the portfolio report
flags ideas that have sat there for a couple of months.

### Stage 1: The pitch (about 30 to 60 minutes)

The question for this stage is simple: **is there a specific group of people with a
specific, real problem?**

You run `/tico-os:new-idea`, either on an Inbox card or on a brand-new idea. Claude first
checks whether a similar idea has already been evaluated. If one has, Claude shows you what
was decided and why, so you can choose whether this is a fresh angle or a revisit.

Claude then interviews you a few questions at a time. It asks what the idea is, who it is
for, and where those people can be found online. It asks what problem they have, described
the way they would describe it, and what evidence shows the problem is real, such as forum
posts or complaints in competitors' reviews. It also asks what people do about the problem
today and how often it bothers them. From your answers, Claude drafts a one-sentence value
proposition, which is a plain statement of who the app is for and why it is better than the
alternative. You correct the draft until it is right.

Claude then spends about ten minutes searching the web and app stores to make sure the
problem is not already solved by a free, excellent, well-reviewed product. This is a quick
check, not the full competitor analysis, which comes in Stage 3.

Finally Claude checks the idea against the first gate. The audience must be findable, the
problem must have real evidence behind it, the pitch must fit in one sentence, and the
quick search must not have turned up a dominant free competitor. If the idea fails, that is
recorded honestly as Park or Kill, with the reason. The answers are never stretched to
force a pass.

**What exists afterward:** an idea spec in `ideas/`, and the idea's card in the Hub's
**Idea Backlog** column. The spec is prepared as a change for you to review (see
[pull requests](#glossary)) rather than saved directly.

### Stage 2: The scope (about 1 to 3 hours)

The question for this stage is: **what is the smallest version worth shipping, and what
would it take to build?**

You run `/tico-os:evaluate-idea <idea>`. Claude reads the spec, confirms the first gate was
passed and works through scoping with you.

First comes the **core loop**, which is the one action-and-reward cycle the app exists for,
stated in a single line. An example is "enter what's coming in, then see what's safe to
spend." Next, Claude proposes the list of features for the first version and you cut or
add. The limit is seven features, and each one must be essential to the pitch. Claude then
proposes a list of **non-goals**, the things the first version will deliberately not do,
each with a reason. At least three are required. This list is often the most valuable part
of the whole spec.

Claude also recommends a technology stack. Unless there is a written reason to do
otherwise, it uses the technologies already proven in other Fordsoft apps, because every
new technology adds ongoing maintenance. It estimates the monthly running cost both with no
users and with a thousand users, and gives a rough effort estimate.

If the second gate passes, the card moves to **Scoped / Tech Spec**, and Claude asks you to
set a priority: P0, P1 or P2. The priority decides which scoped idea gets evaluated next.

### Stage 3: The market, the money and the decision (about 2 to 4 hours)

The question for this stage is: **can this win attention and make enough money to be worth
building?**

You run `/tico-os:evaluate-idea <idea>` again, and Claude picks up at the third phase. This
is the most involved stage, and it uses two helper assistants (see [agents](#glossary)) so
that their research does not clutter your conversation.

1. **Competitor research.** A research assistant searches the app stores and the web as
   they are today and returns a table of three to six competitors. The table covers each
   competitor's price, rating, strengths and the specific places where it fails the target
   audience, with a source link and date for every claim. Anything it could not verify is
   listed separately, so a missing fact is never mistaken for a negative finding. You and
   Claude then write down the gap no competitor fills, why now is the right time, and what
   trade-off the app's main difference brings with it.
2. **Technical risks.** Claude lists what could go wrong technically, such as app store
   rules for the category, data loss if a phone is replaced, or reliance on an outside
   service. Each risk is rated for likelihood and impact. Any risk that is high on both
   must be tested with a short experiment before the idea can get a Go.
3. **Monetization.** The app's cost structure points to a pricing model. An app with no
   running costs usually suits a one-time purchase, while an app with real monthly costs
   needs a subscription. You also decide what must always stay free, because charging for
   it would undermine the app's core promise.
4. **Revenue math.** Claude works through a simple funnel: how many people see the app,
   how many install it, how many keep using it and how many pay. It does this for three
   scenarios: slow, steady and breakout. The arithmetic is shown and assumptions are
   labelled as assumptions. The plan should work in the slow scenario. An idea that only
   makes sense if it takes off is a warning sign.
5. **Distribution.** Claude asks where the first hundred users will come from, and expects
   specific answers such as named communities, a personal network or a particular search
   phrase. "Social media" is not accepted as an answer.
6. **The case against.** A second assistant, the critic, reads the finished spec and makes
   the strongest honest argument against building the app. It names the weakest claims and
   the cheapest test that would change its mind. You see these objections before any
   scoring happens.
7. **The decision.** Claude proposes a score for each criterion, you adjust the scores and
   you make the call. The scoring is explained in
   [How a decision gets made](#how-a-decision-gets-made).

**What exists afterward:** a complete spec with a dated decision and its reasoning. The
card moves to **In Development** for a Go and to **Archived** for a Kill. A Park stays in
**Idea Backlog** with a written revisit trigger, such as "if a competitor raises prices" or
"in six months."

### Stage 4: Graduate (an hour or two)

When an idea gets a Go, you run `/tico-os:graduate-idea <idea>`. Claude confirms the app's
short name (used everywhere from folder names to the board) and which platform it targets:
mobile, web or both. Then it goes through the code repositories one at a time. For each, it
suggests a name and says whether it's needed now, and you confirm, rename or skip it:

- The **main code repository**, such as `calorie-tracker-mobile`, is always needed. It
  holds the app's code and **all** of its issues, including marketing and launch tasks.
- A **`-landing`** repository for a beta sign-up page usually waits until the beta needs
  testers beyond your own network.
- A **`-backend`** repository waits until the app genuinely needs a server, which is often
  one of its first version's non-goals.

Claude asks before creating anything on GitHub. It then sets up the project, carrying over
the content of the idea spec rather than asking the same questions again. The pitch and
audience become the opening of the product spec and the positioning document. The feature
list and non-goals become the product scope. The competitor table, pricing and revenue math
become the matching go-to-market documents. The technical risks become the open risks in
the code repository's `PERSONA.md`. Claude also sets up automated testing, the labels used
for tracking work, and a **v1.0 Launch** milestone. Every item on the launch-readiness
checklist becomes an issue in that milestone, so "what's left before launch?" always has a
precise answer.

Finally, Claude connects everything, so that from any one place you can reach all the
others:

```
 Fordsoft Project Hub                      Fordsoft Development
 ┌─────────────────────────┐               ┌──────────────────────────────────┐
 │ [App] Calorie Tracker   │── links to ──►│ "calorie-tracker" view           │
 │ (was the [Idea] issue)  │               │ all issues, App = calorie-tracker│
 │ body lists: docs, repos,│               └──────────────────────────────────┘
 │ board view, milestone   │                          ▲ issues come from
 └───────────┬─────────────┘                          │
             │ links to                    ┌──────────┴────────────────────────┐
             ▼                             │ calorie-tracker-mobile (main repo)│
 ┌─────────────────────────┐               │  PERSONA.md, code, all the issues │
 │ project-docs/           │◄── README ────│  README: "Project docs · Board"   │
 │   calorie-tracker/      │    links      ├───────────────────────────────────┤
 │   SPEC.md  (Origin: the │               │ calorie-tracker-landing (later)   │
 │     idea spec)          │               └───────────────────────────────────┘
 │   TICKETS.md, go-to-    │
 │   market/ …             │               proj-incubator/ideas/calorie-tracker.md
 └─────────────────────────┘               "Graduated to" → project docs + repo
```

The Hub card stays the same card it has been since the Inbox: its issue is just retitled
from `[Idea]` to `[App]`, so the app's whole history is in one place. The app gets its own
view on Fordsoft Development. Each code repository's README gets a line linking to the
project docs and the board. From this point, the project documents are the authority, and
the idea spec becomes a historical record.

**A real example.** Fordsoft's first app, budget-app, has exactly this shape:
`project-docs/budget-app/` holds its spec and go-to-market documents, `budget-app-mobile`
is the main code repository with all of its issues, `budget-app-landing` is its beta
sign-up page, and `budget-app-backend` reserves the name for a later phase that will need a
server. budget-app was started before the incubator existed, so it joins through adoption
(below) rather than graduation, but it ends up connected in the same way.

**Apps that skipped the incubator.** An app that already exists, or was started another
way, can join the system with `/tico-os:adopt-project`. Claude reads the code and documents
to work out what stage the app is really at and proposes it for you to confirm. It then
creates its Hub card and connects it exactly as graduation would. Finally it reports what's
missing compared with a graduated project, such as a launch checklist with no matching
issues, and offers to fill each gap with you, one at a time.

If the project turns out never to have been built (an empty repository and a few research
notes, like dig-explorer), it isn't connected as an app at all. It becomes an idea in the
Inbox instead, with links to the old research, and goes through the incubator from the
start whenever you want to evaluate it.

### Stage 5: Build

Building happens in the app's own repositories. The work is tracked as issues on Fordsoft
Development: you move a card to **Ready** when it's next up, to **In progress** when work
starts, and the board moves it to **In review** and **Done** as pull requests open and
merge. The [ticket conventions](https://github.com/evensteven01/proj-incubator/blob/main/processes/ticket-conventions.md)
explain the fields, labels and how to split big pieces of work into an epic with smaller
sub-issues.

Each issue's **milestone** says which release it's for: **v1.0 Launch** (needed before the
first public release), **v1.1** (the first update after launch) or **Later** (decided: not
now, no date). An issue with no milestone hasn't been decided yet, and the portfolio report
lists those so they get a decision. Priority then says how urgent an issue is within its
release, and Status says whether you're working on it now: the **Current focus** view
(Ready and In progress) is the answer to "what do I work on next?".

### Stage 6: Beta and launch

When testers have the app (through TestFlight, a downloadable Android build, or a beta
sign-up page) and the launch milestone is down to launch-day tasks, the Hub card moves to
**Beta**. This is your call; the portfolio report suggests it when the milestone looks
ready. The beta program document in `go-to-market/` describes how testers are recruited
and what feedback is collected.

When the app is publicly available, the card moves to **Live / Launched**. The launch date
goes in the card's issue description, and the issue is closed; the card itself stays on
the board. The launch date is what the launch retro counts from, and the portfolio report
reminds you if it's missing.

### Stage 7: The launch retro (30 and 90 days after launch)

About a month after launch, and again after three months, you run `/tico-os:launch-retro`.
Claude finds the predictions made in Stage 3 and asks you for the real numbers, which come
from the app stores' and payment providers' dashboards: how many people saw the app, how
many installed it, how many kept using it, how many paid, and how much money came in.
Nothing is estimated to fill a gap.

Claude then shows predictions and reality side by side, works out which scenario reality
is closest to and which step of the funnel underperformed most, and asks which parts of the
original scorecard turned out to be misjudged. The results are recorded in the app's
revenue document and in its idea spec. If the real numbers differ meaningfully from the
playbook's assumptions, Claude proposes updating the playbook, so the next idea is judged
against reality instead of guesses. Finally you decide what to do: carry on, change the
marketing, change the price, or consider retiring the app.

### Stage 8: Retiring an app

Not every app should run forever. When one is no longer worth it (the numbers stay far
below even the slow scenario, costs outgrow revenue, or interest has gone), its card moves
to **Sunset** while it's wound down: users are told, the store listing or website is
removed, and users' data stays exportable for a reasonable time. Once that's done, the card
moves to **Archived**, and the reason is written in the project's documents. Ideas that were
killed during evaluation skip Sunset, because they never had users.

## How a decision gets made

The decision at the end of Stage 3 rests on a weighted scorecard. Each criterion is scored
from 1 (poor) to 5 (strong) and multiplied by its weight. The weights reflect the belief
that reaching people matters more than building:

| Criterion | What it asks | Weight |
|---|---|---|
| Pain severity and evidence | How badly do people need this, and how sure are we? | 3 |
| Audience findability | Can we actually reach these people without an ad budget? | 3 |
| Differentiation | Is it clearly different from what already exists? | 2 |
| Revenue potential | Does the money work in the *slow* scenario? | 2 |
| Personal fit | Would you use it, and will you stay interested? | 2 |
| Technical risk | How likely is it to go wrong? (5 means low risk) | 1 |

The highest possible total is 65. As a guideline, 48 or more suggests **Go**, 35 to 47
suggests **Park** and anything under 35 suggests **Kill**. These are guidelines rather than
rules, and you can overrule them as long as the reason is written down. One rule is firm: a
technical risk rated high for both likelihood and impact blocks a Go until a short
experiment has shown it can be handled. Launch retros are how these weights and thresholds
get checked against reality over time.

## The two boards

### The Fordsoft Project Hub

The [Hub](https://github.com/users/evensteven01/projects/7) has exactly one card per idea or
app. Each card is an issue in `proj-incubator`, titled `[Idea] <name>` until the idea
graduates and `[App] <name>` after. It has two fields:

- **Status** is the column the card sits in, from Inbox to Archived. Hovering over a
  column name shows what it means.
- **Priority** is **P0**, **P1** or **P2**, set once an idea has been scoped.

It has two views: **Pipeline**, with a column per stage, and **All apps**, a table.

The Hub and the idea specs must agree. When an idea changes stage, Claude updates both in
the same sitting. If they ever disagree, the spec wins, because it holds the reasoning.

### Fordsoft Development

[Fordsoft Development](https://github.com/users/evensteven01/projects/5) holds every issue
for every app. Each card has:

- **Status**: Backlog, Ready, In progress, In review or Done.
- **App**: which app it belongs to, or **Shared** for work that serves every app.
- **Priority** (P0 to P2) and **Size** (XS to XL).

Its views include one per app, **Current focus** (everything Ready or In progress, across
all apps), **Launch readiness** (everything in each app's v1.0 Launch milestone) and
**v1.1** (the first update after launch). The
board is the only list of work: there are no separate ticket lists in documents to keep in
sync.

### Checking both

`/tico-os:portfolio` reads both boards and every spec, and reports on the whole portfolio:
what stage each app is at, how close each app in development is to launch, and what needs
attention. That includes a spec and card that disagree, a work card with no App, an app
that looks ready for Beta, a launch retro that's due, or an Inbox idea that's been waiting
too long. It only reads, and changes nothing unless you ask it to fix what it found.

## What Claude does, and what it won't do

Claude handles the legwork. It interviews you, fills in documents, runs searches, does the
arithmetic, updates the boards and prepares every change for review. It follows a short set
of standing rules, which load automatically at the start of every session:

- **It never changes the main version of anything directly.** Every change goes on a
  separate branch and becomes a pull request, which you review and approve. Claude also
  asks before opening the pull request itself.
- **It does not make things up.** Unknown facts are marked `Unknown`, together with a note
  on how to find out. Competitor information always comes from a live search with a date
  attached, never from memory, and launch retros use only real numbers.
- **It proposes, and you decide.** Claude suggests features, non-goals, scores, stages and
  recommendations, and pushes back when something breaks the playbook's rules, such as an
  eighth feature. The decisions themselves, especially Go, Park or Kill, are always yours.
- **It asks before acting outside your computer**, such as before creating a new
  repository on GitHub, and shows you what a board update will change before making it.
- **It reviews code on GitHub, not in chat**, so review comments stay attached to the code
  they are about.

## How the system learns

The system is meant to get better with every app, in two ways.

**Shared patterns.** When a project solves a problem in a way other apps could reuse, such
as how it stores data on the phone, how it handles payments or how its automated tests are
set up, that solution can be written up as a shared pattern. Running
`/tico-os:extract-pattern` has Claude read the project's actual code, not a description of
it, and write a document in `architecture/` (for technical design) or `processes/` (for
working procedures). If the pattern changes which technologies Fordsoft uses by default,
Claude also updates the playbook's recommendations, so the next idea's scoping starts from
it automatically.

**Real numbers.** Each launch retro compares an app's predictions with what really
happened, and proposes updates to the playbook's assumed conversion rates and, over time,
its scorecard. After a few apps, the evaluation of a new idea is based on Fordsoft's own
track record rather than generic guesses.

## A normal working session

Everything happens in the Claude Code chat in VS Code. Open whichever repository you are
working in and start a conversation. The standing rules load automatically. If you open
`proj-incubator`, Claude also starts with a short summary of where each evaluated idea
stands and what's waiting in the Inbox.

You do not need to remember command names. Describing what you want ("jot down an idea
for…", "let's scope the calorie tracker", "what should I work on next?") is enough for
Claude to pick the right step. The commands are there for when you want to be precise:

| You want to… | Type |
|---|---|
| Jot down an idea for later | `/tico-os:new-idea --quick "<idea>"` |
| Take an idea through the pitch | `/tico-os:new-idea` |
| Move an idea to its next phase | `/tico-os:evaluate-idea <idea>` |
| Turn a Go idea into a project | `/tico-os:graduate-idea <idea>` |
| Bring an existing app into the system | `/tico-os:adopt-project` |
| See the state of everything | `/tico-os:portfolio` |
| Check a launched app against its predictions | `/tico-os:launch-retro` |
| Write up a reusable pattern | `/tico-os:extract-pattern` |
| Set up project documents without the rest | `/tico-os:new-project-setup` |

Each command that changes a document ends with a pull request waiting for your approval.
The change only becomes part of the main record once you merge it.

## Changing the system itself

Because content and automation are kept apart, most improvements are simple document edits:

- **To change how ideas are evaluated, or how apps launch and retire**, including the
  steps, gates, scorecard weights and default technologies, edit
  [`playbooks/app-evaluation-playbook.md`](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md)
  in `proj-incubator`. The change applies the next time anyone uses it.
- **To change what an idea spec contains**, edit
  [`ideas/TEMPLATE-app-spec.md`](https://github.com/evensteven01/proj-incubator/blob/main/ideas/TEMPLATE-app-spec.md).
  Keep it in step with the playbook, section for section.
- **To change how issues are tracked**, edit the
  [ticket conventions](https://github.com/evensteven01/proj-incubator/blob/main/processes/ticket-conventions.md).
- **To change how Claude behaves**, including its interview style, the standing rules or
  the project templates, edit this repository and raise the version number in
  `.claude-plugin/plugin.json`. After the change is merged, run `scripts/plugin.sh update`
  from a terminal and reload VS Code to pick it up. [INSTALL.md](INSTALL.md) has the
  details.

As with everything else, changes to the system itself go through a branch and a pull
request.

## Glossary

**Agent (helper assistant).** A separate Claude instance that a main session hands one
focused job to, such as competitor research. It works on its own and returns only its
findings, which keeps the main conversation readable. This system has a market researcher
and an idea critic.

**App field.** The field on Fordsoft Development that says which app a task belongs to.
`Shared` is for work that serves every app.

**Beta.** The stage where a small group of testers uses the app before it's public.

**Board.** A GitHub Project that shows work as cards in columns. This system has two: the
Hub (one card per app) and Fordsoft Development (one card per task).

**Branch.** A separate working copy of a repository where changes are made without
affecting the main version until they are approved.

**Core loop.** The single repeated action-and-reward cycle an app exists to provide.

**Epic.** A big piece of work split into smaller tasks: a parent issue with sub-issues.

**Gate.** A checklist at the end of each evaluation phase. An idea must pass it before more
time is spent on it.

**Go / Park / Kill.** The three possible outcomes of an evaluation. Go means build it, Park
means wait for a named condition and Kill means stop. Each one is recorded with its reasons.

**Graduation.** Turning a Go idea into a real project with its own repositories, planning
documents and place on both boards.

**Hub card.** An idea's or app's single card on the Fordsoft Project Hub, backed by an
`[Idea]` or `[App]` issue in `proj-incubator`.

**Idea spec.** The single document in `ideas/` that holds everything known and decided
about one evaluated idea.

**Inbox.** The first column on the Hub: ideas that have been noted but not yet evaluated.

**Issue.** A GitHub item describing one piece of work, with its own discussion. Every task
in this system is an issue.

**Launch retro.** A review about 30 and 90 days after launch that compares an app's real
numbers with its predictions.

**Milestone.** A GitHub grouping of issues with a progress bar, used to say which release
an issue is for. Each app's main repo has **v1.0 Launch** (everything required before its
first public release), **v1.1** (the first update after launch) and **Later** (decided: not
now, no date). No milestone means not decided yet.

**MVP (minimum viable product).** The smallest first version of an app that still delivers
its core promise.

**Non-goal.** Something the first version deliberately will not do, written down with the
reason, to keep the scope small.

**Playbook.** A repeatable, step-by-step method, such as the App Evaluation Playbook.

**Plugin / skill.** `tico-os` is a plugin, an add-on that extends Claude Code. Each of its
commands, such as `new-idea`, is a skill: a written set of instructions that Claude follows
for that task.

**Pull request (PR).** A proposed change, shown as a before-and-after comparison, that a
person reviews and approves ("merges") before it becomes part of the main version.

**Repository (repo).** A versioned folder of files on GitHub that keeps a full history of
every change.

**Sunset.** The stage where an app is being retired: users are told, the listing is
removed, and data stays exportable for a while.

**Value proposition.** One plain sentence saying who a product is for, what problem it
solves and why it is better than the alternative.

## Where to read more

- [App Evaluation Playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md):
  the full detail behind every stage, gate, scoring rule, the launch retro and sunsetting.
- [Ticket conventions](https://github.com/evensteven01/proj-incubator/blob/main/processes/ticket-conventions.md):
  how work is filed and tracked on Fordsoft Development.
- [Idea spec template](https://github.com/evensteven01/proj-incubator/blob/main/ideas/TEMPLATE-app-spec.md):
  what an idea document looks like.
- [Cheatsheet](CHEATSHEET.md): a one-page command reference, plus troubleshooting.
- [INSTALL.md](INSTALL.md): installing and updating the plugin.
- [Architecture notes](docs/architecture.md): how the plugin itself is built, for anyone
  changing it.
