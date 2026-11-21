#!/usr/bin/env bash
# Creates the labels and launch milestone used by the project system on a code repo, and
# optionally connects the repo to the Fordsoft Development board.
# Idempotent: re-running skips anything that already exists.
#
# Usage: setup-github.sh <owner/repo> [--with-tiers] [--app <app>] [--secondary]
#                         [--skip <n,n,...>] [--dry-run]
#   --with-tiers  also create paid-tier / subscription-tier labels (once 03-pricing exists)
#   --app <app>   link the repo to the Fordsoft Development board, and put every issue in
#                 the repo on it with App = <app>. Cards already on the board keep their
#                 Status; a card with no App gains <app>, and a card that already has a
#                 different App (e.g. Shared) keeps it. New cards start as Backlog (open)
#                 or Done (closed). The App option must exist
#                 (board.sh --board dev app-add <app>).
#   --secondary   for an app's -landing / -backend repo: only link it to the board. No
#                 labels, no milestone, no issues (the app's issues live on its main repo).
#                 Needs --app.
#   --skip <n,…>  issue numbers to leave off the board (e.g. a stray or retired issue)
#   --dry-run     print what would change, write nothing
set -euo pipefail

repo="${1:?usage: setup-github.sh <owner/repo> [--with-tiers] [--app <app>] [--secondary] [--skip <n,...>] [--dry-run]}"; shift
with_tiers=""; app=""; dry=""; secondary=""; skip=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-tiers) with_tiers=1; shift ;;
    --app) app="${2:?--app needs a name}"; shift 2 ;;
    --dry-run) dry=1; shift ;;
    --secondary) secondary=1; shift ;;
    --skip) skip=",${2:?--skip needs issue numbers},"; shift 2 ;;
    *) echo "unknown flag $1" >&2; exit 1 ;;
  esac
done
[[ -z "$secondary" || -n "$app" ]] || { echo "--secondary needs --app" >&2; exit 1; }

if [[ -z "$secondary" ]]; then

label() {
  if [[ -n "$dry" ]]; then
    gh label list --repo "$repo" --limit 200 --json name --jq '.[].name' | grep -qx "$1" \
      && echo "label exists: $1" || echo "would create label: $1"
    return
  fi
  gh label create "$1" --repo "$repo" --color "$2" --description "$3" 2>/dev/null \
    && echo "created label: $1" || echo "label exists: $1"
}

label go-to-market F9A825 "Marketing/launch/business work — distinct from product engineering"
label deferred BFBFBF "Deliberately decided out of v1; kept for a later version"

if [[ -n "$with_tiers" ]]; then
  label paid-tier 8250DF "Feature gated behind the one-time paid unlock"
  label subscription-tier 1D76DB "Feature gated behind a future subscription tier"
fi

if gh api "repos/$repo/milestones?state=all" --jq '.[].title' | grep -qx "v1.0 Launch"; then
  echo "milestone exists: v1.0 Launch"
elif [[ -n "$dry" ]]; then
  echo "would create milestone: v1.0 Launch"
else
  gh api "repos/$repo/milestones" -f title="v1.0 Launch" \
    -f description="Everything required before the first public release: all P0 engineering tickets plus Phase B/C go-to-market tickets. Excludes launch-day execution and post-launch growth work." \
    >/dev/null
  echo "created milestone: v1.0 Launch"
fi

fi  # not --secondary

[[ -n "$app" ]] || exit 0

# Connect to the Fordsoft Development board.
root="$(cd "$(dirname "$0")/../../../../.." && pwd)"
board="$root/scripts/board.sh"
[[ -x "$board" ]] || { echo "can't find board.sh at $board" >&2; exit 1; }
owner="${TICO_BOARD_OWNER:-evensteven01}"
dev="${TICO_DEV_BOARD:-5}"

if [[ -n "$dry" ]]; then
  echo "would link $repo to board $dev (no-op if already linked)"
else
  gh project link "$dev" --owner "$owner" --repo "$repo" >/dev/null 2>&1 \
    && echo "linked $repo to board $dev" || echo "board $dev already linked to $repo (or link failed; check the repo's Projects tab)"
fi

[[ -z "$secondary" ]] || exit 0

on_board="$("$board" --board dev list --json | python3 -c '
import json, sys
for i in json.load(sys.stdin)["items"]:
    print(i.get("content", {}).get("url", ""), i["id"], i.get("app") or "-")')"

gh issue list --repo "$repo" --state all --limit 1000 --json url,state \
  --jq '.[] | "\(.url) \(.state)"' | while read -r url state; do
  if [[ "$skip" == *",${url##*/},"* ]]; then echo "skipped: $url"; continue; fi
  match="$(grep -F "$url " <<<"$on_board" || true)"
  if [[ -n "$match" ]]; then
    read -r _ item current <<<"$match"
    if [[ "$current" == "$app" ]]; then
      echo "ok: $url"
    elif [[ "$current" != "-" ]]; then
      echo "keeps App $current: $url"
    elif [[ -n "$dry" ]]; then
      echo "would tag ($current → $app): $url"
    else
      "$board" --board dev set "$item" App "$app" >/dev/null && echo "tagged: $url"
    fi
  else
    status="Backlog"; [[ "$state" == "CLOSED" ]] && status="Done"
    if [[ -n "$dry" ]]; then echo "would add ($status): $url"; continue; fi
    "$board" --board dev add "$url" --status "$status" --app "$app" >/dev/null && echo "added ($status): $url"
  fi
done
