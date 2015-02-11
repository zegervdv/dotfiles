# Listing directories and files
alias l="ls -ltrhG"
alias ll="ls -althrG"

# Git shortcuts
alias g='git'
alias ga='git add'
alias gaa='git add --all --intent-to-add'
alias gap='git add --patch'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcm='git checkout master'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gd='git diff'
alias gm='git merge'
alias gp='git push'
alias gup='git pull'
alias gr='git rebase'
alias grhh='git reset --hard HEAD'
alias gsl='git sl'
alias gst='git status'
alias gsta='git stash'
alias gstap='git stash apply'

# Quick access to directories
alias dot='cd ~/.dotfiles'

# Bundle
alias beer='bundle exec rake'

# Ranger
alias ranger="EDITOR=vim ranger"

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias /='cd /'

alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias d='dirs -v | head -10'

# Open existing sessions
alias vims='vim -S Session.vim'
