# dotfiles

zsh (oh-my-zsh), git, and iTerm2 config for macOS, managed with [yadm](https://yadm.io). This repo's work tree is `$HOME`, so every file here lives at the same path under `~`.

## New machine

```sh
# install Homebrew first if needed: https://brew.sh
brew install yadm
yadm clone git@github.com:jcwearn/dotfiles.git
```

If `~/.zshrc` or another tracked file already exists, yadm keeps your local version. In that case, check `yadm status`, and then run `yadm checkout -- ~` to take the repo's versions.

When `yadm clone` offers to run the bootstrap, say yes. To run it later, use `yadm bootstrap`. Run it from Terminal.app (not iTerm2) the first time so the iTerm2 step can apply. It's safe to re-run. [`~/.config/yadm/bootstrap`](../.config/yadm/bootstrap):

- installs Homebrew if missing, then asks before running `brew bundle --global` against `~/.Brewfile`
- clones oh-my-zsh into `~/.oh-my-zsh` if missing
- creates an empty `~/.zshrc.local`
- clones/pulls [`jcwearn/agent-config`](https://github.com/jcwearn/agent-config) into `~/.agent-config` and links it into `~/.claude/` (see below)
- points iTerm2 at `~/.config/iterm2` for its settings

Set `SKIP_BREW=1`, `SKIP_AGENT_CONFIG=1`, or `SKIP_ITERM=1` to skip those steps.

## Day to day

Edit files where they live and use `yadm` like `git`:

```sh
yadm status
yadm diff
yadm add ~/.zshrc
yadm commit -m "..."
yadm push
```

To track a new file: `yadm add ~/.config/foo/config`. yadm only tracks files you add, and `yadm status` doesn't list untracked files in `~`.

PR workflow:

```sh
yadm checkout -b feat/thing
# edit, add, commit
yadm push -u origin feat/thing
gh pr create -R jcwearn/dotfiles
```

## What's not in the repo

- **Secrets** go in `~/.zshrc.local` (mode 600, untracked), which `.zshrc` sources. For example `export HOMEASSISTANT_API_KEY=...`.
- **SSH keys.** The private key lives only in Bitwarden (item "GitHub (jcwearn)"). `SSH_AUTH_SOCK` points at the Bitwarden SSH agent, which serves that key for GitHub auth and commit signing; `.gitconfig` holds the public key inline. Install Bitwarden desktop from the Mac App Store (the agent socket path in `.zshrc` is the sandboxed build's), sign in, and enable Settings > SSH agent. Test with `ssh -T git@github.com`.
- **`~/.ssh/config`** stays out because this repo is public.
- **Age key** at `~/.age/age.key` for sops.

## agent-config

[`jcwearn/agent-config`](https://github.com/jcwearn/agent-config) holds global Claude Code policy (rules, skills, `settings.json`) and is kept as its own repo, separate from this one, since it's a different concern from shell/git/editor identity. Bootstrap clones it to `~/.agent-config` and, on every rerun:

- symlinks each `~/.agent-config/skills/<name>` into `~/.claude/skills/<name>`
- creates `~/.claude/CLAUDE.md` importing every `~/.agent-config/rules/*.md` file, but only if `~/.claude/CLAUDE.md` doesn't already exist
- merges `~/.agent-config/settings.json` into `~/.claude/settings.json` (via `jq`; machine-local keys like `theme`/`tui` are preserved, agent-config's keys win on conflict)

## iTerm2

iTerm2 loads its settings from `~/.config/iterm2/com.googlecode.iterm2.plist`. In iTerm2, open Settings > General > Settings and set "Save changes" to **Automatically**. Changes then show up in `yadm diff`.

To set this up by hand, use the same screen: check "Load settings from a custom folder or URL" and choose `~/.config/iterm2`.

## Updating the Brewfile

```sh
brew bundle dump --global --force
```
