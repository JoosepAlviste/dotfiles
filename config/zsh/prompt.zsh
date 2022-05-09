# My custom, minimal prompt

# Options
setopt PROMPT_SUBST

# Dependency on oh-my-zsh shrink-path script. Could probably copy the useful 
# parts for myself, but it's easy to just add a dependency. We're not using the 
# rest of oh-my-zsh anyways.
source $ZDOTDIR/.packages/ohmyzsh/plugins/shrink-path/shrink-path.plugin.zsh

# Populate version control info
# See: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
autoload -Uz vcs_info
myprompt_precmd() {
  vcs_info
}

typeset -a precmd_functions
precmd_functions+=(myprompt_precmd)

# VCS utility configuration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%%F{green}%25>…>%b%f%<<%c%u '
zstyle ':vcs_info:git:*' actionformats '%%F{green}%25>…>%b%f%<< %F{red}%a%f '

# Check if the Git project is dirty (has uncommitted changes)
parse_git_dirty() {
  if (! command git rev-parse --is-inside-work-tree > /dev/null 2>&1) || (command git diff-index --quiet HEAD 2> /dev/null); then
    echo ""
  else
    echo "%F{red}✱%f "
  fi
}

STARTTIME='0'
ELAPSED='0'
myprompt_preexec() {
  STARTTIME=$SECONDS
}
myprompt_precmd_time() {
  ELAPSED=$(( $SECONDS-$STARTTIME ))
}
typeset -a preexec_functions
preexec_functions+=(myprompt_preexec)
precmd_functions+=(myprompt_precmd_time)

# Show the time the previous command took (but only if it took a significant 
# amount of time)
myprompt_previous_elapsed_time() {
  if (( ${ELAPSED:-0} > 0 )); then
    echo "%F{yellow}${ELAPSED}s%f"
  fi
}

# Current working directory path in a nice way
myprompt_path() {
  echo "%F{blue}$(shrink_path -f)%f"
}

# Git information (branch, dirty indicator)
myprompt_git() {
  echo "${vcs_info_msg_0_}$(parse_git_dirty)"
}

# If last command was successful (return 0), then green arrow, otherwise red
myprompt_char() {
  echo '%F{%(?.green.red)}❯%f'
}

PROMPT='$(myprompt_path) $(myprompt_git)$(myprompt_char) '
RPROMPT='$(myprompt_previous_elapsed_time)'
