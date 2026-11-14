#!/usr/bin/env bash
# SessionStart hook: stdout is added to Claude's context.
# 1. House rules, every session.
# 2. In proj-incubator: a pipeline summary from the idea specs, plus the Hub's Inbox (one
#    network call, capped at 5 seconds and skipped quietly if it fails).
set -uo pipefail

root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
sed "s|\${CLAUDE_PLUGIN_ROOT}|$root|g" "$root/rules/house-rules.md"

incubator="${TICO_INCUBATOR_DIR:-$HOME/Development/proj-incubator}"
case "$PWD/" in
  "$incubator"/*) ;;
  *) exit 0 ;;
esac

python3 - "$incubator/ideas" <<'EOF'
import pathlib, re, sys, datetime

def field(text, name):
    m = re.search(r"^\|\s*\*\*%s\*\*\s*\|\s*(.+?)\s*\|\s*$" % re.escape(name), text, re.M)
    return m.group(1) if m else ""

ideas = sorted(p for p in pathlib.Path(sys.argv[1]).glob("*.md")
               if not p.name.startswith("TEMPLATE") and p.name != "README.md")
if not ideas:
    print("\n## Incubator pipeline\n\nNo idea specs yet. Start one with /tico-os:new-idea.")
    sys.exit()

print("\n## Incubator pipeline (from ideas/*.md headers — the board may differ; /tico-os:portfolio checks both)\n")
for p in ideas:
    t = p.read_text()
    status, decision = field(t, "Status"), field(t, "Decision")
    trigger = re.search(r"\*\*Revisit trigger \(Park only\):\*\*\s*(.+)", t)
    line = f"- {p.stem}: {status or '?'} · decision {decision or '?'}"
    if decision.startswith("Park") and trigger:
        line += f" · revisit: {trigger.group(1).strip()}"
    print(line)
EOF

# Inbox ideas have no spec file yet; they only exist as Hub cards.
inbox="$(perl -e 'alarm 5; exec @ARGV' "$root/scripts/board.sh" list --json 2>/dev/null | python3 -c '
import json, sys
try:
    items = json.load(sys.stdin)["items"]
except Exception:
    sys.exit()
for i in items:
    if i.get("status") == "Inbox":
        print("- " + i.get("title", "") + "  " + i.get("content", {}).get("url", ""))' 2>/dev/null)"
if [[ -n "$inbox" ]]; then
  printf '\n## Hub Inbox (raw ideas, not evaluated yet; /tico-os:new-idea on one runs Phase 1)\n\n%s\n' "$inbox"
fi
