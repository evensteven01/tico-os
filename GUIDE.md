# How the Fordsoft App System Works

This guide explains how app ideas at Fordsoft go from a first thought to a launched
product, and how the tools, documents and boards involved fit together. It is written to be
read start to finish by anyone, whether or not they write software. If you only need a list
of commands to type, the [cheatsheet](CHEATSHEET.md) is the quicker reference. Unfamiliar
terms are defined in the [glossary](#glossary) at the end.

The guide lives in `tico-os` because `tico-os` is what drives the process. The ideas,
playbooks and project documents it works on live in the other repositories described
below.

## Contents

1. [The short version](#the-short-version)
2. [Why the system is built this way](#why-the-system-is-built-this-way)
3. [The four places things live](#the-four-places-things-live)
4. [The life of an idea, stage by stage](#the-life-of-an-idea-stage-by-stage)
5. [How a decision gets made](#how-a-decision-gets-made)
6. [The project board](#the-project-board)
7. [What Claude does, and what it won't do](#what-claude-does-and-what-it-wont-do)
8. [Learning from each project](#learning-from-each-project)
9. [A normal working session](#a-normal-working-session)
10. [Changing the system itself](#changing-the-system-itself)
11. [Glossary](#glossary)
12. [Where to read more](#where-to-read-more)

---

## The short version

Every app idea is written up as a single document, called an **idea spec**, and stored in
the `proj-incubator` repository. The idea then passes through three short evaluation phases. Each phase
asks a harder question than the last, and each ends with a checkpoint, called a **gate**,
that the idea must pass before more time is spent on it. At the end of the third phase the
idea receives one of three decisions: **Go** (build it), **Park** (not now, but revisit when
a named condition is met), or **Kill** (don't build it, and record why).

An idea that gets a Go **graduates**. It gets its own code repository and its own set of
planning documents for the product, pricing and launch, and from then on it is managed as a
real project rather than as an idea.

Throughout all of this, a shared online board shows where every idea and project stands at
a glance. Claude, working inside VS Code, does most of the clerical work. It interviews you,
fills in documents, researches competitors, keeps the board up to date and prepares changes
for your review, while every judgment call stays with you.

```
   An idea             Evaluation (in proj-incubator)                  A real project
 ┌──────────┐   ┌─────────────────────────────────────────────┐   ┌────────────────────┐
 │ "What if │──►│ Phase 1      Phase 2         Phase 3         │──►│ Code repo          │
 │  …?"     │   │ The pitch ─► The scope ─► The market & money │Go │ Product spec       │
 └──────────┘   │    gate         gate        decision         │   │ Launch plan        │
                └──────────────────────────────┬──────────────┘   └────────────────────┘
                                               │
                                     Park (wait) or Kill (stop),
                                     with the reasons written down
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

## The four places things live

The system keeps information in four places. Each one is the single authority for a
particular kind of information, so it is always clear where to look and where to make a
change.

**1. [`proj-incubator`](https://github.com/evensteven01/proj-incubator): ideas and shared know-how.**
This is where every idea spec lives, in the `ideas/` folder. It also holds the knowledge
that applies across all apps. That includes the [App Evaluation Playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md)
in `playbooks/`, which describes the three phases in detail. It includes engineering
procedures in `processes/`, and proven technical designs that new apps can reuse in
`architecture/`. If you want to know how Fordsoft decides things in general, the answer is
here.

**2. The Fordsoft Project Hub board: status at a glance.**
This is a [GitHub Project board](https://github.com/users/evensteven01/projects/7) with one
card per idea or project, arranged in columns by stage. It answers "where does everything
stand?" in a few seconds, but it deliberately holds very little detail. The reasoning
behind each card lives in its spec.

**3. `project-docs` and each app's code repository: everything about a real project.**
Once an idea graduates, it gets a folder in the [`project-docs`](https://github.com/evensteven01/project-docs)
repository. That folder holds the product specification (`SPEC.md`), the work list
(`TICKETS.md`) and a set of go-to-market documents covering positioning, pricing, store
listing, marketing, launch readiness and revenue projections. The app's code lives in its
own repository, usually named after the project with a suffix such as `-mobile` or
`-landing`. Each code repository has a `PERSONA.md` file that records the technical
decisions already made and the known risks, so that anyone working on it, human or Claude,
starts from the same understanding.

**4. `tico-os` (this repository): the automation that drives everything.**
`tico-os` is a plugin for Claude Code, the AI assistant that runs inside VS Code. It teaches Claude the steps of this process, such as
how to interview you about a new idea, how to run an evaluation phase and how to set up a
new project. It also holds the templates new projects start from and a small script for
updating the board. It contains automation only, never the content itself. When Claude
evaluates an idea, it reads the playbook from `proj-incubator` at that moment instead of
keeping its own copy. That means an improvement to the playbook takes effect the next time
anyone uses it.

| If you want to know… | Look in |
|---|---|
| How ideas are evaluated, in general | `proj-incubator/playbooks/` |
| What we concluded about one specific idea | `proj-incubator/ideas/<idea>.md` |
| Where everything stands right now | The Fordsoft Project Hub board |
| What a live project is building, and its launch plan | `project-docs/<project>/` |
| Technical decisions and risks for one app | That app's code repo, `PERSONA.md` |
| How the automation behaves | `tico-os` |

## The life of an idea, stage by stage

This section follows a single idea through the whole process. For each stage it explains
what happens, who does what and what exists afterward. The stages correspond directly to
the phases in the [playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md), which has the full
checklists.

### Stage 1: Capture the pitch (about 30 to 60 minutes)

The question for this stage is simple: **is there a specific group of people with a
specific, real problem?**

You start by telling Claude you have an idea, or by typing `/tico-os:new-idea`. Claude
first checks whether a similar idea has already been evaluated. If one has, Claude shows
you what was decided and why, so you can choose whether this is a fresh angle or a revisit.

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

**What exists afterward:** a new idea spec in `ideas/`, a tracking issue in `proj-incubator`
titled `[Idea] <name>`, and a card on the board in the **Idea Backlog** column. All of this
is prepared as a change for you to review (see [pull requests](#glossary)) rather than
saved directly.

### Stage 2: Scope the product (about 1 to 3 hours)

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

If the second gate passes, the board card moves to **Scoped / Tech Spec**, and Claude asks
you to set a priority. The priority decides which scoped idea gets evaluated next.

### Stage 3: Research the market and decide (about 2 to 4 hours)

The question for this stage is: **can this win attention and make enough money to be worth
building?**

You run `/tico-os:evaluate-idea <idea>` again, and Claude picks up at the third phase. This
is the most involved stage, and it uses two helper assistants (see
[agents](#glossary)) so that their research does not clutter your conversation.

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
   you make the call. The scoring is explained in the next section.

**What exists afterward:** a complete spec with a dated decision and its reasoning. The
board card moves to **In Development** for a Go and to **Archived** for a Kill. A Park
stays in **Idea Backlog** with a written revisit trigger, such as "if a competitor raises
prices" or "in six months."

### Stage 4: Graduate (an hour or two)

When an idea gets a Go, you run `/tico-os:graduate-idea <idea>`. Claude confirms the project
name, which platform it targets (mobile, web or both) and what the code repositories should
be called. It asks before creating anything on GitHub.

Claude then sets up the project, carrying over the content of the idea spec rather than
asking the same questions again. The pitch and audience become the opening of the product
spec and the positioning document. The feature list and non-goals become the product scope.
The competitor table, pricing and revenue math become the matching go-to-market documents.
The technical risks become the open risks listed in the code repository's `PERSONA.md`.
Claude also sets up the starting files for automated testing, the labels used for tracking
work and a **v1.0 Launch** milestone that collects everything needed before launch.

Every piece is linked to every other. The idea spec points to the new project, the new
product spec notes which idea it came from, and the board card stays in **In Development**.
From this point, the project documents are the authority, and the idea spec becomes a
historical record.

A project does not have to come through the incubator. For an app that already exists or
was started another way, `/tico-os:new-project-setup` creates the same project structure
directly.

### Stage 5: Build and launch

Building happens in the project's own repositories, guided by its spec, its tickets and its
go-to-market documents. Day-to-day work is outside the scope of this guide. When the app
ships publicly, its board card moves to **Live / Launched**.

## How a decision gets made

The final decision rests on a weighted scorecard. Each criterion is scored from 1 (poor) to
5 (strong) and multiplied by its weight. The weights reflect the belief that reaching people
matters more than building:

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
experiment has shown it can be handled.

## The project board

The [Fordsoft Project Hub](https://github.com/users/evensteven01/projects/7) has one card per
idea or project. Each card has three fields:

- **Status** is the column the card sits in: Idea Backlog, Scoped / Tech Spec, In
  Development, Live / Launched or Archived.
- **Category** says what kind of card it is. App ideas are always **App Concept**. Cards
  for portfolio-wide work use **Architecture** or **Marketing**, and anything else uses
  **Other**.
- **Priority** is **P0 - High** or **P1 - Medium**, and is set once an idea has been scoped.

The board and the idea specs must agree. When an idea changes stage, Claude updates both
in the same sitting. If they ever disagree, the spec wins, because it holds the reasoning.
To check for disagreements, run `/tico-os:portfolio`. It reports on everything in the
pipeline and flags any mismatches, ideas whose revisit date has passed and scoped ideas
that have not been touched in a month. It only reads, and changes nothing unless you ask it
to fix what it found.

## What Claude does, and what it won't do

Claude handles the legwork. It interviews you, fills in documents, runs searches, does the
arithmetic, updates the board and prepares every change for review. It follows a short set
of standing rules, which load automatically at the start of every session in any of these
repositories:

- **It never changes the main version of anything directly.** Every change goes on a
  separate branch and becomes a pull request, which you review and approve. Claude also
  asks before opening the pull request itself.
- **It does not make things up.** Unknown facts are marked `Unknown`, together with a note
  on how to find out. Competitor information always comes from a live search with a date
  attached, never from memory.
- **It proposes, and you decide.** Claude suggests features, non-goals, scores and
  recommendations, and pushes back when something breaks the playbook's rules, such as an
  eighth feature. The decisions themselves, especially Go, Park or Kill, are always yours.
- **It asks before acting outside your computer**, such as before creating a new
  repository on GitHub.
- **It reviews code on GitHub, not in chat**, so review comments stay attached to the code
  they are about.

## Learning from each project

When a project solves a problem in a way other apps could reuse, such as how it stores data
on the phone, how it handles payments or how its automated tests are set up, that solution
can be written up as a shared pattern. Running `/tico-os:extract-pattern` has Claude read
the project's actual code, not a description of it, and write a document in `architecture/`
(for technical design) or `processes/` (for working procedures). If the pattern changes
which technologies Fordsoft uses by default, Claude also updates the playbook's
recommendations, so the next idea's scoping starts from it automatically.

This is how the system improves over time. Each project leaves behind knowledge that makes
the next evaluation faster and the next build safer.

## A normal working session

Everything happens in the Claude panel in VS Code. Open whichever repository you are
working in and start a conversation. The standing rules load automatically. If you open
`proj-incubator`, Claude also starts with a short summary of where each idea stands, read
from the specs on your computer.

You do not need to remember command names. Describing what you want ("I have an idea for…",
"let's scope the budgeting idea", "what should I work on next?") is enough for Claude to
pick the right step. The commands are there for when you want to be precise:

| You want to… | Type |
|---|---|
| Capture a new idea | `/tico-os:new-idea` |
| Move an idea to its next phase | `/tico-os:evaluate-idea <idea>` |
| Turn a Go idea into a project | `/tico-os:graduate-idea <idea>` |
| See the state of everything | `/tico-os:portfolio` |
| Write up a reusable pattern | `/tico-os:extract-pattern` |
| Set up a project that didn't come through here | `/tico-os:new-project-setup` |

Each command that changes something ends with a pull request waiting for your approval. The
change only becomes part of the main record once you merge it.

## Changing the system itself

Because content and automation are kept apart, most improvements are simple document edits:

- **To change how ideas are evaluated**, including the steps, gates, scorecard weights and
  default technologies, edit [`playbooks/app-evaluation-playbook.md`](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md)
  in `proj-incubator`. The change applies the next time anyone evaluates an idea.
- **To change what an idea spec contains**, edit [`ideas/TEMPLATE-app-spec.md`](https://github.com/evensteven01/proj-incubator/blob/main/ideas/TEMPLATE-app-spec.md).
  Keep it in step with the playbook, section for section.
- **To change how Claude behaves**, including its interview style, the standing rules or
  the project templates, edit this repository. After that change is merged, run
  `/plugin marketplace update tico-os` in the Claude panel and reload VS Code to pick it up.

As with everything else, changes to the system itself go through a branch and a pull
request.

## Glossary

**Agent (helper assistant).** A separate Claude instance that a main session hands one
focused job to, such as competitor research. It works on its own and returns only its
findings, which keeps the main conversation readable. This system has a market researcher
and an idea critic.

**Board.** The Fordsoft Project Hub, a GitHub Project that shows every idea and project as
a card in a column.

**Branch.** A separate working copy of a repository where changes are made without
affecting the main version until they are approved.

**Core loop.** The single repeated action-and-reward cycle an app exists to provide.

**Gate.** A checklist at the end of each evaluation phase. An idea must pass it before more
time is spent on it.

**Go / Park / Kill.** The three possible outcomes of an evaluation. Go means build it, Park
means wait for a named condition and Kill means stop. Each one is recorded with its reasons.

**Graduation.** Turning a Go idea into a real project with its own repositories and
planning documents.

**Idea spec.** The single document in `ideas/` that holds everything known and decided
about one idea.

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

**Value proposition.** One plain sentence saying who a product is for, what problem it
solves and why it is better than the alternative.

## Where to read more

- [App Evaluation Playbook](https://github.com/evensteven01/proj-incubator/blob/main/playbooks/app-evaluation-playbook.md): the full detail behind
  every phase, gate and scoring rule.
- [Idea spec template](https://github.com/evensteven01/proj-incubator/blob/main/ideas/TEMPLATE-app-spec.md): what an idea document looks like.
- [Cheatsheet](CHEATSHEET.md): a one-page command reference, plus setup and troubleshooting.
- [Architecture notes](docs/architecture.md):
  how the plugin itself is built, for anyone changing it.
