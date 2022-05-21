if type brew &>/dev/null
then
  fpath+="$(brew --prefix)/share/zsh/site-functions"
fi

fpath+="$ZDOTDIR/.packages/zsh-completions/src"

autoload -U compinit; compinit
_comp_options+=(globdots)  # With hidden files

# tabtab source for packages
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

zstyle ':completion:*' menu select  # Nice styling for completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'  # Case insensitive completion
zstyle ':completion:*' expand prefix suffix  # Do not require typing beginning of filename for completion

zstyle ':completion:*:*:*:*:descriptions' format '-- %d --'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# Completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
