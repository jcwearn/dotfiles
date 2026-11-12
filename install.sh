#!/bin/bash
# Set up this Mac from the dotfiles repo. Safe to re-run.
#   SKIP_BREW=1   skip Homebrew install / brew bundle
#   SKIP_ITERM=1  skip pointing iTerm2 at iterm2/
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { echo "[dotfiles] $*"; }

backup_if_needed() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    local ts
    ts="$(date +%Y%m%d_%H%M%S)"
    mv -f "$target" "${target}.bak.${ts}"
    log "Backed up $target -> ${target}.bak.${ts}"
  fi
}

link_dotfile() {
  local name="$1"
  local src="${DOTFILES_DIR}/${name}"
  local dst="${HOME}/${name}"

  if [ ! -e "$src" ]; then
    log "Skipping ${name}: not found in repo at $src"
    return 0
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "Symlink already correct: $dst -> $src"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  backup_if_needed "$dst"
  ln -s "$src" "$dst"
  log "Linked $dst -> $src"
}

install_brew() {
  if [ "${SKIP_BREW:-}" = 1 ]; then
    log "SKIP_BREW=1, skipping Homebrew"
    return 0
  fi

  if ! command -v brew >/dev/null && [ ! -x /opt/homebrew/bin/brew ]; then
    log "Installing Homebrew"
    local installer
    installer="$(mktemp)"
    curl -fsSL -o "$installer" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    /bin/bash "$installer"
    rm -f "$installer"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"

  local reply
  read -r -p "[dotfiles] Run 'brew bundle' to install packages from Brewfile? [y/N] " reply
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    brew bundle --file="${DOTFILES_DIR}/Brewfile"
  fi
}

install_oh_my_zsh() {
  if [ -d "${HOME}/.oh-my-zsh" ]; then
    log "oh-my-zsh already installed"
    return 0
  fi
  log "Installing oh-my-zsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"
}

ensure_zshrc_local() {
  local f="${HOME}/.zshrc.local"
  if [ ! -e "$f" ]; then
    (umask 077 && echo "# Machine-local secrets and overrides; not tracked in git." > "$f")
    log "Created $f (add secrets like HOMEASSISTANT_API_KEY here)"
  fi
}

setup_iterm() {
  if [ "${SKIP_ITERM:-}" = 1 ]; then
    log "SKIP_ITERM=1, skipping iTerm2"
    return 0
  fi

  local folder="${DOTFILES_DIR}/iterm2"
  if [ "$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null || true)" = "$folder" ]; then
    log "iTerm2 already loads settings from $folder"
    return 0
  fi

  if pgrep -xq iTerm2; then
    log "iTerm2 is running. Quit it and re-run this script from Terminal.app to set up iTerm2 settings."
    return 0
  fi

  defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$folder"
  defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
  log "iTerm2 will load settings from $folder"
  log "In iTerm2: Settings > General > Settings, set 'Save changes' to Automatically"
}

install_brew
install_oh_my_zsh

link_dotfile .zshrc
link_dotfile .gitconfig
link_dotfile .config/git/ignore

ensure_zshrc_local
setup_iterm

log "Done. Open a new shell to pick up changes."
