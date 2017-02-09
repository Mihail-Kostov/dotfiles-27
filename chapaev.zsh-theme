# ------------------------------------------------------------------------
# Tyler Cipriani
# oh-my-zsh theme
# Totally ripped off Dallas theme
# ------------------------------------------------------------------------

# Grab the current date (%W) and time (%t):
#CHAPAEV_TIME_="%{$fg[white]%}[%{$fg[yellow]%}%w%{$reset_color%} %{$fg[yellow]%}%T]%{$reset_color%}"
CHAPAEV_TIME_="%{$fg[white]%}[%{$fg[yellow]%}%T]%{$reset_color%}"

# Grab the current machine name
CHAPAEV_MACHINE_="%{$fg[blue]%}@%m%{$fg[white]%}: %{$reset_color%}"

# Grab the current username
CHAPAEV_CURRENT_USER_="%{$fg[blue]%}%n%{$reset_color%}"

# Grab the current filepath, use shortcuts: ~/Desktop
# Append the current git branch, if in a git repository: ~aw@master
CHAPAEV_LOCA_="%{$fg[green]%}%~\$(git_prompt_info)%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}(%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✚ "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✖ "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[082]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[166]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[160]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[082]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[190]%}✭%{$reset_color%}"

PROMPT="$CHAPAEV_TIME_$CHAPAEV_CURRENT_USER_$CHAPAEV_MACHINE_$CHAPAEV_LOCA_: "
#PROMPT="$CHAPAEV_MACHINE_$CHAPAEV_LOCA_: "


