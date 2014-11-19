source ~/.zsh/colors.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/history.zsh
source ~/.zsh/zsh_hooks.zsh

# Plugins
source ~/.fzf.zsh
source ~/.zsh/zsh-history-substring-search.zsh
source ~/.zsh/z.sh
# source ~/.zsh/plugins/zsh-autosuggestions/autosuggestions.zsh

precmd() {
  if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
    tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
  fi
}

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
