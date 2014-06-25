# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="custom"
setopt correct_all

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git z textmate sublime ruby history-substring-search brew gitfast osx terminalapp vagrant web-search gitignore brew-cask rake-fast)

source $ZSH/oh-my-zsh.sh

# source $ZSH/plugins/history-substring-search/history-substring-search.zsh

# Customize to your needs...
export PATH=$PATH:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/sbin
export PATH="/usr/local/bin:$PATH"
export PATH="$(brew --prefix ruby)/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH=$PATH:$HOME/.bin
eval "$(rbenv init -)"


export GNUTERM=X11
export SVN_EDITOR=vim

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR='vim'

export GREP_COLOR=32

# Shortcuts
alias blade="cd \"/Volumes/Blade 32GB/\""
alias p="~/Documents/projects"

# Commands
alias grep="grep --color=auto"
alias beer="bundle exec rake"
alias ll="ls -al"
alias l="ls -l"
alias gsl="git sl"

# Functions
gcat () {
        cat $1 | egrep "$2|$"
}

# alias ctags='$(brew --prefix ctags)/bin/ctags'

# Disable Autocorrections
alias tmux='nocorrect tmux'
alias mvim="reattach-to-user-namespace mvim"
alias vim="reattach-to-user-namespace vim"
alias ag="ag --color"

compctl -g '~/.teamocil/*(:t:r)' teamocil

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

source ~/.fzf.zsh
