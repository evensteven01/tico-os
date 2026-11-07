#!/usr/bin/env bash
# Creates the labels and launch milestone used by the project system on a code repo.
# Idempotent: re-running skips anything that already exists.
#
# Usage: setup-github.sh <owner/repo> [--with-tiers]
#   --with-tiers  also create paid-tier / subscription-tier labels (once 03-pricing exists)
set -euo pipefail

repo="${1:?usage: setup-github.sh <owner/repo> [--with-tiers]}"
with_tiers="${2:-}"

label() {
  gh label create "$1" --repo "$repo" --color "$2" --description "$3" 2>/dev/null \
    && echo "created label: $1" || echo "label exists: $1"
}

label go-to-market F9A825 "Marketing/launch/business work — distinct from product engineering"

if [[ "$with_tiers" == "--with-tiers" ]]; then
  label paid-tier 8250DF "Feature gated behind the one-time paid unlock"
  label subscription-tier 1D76DB "Feature gated behind a future subscription tier"
fi

if gh api "repos/$repo/milestones" --jq '.[].title' | grep -qx "v1.0 Launch"; then
  echo "milestone exists: v1.0 Launch"
else
  gh api "repos/$repo/milestones" -f title="v1.0 Launch" \
    -f description="Everything required before the first public release: all P0 engineering tickets plus Phase B/C go-to-market tickets. Excludes launch-day execution and post-launch growth work." \
    >/dev/null
  echo "created milestone: v1.0 Launch"
fi
