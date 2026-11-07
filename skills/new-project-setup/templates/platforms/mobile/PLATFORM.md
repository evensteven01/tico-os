# Platform inserts — mobile app (iOS / Android)

Not copied into a project as-is. `new-project-setup` reads this file and merges each
section into the named doc when a project's platform is mobile. `go-to-market/02-listing.md`
next to this file replaces the shared set's missing 02 doc wholesale.

## Early decisions (seed GTM_WORKPLAN.md step 1 and the persona's open questions)

These are cheap to decide early and expensive to discover late:

- **Delivery path off the dev sandbox.** If the project starts on Expo Go (or any
  sandbox/dev-only runtime), decide early how it reaches testers: Expo Go can't load other
  accounts' projects and can't do in-app purchases, so beta and IAP both need a
  development/standalone build (EAS Build). Prove a standalone build works before the beta
  plan depends on it.
- **Bundle ID / package name.** Permanent once published — keep it name-neutral
  (`com.<your-domain>.<category>`), since the product name usually isn't locked yet.
- **Seller identity: personal vs. organization developer accounts.**

  | | Personal account | Organization account |
  |---|---|---|
  | Public seller name | Your legal name | Company name |
  | Requirements | ID verification | A legal entity (e.g. an LLC) and a D-U-N-S number — slower to set up |
  | Google Play production access | Closed test with at least 12 testers opted in for 14 straight days, then review (verify current rule) | Not subject to that rule |

  If personal, 07's beta plan must use a Play **closed** test (not internal testing) and
  needs enough Android testers to meet the threshold on its own.
- **Codename.** Until naming clears (01), use an internal codename in `app.json` /
  `package.json` rather than the repo placeholder — it keeps the placeholder from leaking
  into builds, and is trivially swapped once the real name locks.

## 03 — payment mechanism

- In-app purchase (StoreKit / Play Billing, e.g. via `expo-iap` or RevenueCat) for any paid
  unlock or subscription; the stores take their cut (15% under the small-business programs).
- IAP needs a development/standalone build — it can't be tested in Expo Go.
- File two separate tickets: the store-side product config (GTM) and the purchase flow +
  entitlement gating in the app (dev). One doesn't cover the other.

## 05 — operational / store-submission items

- [ ] **Developer accounts active** — Apple ($99/year) and Google ($25 one-time), with
      legal/tax/banking info. Payout verification can take days; budget lead time.
- [ ] **App icon** — final, all required sizes/formats for iOS and Android (including the
      Android adaptive icon layers).
- [ ] **Screenshots** produced per [02](02-listing.md), at each required device size.
- [ ] **Privacy nutrition label (iOS) / Data Safety form (Android)** — filled out against
      actual architecture, revisited the moment a network call is added.
- [ ] **Age rating questionnaire** on both stores.
- [ ] **In-app purchase products** configured to match [03](03-pricing-strategy.md),
      sandbox-tested before submission.
- [ ] **Release build smoke-tested** — persistence across restarts, any share-sheet /
      file export flows, any network exception (feedback form, crash reporting).

## 07 — distribution mechanics

TestFlight (iOS) and Play testing tracks (Android) — internal testing for a handful of
people, **closed** testing if the Play account is personal and needs the production-access
threshold. For the earliest sideload-only round, an EAS `preview` profile building an
Android APK (`scaffolding/mobile/eas.json`) is the cheapest path. Prefer TestFlight/Play
tracks once possible, since they double as a dry run of real submission.

## 09 — manual device QA matrix

Minimum real-hardware coverage: at least one current iPhone, one older/smaller iPhone, and
one mid-range Android. For each: full core loop, empty states, form validation, and
interruption behavior (backgrounded, force-closed, low storage, OS dark mode / large text).
Simulator screenshots are fine for day-to-day verification but don't satisfy this matrix.

## Persona shared-context hints

Typical environment quirks worth stating once in the code repo's PERSONA.md: how to verify
UI without a UI-automation tool (e.g. `xcrun simctl io booted screenshot`), Node version
manager PATH setup, and the pinned Expo SDK docs URL (in AGENTS.md).

## Scaffolding

- `scaffolding/ci/node-ci.yml` → `.github/workflows/ci.yml`
- `scaffolding/mobile/eas.json` → `eas.json` (once leaving Expo Go)
- `scaffolding/landing/` → a separate `<project>-landing` repo, if the beta needs recruiting
  beyond the personal network
