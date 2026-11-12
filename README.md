# dotfiles

zsh (oh-my-zsh), git, and iTerm2 config for macOS.

## New machine

```sh
git clone git@github.com:jcwearn/dotfiles.git ~/Documents/dotfiles
cd ~/Documents/dotfiles
./install.sh
```

Run it from Terminal.app (not iTerm2) the first time so the iTerm2 step can apply. `install.sh` is safe to re-run. It:

- installs Homebrew if missing, then asks before running `brew bundle` against `Brewfile`
- clones oh-my-zsh into `~/.oh-my-zsh` if missing
- symlinks `~/.zshrc`, `~/.gitconfig`, and `~/.config/git/ignore` into this repo (existing files are moved to `*.bak.<timestamp>`)
- creates an empty `~/.zshrc.local`
- points iTerm2 at `iterm2/` for its settings

Set `SKIP_BREW=1` or `SKIP_ITERM=1` to skip those steps.

## What's not in the repo

- **Secrets** go in `~/.zshrc.local` (mode 600, untracked), which `.zshrc` sources. For example `export HOMEASSISTANT_API_KEY=...`.
- **SSH keys.** Commits are SSH-signed with `~/.ssh/id_ed25519.pub`, and `SSH_AUTH_SOCK` points at the Bitwarden SSH agent. Install Bitwarden desktop with the SSH agent enabled and put the public key at that path.
- **`~/.ssh/config`** stays out because this repo is public.
- **Age key** at `~/.age/age.key` for sops.

## iTerm2

iTerm2 loads its settings from `iterm2/com.googlecode.iterm2.plist`. In iTerm2, open Settings > General > Settings and set "Save changes" to **Automatically**. After that, settings changes show up as diffs in this repo; commit them like any other change.

To set this up by hand, use the same screen: check "Load settings from a custom folder or URL" and choose this repo's `iterm2/` folder.

## Updating the Brewfile

```sh
brew bundle dump --file=Brewfile --force
```

## Older clones (`master` → `main`)

The default branch was renamed to `main`. In an existing clone:

```sh
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```
