#!/usr/bin/env bash
# Install, update or check the tico-os plugin.
#
# The VS Code chat doesn't accept /plugin commands, so this drives the Claude Code CLI
# instead: a `claude` on PATH if there is one, otherwise the copy bundled inside the
# newest installed VS Code extension. Both share ~/.claude, so the VS Code chat picks up
# whatever this installs after a window reload.
#
#   plugin.sh install   # add the marketplace (if needed) and install tico-os
#   plugin.sh update    # pull the latest main from GitHub and update the installed copy
#   plugin.sh status    # show which claude is used, and the installed version
set -euo pipefail

MARKETPLACE_SOURCE="evensteven01/tico-os"
MARKETPLACE_NAME="tico-os"
PLUGIN_ID="tico-os@tico-os"

find_claude() {
  if command -v claude >/dev/null 2>&1; then
    command -v claude
    return
  fi
  local bundled
  bundled=$(ls -d "$HOME"/.vscode/extensions/anthropic.claude-code-*/resources/native-binary/claude 2>/dev/null \
    | sort -V | tail -1 || true)
  if [[ -n "$bundled" && -x "$bundled" ]]; then
    echo "$bundled"
    return
  fi
  echo "error: no Claude Code CLI found. Install the Claude Code extension in VS Code, or the standalone CLI." >&2
  exit 1
}

CLAUDE=$(find_claude)

case "${1:-}" in
  install)
    if "$CLAUDE" plugin marketplace list 2>/dev/null | grep -q "GitHub ($MARKETPLACE_SOURCE)"; then
      echo "Marketplace $MARKETPLACE_NAME already added."
    else
      "$CLAUDE" plugin marketplace add "$MARKETPLACE_SOURCE"
    fi
    "$CLAUDE" plugin install "$PLUGIN_ID"
    echo
    echo "Done. Reload VS Code (Cmd+Shift+P → Developer: Reload Window) and start a new chat."
    ;;
  update)
    "$CLAUDE" plugin marketplace update "$MARKETPLACE_NAME"
    "$CLAUDE" plugin update "$PLUGIN_ID"
    echo
    echo "Done. Reload VS Code (Cmd+Shift+P → Developer: Reload Window) and start a new chat."
    ;;
  status)
    echo "Using: $CLAUDE"
    "$CLAUDE" plugin list
    ;;
  *)
    sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
    exit 1
    ;;
esac
