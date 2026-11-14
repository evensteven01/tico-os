#!/usr/bin/env bash
# Read and update the portfolio's GitHub Project boards by field/option *name*, so callers
# never deal with node IDs and a renamed column only needs the new name.
#
# Two boards:
#   hub  Fordsoft Project Hub — one card per app for its whole life (Inbox … Archived)
#   dev  Fordsoft Development — the work: every issue for every app, tagged with App
#
# Usage (--board defaults to hub; it can also be a board number):
#   board.sh [--board hub|dev|N] list [--json] [--app A]   Cards, grouped by status
#   board.sh [--board …] get <issue-url>                  One card's fields (JSON)
#   board.sh [--board …] add <issue-url> [--status S] [--priority P] [--app A]
#   board.sh [--board …] set <issue-url|item-id> <field> <option>
#   board.sh [--board …] remove <issue-url|item-id>        Take a card off the board (issue untouched)
#   board.sh [--board …] options                          Single-select fields and their options
#   board.sh --board dev app-add <app>                     New App option + a filtered "<app>" view
#
# On the dev board, `add` requires --app, so no card is ever missing its App.
#
# Config (env): TICO_BOARD_OWNER (default evensteven01), TICO_HUB_BOARD (default 7),
# TICO_DEV_BOARD (default 5). Needs a gh token with the `project` scope.
set -euo pipefail

owner="${TICO_BOARD_OWNER:-evensteven01}"
hub="${TICO_HUB_BOARD:-7}"
dev="${TICO_DEV_BOARD:-5}"
number="$hub"

die() { echo "board.sh: $*" >&2; exit 1; }

if [[ "${1:-}" == "--board" ]]; then
  case "${2:-}" in
    hub) number="$hub" ;;
    dev) number="$dev" ;;
    ''|*[!0-9]*) die "--board takes hub, dev, or a board number" ;;
    *) number="$2" ;;
  esac
  shift 2
fi

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
  gh project item-list "$number" --owner "$owner" --limit 1000 --format json
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
    json=0; app=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --json) json=1; shift ;;
        --app) app="$2"; shift 2 ;;
        *) die "unknown flag $1" ;;
      esac
    done
    items_json | JSON="$json" APP="$app" STATUS_ORDER="$(fields_json | python3 -c '
import json, sys
f = [f for f in json.load(sys.stdin)["fields"] if f["name"] == "Status"]
print("\n".join(o["name"] for o in f[0]["options"]) if f else "")')" python3 -c '
import json, os, sys
items = json.load(sys.stdin)["items"]
if os.environ["APP"]:
    items = [i for i in items if i.get("app") == os.environ["APP"]]
if os.environ["JSON"] == "1":
    print(json.dumps({"items": items}, indent=2)); sys.exit()
order = os.environ["STATUS_ORDER"].split("\n")
items.sort(key=lambda i: (order.index(i["status"]) if i.get("status") in order else 99, i.get("title", "")))
show_app = any("app" in i for i in items)
for i in items:
    cols = [(i.get("status") or "-").ljust(20)]
    if show_app:
        cols.append((i.get("app") or "-").ljust(14))
    cols += [(i.get("priority") or "-").ljust(4), i.get("title", ""), " " + i.get("content", {}).get("url", "")]
    print(" ".join(cols))'
    ;;
  get)
    [[ $# -eq 1 ]] || die "usage: get <issue-url>"
    items_json | URL="$1" python3 -c '
import json, os, sys
m = [i for i in json.load(sys.stdin)["items"] if i.get("content", {}).get("url") == os.environ["URL"]]
print(json.dumps(m[0], indent=2) if m else "{}")'
    ;;
  add)
    [[ $# -ge 1 ]] || die "usage: add <issue-url> [--status S] [--priority P] [--app A]"
    url="$1"; shift
    status=""; priority=""; app=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --status) status="$2"; shift 2 ;;
        --priority) priority="$2"; shift 2 ;;
        --app) app="$2"; shift 2 ;;
        *) die "unknown flag $1" ;;
      esac
    done
    if [[ "$number" == "$dev" && -z "$app" ]]; then
      die "the dev board needs --app (options: $(fields_json | python3 -c '
