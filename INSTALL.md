# Installing and Updating tico-os

tico-os is a Claude Code plugin. Installing it gives Claude, in VS Code and in the terminal
alike, the `/tico-os:` commands, the research agents, the board script, and the house rules
that load at the start of every session. This page explains how to install it on a new
machine, how to pick up changes after they're merged, and what to do when something doesn't
show up. For what the plugin does once it's installed, see [GUIDE.md](GUIDE.md).

## Before you start

You need:

- **VS Code with the Claude Code extension**, signed in. (A standalone `claude` command in
  the terminal works too, but isn't required.)
- **The GitHub CLI, `gh`, signed in with the `project` scope**, so the skills can update
  the board. Check with `gh auth status`; if `project` isn't listed under the token
  scopes, run `gh auth refresh -s project`.
- **`git` and `python3`**, which macOS provides.

The plugin is installed from the public GitHub repo, so installing it needs no extra
credentials.

## Why there's a script

Claude Code plugins are normally managed with `/plugin` commands typed into a chat, but the
VS Code chat doesn't accept them. Instead, plugins are installed with Claude Code's
command-line tool, which VS Code doesn't put on your `PATH`: it's bundled inside the
extension's folder. [`scripts/plugin.sh`](scripts/plugin.sh) finds that bundled copy (or a
standalone `claude`, if you have one) and runs the right commands. Because the command-line
tool and the VS Code chat share the same settings in `~/.claude`, whatever it installs
appears in VS Code after a reload.

## Install (once per machine)

1. Clone the repo, if it isn't already:

   ```bash
   gh repo clone evensteven01/tico-os ~/Development/tico-os
   ```

2. Run the installer:

   ```bash
   ~/Development/tico-os/scripts/plugin.sh install
   ```

   It registers this repo as a plugin source (a "marketplace") and installs the plugin for
   your user account, so it's active in every folder you open.

3. Reload VS Code: press **Cmd+Shift+P** and run **Developer: Reload Window**.

4. Open a **new** chat. Chats that were already open don't pick up a newly installed
   plugin.

If you'd rather run the commands yourself, the script runs these two:

```bash
claude plugin marketplace add evensteven01/tico-os
claude plugin install tico-os@tico-os
```

`tico-os@tico-os` means "the plugin named tico-os, from the marketplace named tico-os."
Replace `claude` with the bundled copy's path if you don't have a standalone one;
`plugin.sh status` prints that path.

## Check that it worked

In a new chat in VS Code:

1. Type `/tico-os:`. The list of commands (`new-idea`, `evaluate-idea`, `portfolio` and
   the rest) should appear.
2. Ask "what are your house rules?" Claude should answer straight away, without looking
   anything up. That means the session-start hook ran.

From a terminal, `scripts/plugin.sh status` shows the installed version.

## Updating after a change is merged

Merging a change into tico-os does **not** update your installed copy. Claude Code keeps
its own copy of the plugin, taken from `main` at install time. To pick up merged changes:

```bash
~/Development/tico-os/scripts/plugin.sh update
```

Then type **`/reload-plugins`** in each open chat that should get the change. It loads the
new version's skills, agents and hooks in place, so there's no need to reload VS Code or
start a new chat. Reloading the window still works if a chat doesn't pick it up.

**Bump the version with every change.** Claude Code stores installed copies by version
number (under `~/.claude/plugins/cache/tico-os/tico-os/<version>/`). Any PR that changes the
plugin should raise `version` in [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json),
or `update` may decide there's nothing new. Use a patch bump (0.3.0 → 0.3.1) for fixes and
wording, and a minor bump (0.3.x → 0.4.0) for new skills or changed behavior.

Edits to the playbook or the idea template in `proj-incubator` don't need any of this,
because the skills read those files fresh every time.

## Uninstall

```bash
claude plugin uninstall tico-os@tico-os
claude plugin marketplace remove tico-os   # optional: also forget the source
```

## Troubleshooting

| Symptom | What to do |
|---|---|
| `/plugin` in the VS Code chat says it isn't available | Expected. Use `scripts/plugin.sh` from a terminal instead. |
| `/tico-os:` commands don't appear | Run `plugin.sh status` to confirm it's installed and enabled, then reload the window and open a **new** chat. |
| A merged change isn't showing up | Check that the PR bumped the version, run `plugin.sh update`, then `/reload-plugins` in the chat (or reload the window). |
| `plugin.sh` says no Claude Code CLI was found | Install or update the Claude Code extension in VS Code. The script looks in `~/.vscode/extensions/`. |
| The board script fails with a permissions error | `gh auth status` should list the `project` scope; if not, run `gh auth refresh -s project`. |
| The house rules don't load | Run `plugin.sh status` to check the plugin is enabled. The rules come from a session-start hook, so they only appear in chats started after the reload. |
