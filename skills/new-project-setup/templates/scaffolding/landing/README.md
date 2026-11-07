# {{PRODUCT_NAME}} — Beta Landing Page

Static one-page site recruiting beta testers for `{{CODE_REPO_NAME}}` from outside the
personal network — see {{TICKET_LINK}} for the context and decisions behind this page.

- Hosted via GitHub Pages at `{{LANDING_DOMAIN}}` (see `CNAME`).
- No backend: the "Apply" button links out to a form ({{FORM_PROVIDER}}). No build step, no
  dependencies — just `index.html`.
- Not the product's marketing/SEO site — that's a separate, later effort.

## Setup

1. Create the repo, enable GitHub Pages from `main` (root).
2. Add a DNS `CNAME` record for `{{LANDING_DOMAIN}}` pointing at `<owner>.github.io`, then
   turn on "Enforce HTTPS" once the certificate issues.

## Editing

Edit `index.html` directly, branch + PR as with any other repo. GitHub Pages redeploys
automatically on merge to `main`.
