#!/usr/bin/env bash
# SessionStart hook: stdout is added to Claude's context.
# 1. House rules, every session.
# 2. In proj-incubator: a local (no network) pipeline summary from the idea specs.
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
