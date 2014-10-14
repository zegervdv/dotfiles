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
plugins=(git z textmate sublime ruby history-substring-search brew gitfast osx terminalapp vagrant web-search gitignore brew-cask rake-fast colorize colored-man extract)

source $ZSH/oh-my-zsh.sh

# source $ZSH/plugins/history-substring-search/history-substring-search.zsh

setopt nobeep
setopt notify
REPORTTIME=5

# GRML style completion
# activate color-completion
zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

# format on completion
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
# zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'        tag-order all-expansions
zstyle ':completion:*:history-words'   list false

# activate menu
zstyle ':completion:*:history-words'   menu yes

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# match uppercase from lowercase
zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:matches'         group 'yes'
zstyle ':completion:*'                 group-name ''
if [[ "$NOMENU" -eq 0 ]] ; then
  # if there are more than 5 options allow selecting from a menu
  zstyle ':completion:*'               menu select=5
else
  # don't use any menus at all
  setopt no_auto_menu
fi

zstyle ':completion:*:messages'        format '%d'
zstyle ':completion:*:options'         auto-description '%d'

# describe options in full
zstyle ':completion:*:options'         description 'yes'

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin            \
                                           /usr/X11R6/bin

# provide .. as a completion
zstyle ':completion:*' specal-dirs ..


zstyle ':completion::*:(m|)vim:*' ignored-patterns '*.(o|hex|elf|pyc|pdf|out|aux|toc|out|fls|bbl|synctex.gz|dvi|blg|fdb_latexmk)'
# Customize to your needs...
export PATH=$PATH:/usr/local/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:/usr/local/sbin
export PATH="/usr/local/bin:$PATH"
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
alias ll="ls -altrh"
alias l="ls -lthr"
alias gsl="git sl"
alias gaa='git add --all --intent-to-add'

# Functions
gcat () {
        cat $1 | egrep "$2|$"
}

# alias ctags='$(brew --prefix ctags)/bin/ctags'

# Disable Autocorrections
alias tmux='nocorrect tmux'
# alias mvim="reattach-to-user-namespace mvim"
# alias vim="reattach-to-user-namespace vim"
# alias ag="ag --color"
alias dot="cd ~/.dotfiles"
alias ranger="EDITOR=mvim ranger"

# ag tab complete
_ag() {
  if (( CURRENT == 2 )); then
    compadd $(cut -f 1 .git/tags tmp/tags 2>/dev/null | grep -v '!_TAG')
  fi
}

compdef _ag ag

compctl -g '~/.teamocil/*(:t:r)' teamocil

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

source ~/.fzf.zsh
q() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf)"
  else
    _z "$@"
  fi
}


PERL_MB_OPT="--install_base \"/Users/zegervdv/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/zegervdv/perl5"; export PERL_MM_OPT;
