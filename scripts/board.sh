#!/usr/bin/env bash
# Read and update the portfolio GitHub Project board by field/option *name*, so callers
# never deal with node IDs and a renamed column only needs the new name.
#
# Usage:
#   board.sh list [--json]                      All items: status, category, priority, title, url
#   board.sh get <issue-url>                    One item's fields (JSON)
#   board.sh add <issue-url> [--status S] [--category C] [--priority P]
#   board.sh set <issue-url|item-id> <field> <option>   e.g. set <url> Status "Scoped / Tech Spec"
#   board.sh options                            Single-select fields and their valid options
#
# Config (env): TICO_BOARD_OWNER (default evensteven01), TICO_BOARD_NUMBER (default 7).
# Needs a gh token with the `project` scope.
set -euo pipefail

owner="${TICO_BOARD_OWNER:-evensteven01}"
number="${TICO_BOARD_NUMBER:-7}"

die() { echo "board.sh: $*" >&2; exit 1; }

project_id() {
  gh project view "$number" --owner "$owner" --format json --jq .id
}

fields_json() {
  gh project field-list "$number" --owner "$owner" --format json
}

field_id() {
  fields_json | FIELD="$1" python3 -c '
import json, os, sys
f = [f for f in json.load(sys.stdin)["fields"] if f["name"] == os.environ["FIELD"]]
print(f[0]["id"] if f else "")'
}

option_id() {
  fields_json | FIELD="$1" OPTION="$2" python3 -c '
import json, os, sys
for f in json.load(sys.stdin)["fields"]:
    if f["name"] == os.environ["FIELD"]:
        for o in f.get("options", []):
            if o["name"] == os.environ["OPTION"]:
                print(o["id"]); sys.exit()
        print("valid options: " + ", ".join(o["name"] for o in f.get("options", [])), file=sys.stderr)
print("")'
}

items_json() {
  gh project item-list "$number" --owner "$owner" --limit 500 --format json
}

item_id_for() {
  case "$1" in
    PVTI_*) echo "$1" ;;
    *) items_json | URL="$1" python3 -c '
import json, os, sys
m = [i["id"] for i in json.load(sys.stdin)["items"] if i.get("content", {}).get("url") == os.environ["URL"]]
print(m[0] if m else "")' ;;
  esac
}

set_field() {
  local item="$1" field="$2" option="$3" fid oid
  fid="$(field_id "$field")"; [[ -n "$fid" ]] || die "no field named '$field'"
  oid="$(option_id "$field" "$option")"; [[ -n "$oid" ]] || die "no option '$option' on field '$field'"
  gh project item-edit --id "$item" --project-id "$(project_id)" \
    --field-id "$fid" --single-select-option-id "$oid" >/dev/null
  echo "$field → $option"
}

cmd="${1:-}"; shift || true
case "$cmd" in
  list)
    if [[ "${1:-}" == "--json" ]]; then items_json; exit; fi
    items_json | python3 -c '
import json, sys
items = json.load(sys.stdin)["items"]
order = ["Idea Backlog", "Scoped / Tech Spec", "In Development", "Live / Launched", "Archived"]
items.sort(key=lambda i: (order.index(i["status"]) if i.get("status") in order else 99, i.get("title", "")))
for i in items:
    print("{:<20} {:<13} {:<12} {}  {}".format(i.get("status") or "-", i.get("category") or "-",
          i.get("priority") or "-", i.get("title", ""), i.get("content", {}).get("url", "")))'
    ;;
  get)
    [[ $# -eq 1 ]] || die "usage: get <issue-url>"
    items_json | URL="$1" python3 -c '
import json, os, sys
m = [i for i in json.load(sys.stdin)["items"] if i.get("content", {}).get("url") == os.environ["URL"]]
print(json.dumps(m[0], indent=2) if m else "{}")'
    ;;
  add)
    [[ $# -ge 1 ]] || die "usage: add <issue-url> [--status S] [--category C] [--priority P]"
    url="$1"; shift
    item="$(gh project item-add "$number" --owner "$owner" --url "$url" --format json --jq .id)"
    echo "added $url ($item)"
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --status) set_field "$item" Status "$2"; shift 2 ;;
        --category) set_field "$item" Category "$2"; shift 2 ;;
        --priority) set_field "$item" Priority "$2"; shift 2 ;;
        *) die "unknown flag $1" ;;
      esac
    done
    ;;
  set)
    [[ $# -eq 3 ]] || die "usage: set <issue-url|item-id> <field> <option>"
    item="$(item_id_for "$1")"; [[ -n "$item" ]] || die "$1 is not on board $owner/$number"
    set_field "$item" "$2" "$3"
    ;;
  options)
    fields_json | python3 -c '
import json, sys
for f in json.load(sys.stdin)["fields"]:
    if f.get("options"):
        print(f["name"] + ": " + " | ".join(o["name"] for o in f["options"]))'
    ;;
  *)
    sed -n '2,13p' "$0"; exit 1 ;;
esac
