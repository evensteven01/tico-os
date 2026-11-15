---
name: launch-retro
description: Use about 30 and 90 days after an app launches, or when the user asks how a launched app is doing against its plan ("launch retro for <app>", "how did <app> do vs. projections", "30-day review") — compares actual funnel and revenue numbers with the Phase 3 scenarios, records the results, and proposes updates to the playbook's assumed rates so future Go/Park/Kill calls get more accurate.
---

# Launch Retro

Closes the loop between prediction and reality. Phase 3 of the evaluation playbook guesses
at conversion rates; this skill measures what actually happened, so the next idea's
revenue math (and scorecard) starts from real numbers instead of placeholders. Read the
playbook's **Launch retro** section first (`playbooks/app-evaluation-playbook.md` in the
incubator, `$TICO_INCUBATOR_DIR`, default `~/Development/proj-incubator`); it defines what
to measure.

## When it's due

At **30 days** and **90 days** after the launch date. The date is on the app's Hub card
(the **Launched** row in the `[App]` issue body). `/tico-os:portfolio` flags retros that
are due. Running one early is fine; label it with the actual day count.

## Steps

1. **Find the predictions.** In order of preference:
   - the idea spec's Phase 3 revenue scenarios (`ideas/<slug>.md`, linked from the Hub card's
     Origin row), including a retroactive spec if one was written
   - otherwise the project's `go-to-market/06-revenue-projections.md`

   Pull out each funnel rate (impressions → installs/signups → activation → paid), the net
   price, the fixed costs, and the break-even point.
2. **Get the actuals from the user.** Store consoles and payment dashboards have no access
   from here, so ask for the numbers for the period: impressions or page views, installs or
   signups, activated users (whatever "activation" meant in the spec), paying users, gross
   and net revenue, refunds, ratings and their count. Anything they don't have is
   `Unknown — <where to find it>`. Never estimate a number to fill the table.
3. **Compare.** One table: each metric, the slow / steady / breakout prediction, the actual,
   and which scenario the actual is closest to. Show the arithmetic for derived rates.
   Then, in a few sentences:
   - which funnel stage underperformed most against the plan, and the likeliest reason
     (from reviews, feedback-form responses, analytics, or the user's read)
   - whether the slow-organic case held up, and what break-even now looks like
   - which scorecard criteria the original evaluation over- or under-rated
     (e.g. "audience findability scored 4; real install rate suggests 2")
4. **Record it.**
   - In `project-docs/<slug>/go-to-market/06-revenue-projections.md`: an **Actuals** section
     with a dated row per retro (create it the first time).
   - In the idea spec, if there is one: a dated row in its **Launch retro** section.
5. **Propose playbook changes.** If real rates differ meaningfully from the playbook's
   placeholder rates (Phase 3, Step 4), or a scorecard weight looks wrong, propose a
   specific edit with the evidence, e.g. "slow-organic install rate 3% → 1.5% for paid
   finance apps (budget-app 30-day: 1.4%)". One app is one data point: say so, and suggest
   a category-specific note rather than a blanket change until there are several.
6. **Decide what's next with the user**: keep going as planned, change the growth plan
   (`04-marketing-and-acquisition.md`), change pricing, or consider **Sunset** if the 90-day
   numbers are far below the slow case with no clear fix. Record the decision in the retro
   row.
7. Each repo touched (`project-docs`, `proj-incubator`) gets a branch + commit + push; ask
   before opening each PR.
