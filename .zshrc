# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cls="clear"
alias emacs="/usr/local/bin/emacs -nw"
alias emcas="/usr/local/bin/emacs -nw"
alias ecmas="/usr/local/bin/emacs -nw"
alias enacs="/usr/local/bin/emacs -nw"
alias emasc="/usr/local/bin/emacs -nw"
alias eamcs="/usr/local/bin/emacs -nw"
alias subl="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"
alias ducks='du -cks * | sort -rn | head'
alias decodify="node -e \"try {console.log(JSON.parse(decodeURIComponent(new Buffer(process.argv[1], 'base64'))))} catch (e) { console.log('Failed to parse input')}\""

set -g default-terminal "screen-256color"
export TERM=xterm-256color
export EDITOR=emacs

bindkey '\C-p' history-beginning-search-backward
bindkey '\C-n' history-beginning-search-forward
bindkey '\C-f' forward-char
bindkey '\C-b' backward-char

# Set up zsh to work properly within emacs.  Taken from https://stackoverflow.com/questions/367442/getting-emacs-ansi-term-and-zsh-to-play-nicely
if [ -n "$INSIDE_EMACS" ]; then
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi
