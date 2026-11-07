# Platform inserts — web app / SaaS

Not copied into a project as-is. `new-project-setup` reads this file and merges each
section into the named doc when a project's platform is web. `go-to-market/02-listing.md`
next to this file replaces the shared set's missing 02 doc wholesale.

## Early decisions (seed GTM_WORKPLAN.md step 1 and the persona's open questions)

- **Hosting and domain.** Where it deploys (static host vs. a server/platform), and the
  domain. A subdomain of a domain you already own is a fine reversible placeholder until the
  name locks.
- **Accounts and auth.** Does v1 need user accounts at all? An account system is often the
  single biggest scope item in a web MVP — decide deliberately, and pick a hosted provider
  over hand-rolled auth unless there's a real reason.
- **Seller identity.** Whether payments and legal pages name you personally or a business
  entity (e.g. an LLC). Payment processors and app marketplaces may require the entity's
  details up front, so decide before payment setup, not during it.
- **Codename.** Until naming clears (01), use an internal codename in `package.json` and
  config rather than the repo placeholder.

## 03 — payment mechanism

- A hosted checkout (Stripe Checkout, Lemon Squeezy, Paddle) over a custom payment form.
  Merchant-of-record providers (Paddle, Lemon Squeezy) handle sales tax/VAT for you at a
  higher fee; Stripe is cheaper but leaves tax compliance to you — name which tradeoff fits.
- File two separate tickets: payment-provider account/product setup (GTM) and the checkout
  + entitlement gating in the app (dev).

## 05 — operational / launch items

- [ ] **Domain and TLS** configured on the production URL; www/apex redirect decided.
- [ ] **Favicon and social preview image** (Open Graph / Twitter card) final.
- [ ] **Screenshots / demo** produced per [02](02-listing.md).
- [ ] **Payment provider live** — account verified with tax/banking info (verification can
      take days), products/prices matching [03](03-pricing-strategy.md), test-mode
      purchase run end to end before switching to live keys.
- [ ] **Transactional email** (signup, receipts, password reset) sending from the real
      domain with SPF/DKIM set, if the product sends any email.
- [ ] **Analytics** — privacy-respecting and only what's needed to read the funnel in 06;
      consent banner only if it sets non-essential cookies.
- [ ] **Backups and restore tested** for any server-side data.
- [ ] **Error monitoring and uptime check** on the production URL.

## 07 — distribution mechanics

A private beta behind an invite list or access code on the real production deployment, so
the beta doubles as a dry run of the production deploy. Collect sign-ups via a simple form
(see `scaffolding/landing/`).

## 09 — manual environment QA matrix

Minimum coverage: latest Chrome, Safari (macOS and iOS), and Firefox; one narrow mobile
viewport and one desktop. For each: full core loop, empty states, form validation, slow or
dropped network, session expiry, and back/forward/refresh mid-flow.

## Persona shared-context hints

Typical quirks worth stating once in the code repo's PERSONA.md: how to run the app
locally against non-production data, which env vars/secrets are needed and where they live
(never in the repo), and how to verify UI (dev server URL + browser).

## Scaffolding

- `scaffolding/ci/node-ci.yml` → `.github/workflows/ci.yml`
- `scaffolding/landing/` → the pre-launch beta page, either a separate repo or a route in
  the app itself
