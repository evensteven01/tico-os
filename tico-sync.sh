#!/usr/bin/env bash
# tico-sync.sh — symlink tico-os assets into ~/.claude/

set -euo pipefail

TICO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SKILLS_SRC="$TICO_DIR/.tico/skills"
PROMPTS_SRC="$TICO_DIR/.tico/prompts"
CLAUDE_SKILLS="$CLAUDE_DIR/skills"
CLAUDE_PROMPTS="$CLAUDE_DIR/prompts"
CLAUDE_MD_SRC="$TICO_DIR/CLAUDE.md"
CLAUDE_MD_DEST="$CLAUDE_DIR/CLAUDE.md"

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "[DRY RUN] No changes will be made."
fi

log() {
  echo "[tico-sync] $*"
}

run() {
  if $DRY_RUN; then
    echo "[DRY RUN]  $*"
  else
    eval "$*"
  fi
}

# Ensure ~/.claude subdirectories exist
for dir in "$CLAUDE_SKILLS" "$CLAUDE_PROMPTS"; do
  if [[ ! -d "$dir" ]]; then
    log "Creating directory: $dir"
    run "mkdir -p \"$dir\""
  fi
done

# Symlink skills with tico__ prefix
log "--- Syncing skills ---"
for file in "$SKILLS_SRC"/*.md; do
  [[ -e "$file" ]] || { log "No skill files found in $SKILLS_SRC"; break; }
  basename=$(basename "$file")
  dest="$CLAUDE_SKILLS/tico__${basename}"
  if [[ -L "$dest" ]]; then
    log "Updating symlink: $dest -> $file"
  else
    log "Creating symlink: $dest -> $file"
  fi
  run "ln -sf \"$file\" \"$dest\""
done

# Symlink prompts with tico__ prefix
log "--- Syncing prompts ---"
for file in "$PROMPTS_SRC"/*.md; do
  [[ -e "$file" ]] || { log "No prompt files found in $PROMPTS_SRC"; break; }
  basename=$(basename "$file")
  dest="$CLAUDE_PROMPTS/tico__${basename}"
  if [[ -L "$dest" ]]; then
    log "Updating symlink: $dest -> $file"
  else
    log "Creating symlink: $dest -> $file"
  fi
  run "ln -sf \"$file\" \"$dest\""
done

# Symlink CLAUDE.md (backup existing if not already a tico symlink)
log "--- Syncing CLAUDE.md ---"
if [[ -f "$CLAUDE_MD_DEST" && ! -L "$CLAUDE_MD_DEST" ]]; then
  backup="${CLAUDE_MD_DEST}.bak.$(date +%Y%m%d%H%M%S)"
  log "Backing up existing CLAUDE.md to: $backup"
  run "cp \"$CLAUDE_MD_DEST\" \"$backup\""
fi
if [[ -L "$CLAUDE_MD_DEST" ]]; then
  log "Updating symlink: $CLAUDE_MD_DEST -> $CLAUDE_MD_SRC"
else
  log "Creating symlink: $CLAUDE_MD_DEST -> $CLAUDE_MD_SRC"
fi
run "ln -sf \"$CLAUDE_MD_SRC\" \"$CLAUDE_MD_DEST\""

log "--- Done ---"
if $DRY_RUN; then
  echo "[DRY RUN] No files were modified."
else
  echo "[tico-sync] All assets synced to $CLAUDE_DIR"
fi
