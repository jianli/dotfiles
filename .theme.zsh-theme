PROMPT='%{$fg_bold[red]%}➜%{$reset_color%}%{$fg_bold[cyan]%} ${PWD/$HOME/~}%{$reset_color%} $(git_prompt_info) '

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg_bold[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
