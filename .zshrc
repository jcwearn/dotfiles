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
alias ls="ls -lartGh"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias ducks='du -cks * | sort -rn | head'
alias decodify="node -e \"try {console.log(JSON.parse(decodeURIComponent(new Buffer(process.argv[1], 'base64'))))} catch (e) { console.log('Failed to parse input')}\""
alias showfiles="defaults write com.apple.finder AppleShowAllFiles TRUE"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles FALSE"
alias gradlew="/Users/jacksonwearn/Documents/cnn/metabuild/gradlew"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

UUID=$(uuidgen)

export EMACSCLIENT="/usr/local/bin/emacsclient -nw --socket-name=$UUID"
export ALTERNATE_EDITOR="/usr/local/bin/emacs --daemon=$UUID"
alias emacs=$EMACSCLIENT
alias emcas=$EMACSCLIENT
alias ecmas=$EMACSCLIENT
alias enacs=$EMACSCLIENT
alias emasc=$EMACSCLIENT
alias eamcs=$EMACSCLIENT
alias emac=$EMACSCLIENT
export EDITOR=$EMACSCLIENT
export VISUAL=$EDITOR

# function getPWD() { pwd }
# EMACS_CLIENT=/usr/local/bin/emacsclient
# EMACS_SERVER=/usr/local/bin/emacs
# EMACS_CLIENT=/usr/local/bin/emacsclient
# EMACS_SERVER=/usr/local/bin/emacs
# ALTERNATE_EDITOR="$EMACS_SERVER --daemon=$(getPWD)"
# EMACS="$EMACS_CLIENT -nw --alternate-editor=\"$ALTERNATE_EDITOR\" --socket-name=$(getPWD)"
# alias emacs=$EMACS
# alias emcas=$EMACS
# alias ecmas=$EMACS
# alias enacs=$EMACS
# alias emasc=$EMACS
# alias eamcs=$EMACS
# alias emac=$EMACS
# export EDITOR=$EMACS
# export VISUAL=$EDITOR
