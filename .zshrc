# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

if [ -n "$TMUX" ] && [ "$(tmux display-message -p '#S' 2>/dev/null)" = "firstmate" ]; then
  ZSH_THEME="robbyrussell"
  zstyle ':omz:update' mode disabled   # never prompt or update inside worker shells
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

eval $(/opt/homebrew/bin/brew shellenv)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ls="ls -lartGh"
alias k=kubectl

export TERM=xterm-256color
export EDITOR=emacs

bindkey '\C-p' history-beginning-search-backward
bindkey '\C-n' history-beginning-search-forward
bindkey '\C-f' forward-char
bindkey '\C-b' backward-char

export NVM_DIR="$HOME/.nvm"
# Put the newest installed node on PATH directly (your default alias is "node" = newest),
# and load nvm itself only when you actually call it (saves 0.31s per shell).
_nvm_newest=$(command ls "$NVM_DIR/versions/node" 2>/dev/null | sort -V | tail -1)
[ -n "$_nvm_newest" ] && export PATH="$NVM_DIR/versions/node/$_nvm_newest/bin:$PATH"
unset _nvm_newest
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jackson/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jackson/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
gcloud() {
  unfunction gcloud
  [ -f '/Users/jackson/google-cloud-sdk/completion.zsh.inc' ] && . '/Users/jackson/google-cloud-sdk/completion.zsh.inc'
  gcloud "$@"
}


export SSH_AUTH_SOCK=/Users/jackson/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
source <(kubectl completion zsh)

export SOPS_AGE_KEY_FILE=/Users/jackson/.age/age.key
export AGE_PUBLIC_KEY=age1ssrlddcqe0jrh2g3038538wuk6uzegz49gyvak2elm7rh2ccj3pq8vnz7t

export PATH="$HOME/.local/bin:$PATH"

# Machine-local secrets/overrides (untracked).
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Loads a project's .envrc on cd (e.g. wedding-hq's service token from .env).
# Keep this last: direnv wants to run after anything else that edits the prompt hooks.
eval "$(direnv hook zsh)"