import json, sys
f = [f for f in json.load(sys.stdin)["fields"] if f["name"] == "App"]
print(", ".join(o["name"] for o in f[0]["options"]) if f else "none")'))"
    fi
    # Validate every option before writing anything.
    for pair in "Status:$status" "Priority:$priority" "App:$app"; do
      f="${pair%%:*}"; o="${pair#*:}"
      [[ -z "$o" ]] || [[ -n "$(option_id "$f" "$o")" ]] || die "no option '$o' on field '$f'"
    done
    item="$(gh project item-add "$number" --owner "$owner" --url "$url" --format json --jq .id)"
    echo "added $url ($item)"
    [[ -z "$status" ]] || set_field "$item" Status "$status"
    [[ -z "$priority" ]] || set_field "$item" Priority "$priority"
    [[ -z "$app" ]] || set_field "$item" App "$app"
    ;;
  set)
    [[ $# -eq 3 ]] || die "usage: set <issue-url|item-id> <field> <option>"
    item="$(item_id_for "$1")"; [[ -n "$item" ]] || die "$1 is not on board $owner/$number"
    set_field "$item" "$2" "$3"
    ;;
  remove)
    [[ $# -eq 1 ]] || die "usage: remove <issue-url|item-id>"
    item="$(item_id_for "$1")"; [[ -n "$item" ]] || die "$1 is not on board $owner/$number"
    gh project item-delete "$number" --owner "$owner" --id "$item" >/dev/null
    echo "removed $1 from board $number"
    ;;
  options)
    fields_json | python3 -c '
import json, sys
for f in json.load(sys.stdin)["fields"]:
    if f.get("options"):
        print(f["name"] + ": " + " | ".join(o["name"] for o in f["options"]))'
    ;;
  app-add)
    [[ $# -eq 1 ]] || die "usage: --board dev app-add <app>"
    [[ "$number" == "$dev" ]] || die "app-add only applies to the dev board (--board dev)"
    fields_json | PROJECT="$(project_id)" APP="$1" python3 -c '
import json, os, subprocess, sys

def gql(query, variables):
    r = subprocess.run(["gh", "api", "graphql", "--input", "-"], capture_output=True, text=True,
                       input=json.dumps({"query": query, "variables": variables}))
    out = json.loads(r.stdout or "{}")
    if r.returncode or out.get("errors"):
        sys.exit("board.sh: " + (r.stderr or json.dumps(out.get("errors"))))
    return out["data"]

app = os.environ["APP"]
fields = {f["name"]: f for f in json.load(sys.stdin)["fields"]}
if "App" not in fields:
    sys.exit("board.sh: no App field on this board")
options = fields["App"]["options"]
if any(o["name"] == app for o in options):
    print(f"App option {app!r} already exists")
else:
    # Re-send existing options with their IDs so cards keep their values.
    current = gql("query($id:ID!){node(id:$id){... on ProjectV2SingleSelectField{options{id name color description}}}}",
                  {"id": fields["App"]["id"]})["node"]["options"]
    new = current + [{"name": app, "color": "GRAY", "description": ""}]
    gql("mutation($i:UpdateProjectV2FieldInput!){updateProjectV2Field(input:$i){clientMutationId}}",
        {"i": {"fieldId": fields["App"]["id"], "singleSelectOptions": new}})
    print(f"App option {app!r} added")

project = gql("query($id:ID!){node(id:$id){... on ProjectV2{url views(first:50){nodes{name number}}}}}",
              {"id": os.environ["PROJECT"]})["node"]
base = project["url"]
existing = [v for v in project["views"]["nodes"] if v["name"] == app]
if existing:
    number = existing[0]["number"]
    print(f"view {app!r} already exists: {base}/views/{number}")
else:
    visible = [fields[n]["id"] for n in ("Title", "Status", "Priority", "Size", "Labels",
                                         "Linked pull requests", "Sub-issues progress") if n in fields]
    view = gql("mutation($i:CreateProjectV2ViewInput!){createProjectV2View(input:$i){projectV2View{id number}}}",
               {"i": {"projectId": os.environ["PROJECT"], "name": app, "layout": "BOARD_LAYOUT",
                      "configuration": {"visibleFieldIds": visible}}})["createProjectV2View"]["projectV2View"]
    gql("mutation($i:UpdateProjectV2ViewInput!){updateProjectV2View(input:$i){clientMutationId}}",
        {"i": {"viewId": view["id"], "filter": f"app:{app}"}})
    number = view["number"]
    print(f"view {app!r} created (board, filter app:{app}): {base}/views/{number}")'
    ;;
  *)
    sed -n '2,22p' "$0"; exit 1 ;;
esac
