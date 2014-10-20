function get_pwd() {
   echo "${PWD/$HOME/~}"
}

eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_PREFIX=""
GIT_PROMPT_SUFFIX=""
GIT_PROMPT_AHEAD="%{$fg[red]%} +NUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[green]%} -NUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} U%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[blue]%} M%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%} A%{$reset_color%}"
 
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} U"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} A"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} D"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} R"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} M"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} U"

ZSH_THEME_GIT_PROMPT_PREFIX="${my_gray}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_gray%{$reset_color%}"

function parse_git_state() {
# Compose this value via multiple conditional appends.
  local GIT_STATE=""
 
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
 
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
 
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
 
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
 
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
 
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
 
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}
# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "on %{$fg[blue]%}${git_where#(refs/heads/|tags/)}$(parse_git_state)"
}
local my_prompt_name='%n'  
[[ "$SSH_CONNECTION" != '' ]] && my_prompt_name='%n@%m'

PROMPT='%{$fg[cyan]%}$my_prompt_name%{$reset_color%} in %{$fg[yellow]%}%~%b%{$reset_color%}
%{$reset_color%}%(1j.%j .)%(?.%{$fg[white]%}.%{$fg[red]%})→ %{$reset_color%}'


RPROMPT='$my_gray $(git_prompt_string)%{$reset_color%}%'

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} U"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} A"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} D"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} R"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} M"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} U"

ZSH_THEME_GIT_PROMPT_PREFIX="${my_gray}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_gray%{$reset_color%}"


