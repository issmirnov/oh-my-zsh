# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2013 Yad Smood

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}g${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Hint: use print -P 'text' to preview prompts without reloading
# Visual effects: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Visual-effects.
# print correct symbol based on mode
function vi_info(){
    CMD="%{$terminfo[bold]$terminfo[underline]$fg[white]%}%U⌘%u %{$reset_color%}"
    INS="%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
    echo "${${KEYMAP/vicmd/${CMD}}/(main|viins)/${INS}}"
}

# bind vi_info into lambda
local shell_symbol='$(vi_info)'

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle reset-prompt  
  zle && zle -R
}

# Force prompt redrawing during linit init hooks and on mode change.
function zle-line-init zle-keymap-select {
    export_prompt
    zle reset-prompt
    zle -R
}

# register ZLE hooks
zle -N zle-line-init
zle -N zle-keymap-select


# Resources: http://www.nparikh.org/unix/prompt.php
function export_prompt(){
# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE 
# $ COMMAND
#
# For example:
#
# # vania @ carbon in ~/.dotfiles on git:master x
# $
# NOTE: DO NOT INDENT THESE LINES - that would add spacing to the prompt.
export PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}at \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${git_info}\
 \
%{$fg[white]%}%{$reset_color%}
${shell_symbol}"
}
