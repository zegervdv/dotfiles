function get_pwd() {
   echo "${PWD/$HOME/~}"
}

eval my_gray='$FG[237]'
eval my_orange='$FG[214]'


local git=$(git_prompt_info)
if [ ${#git} != 0 ]; then
    ((git=${#git} - 10))
else
    git=0
fi

local my_prompt_name='%n'  
[[ "$SSH_CONNECTION" != '' ]] && my_prompt_name='%n@%m'

PROMPT='%{$fg[cyan]%}$my_prompt_name%{$reset_color%} in %{$fg[yellow]%}%~%b%{$reset_color%}
%{$reset_color%}%(1j.%j .)%(?.%{$fg[white]%}.%{$fg[red]%})→ %{$reset_color%}'


RPROMPT='$my_gray$(git_prompt_info) $(git_prompt_status)%{$reset_color%}%'

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
