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

[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

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

# Node via fnm; auto-switches on cd using .node-version / .nvmrc.
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
gcloud() {
  unfunction gcloud
  [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && . "$HOME/google-cloud-sdk/completion.zsh.inc"
  gcloud "$@"
}


export SSH_AUTH_SOCK=$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock
command -v kubectl >/dev/null && source <(kubectl completion zsh)

export SOPS_AGE_KEY_FILE=$HOME/.age/age.key
export AGE_PUBLIC_KEY=age1ssrlddcqe0jrh2g3038538wuk6uzegz49gyvak2elm7rh2ccj3pq8vnz7t

export PATH="$HOME/.local/bin:$PATH"

# Machine-local secrets/overrides (untracked).
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Loads a project's .envrc on cd (e.g. wedding-hq's service token from .env).
# Keep this last: direnv wants to run after anything else that edits the prompt hooks.
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
