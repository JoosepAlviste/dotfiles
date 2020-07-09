# Setup {{{

# Enable Powerlevel10k instant prompt. Should stay close to the top of 
# ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P '%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f'
    command mkdir -p $HOME/.zinit
    command git clone https://github.com/zdharma/zinit $HOME/.zinit/bin && \
        print -P '%F{33}▓▒░ %F{34}Installation successful.%f' || \
        print -P '%F{160}▓▒░ The clone has failed.%f'
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# }}}
# Settings {{{

bindkey -e  # Use emacs mode

bindkey '\^U' backward-kill-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey ';3C' forward-word
bindkey ';3D' backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export KEYTIMEOUT=1

# Save commands to the history
HISTFILE=$ZDOTDIR/zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt EXTENDED_HISTORY        # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST  # If history needs to be trimmed, evict dups first
setopt HIST_FIND_NO_DUPS       # Don't show dups when searching history
setopt HIST_IGNORE_DUPS        # Don't add consecutive dups to history
setopt HIST_IGNORE_SPACE       # Don't add commands starting with space to history
setopt HIST_VERIFY             # If a command triggers history expansion, show it instead of running
setopt SHARE_HISTORY           # Write and import history on every command

zstyle ':completion:*' menu select

# Suspend and foreground vim
foreground-nvim() {
  fg %nvim
}
zle -N foreground-nvim
bindkey '^Z' foreground-nvim

# Set word boundaries to `/` and `.` so that C-w can delete until folder
autoload -U select-word-style
select-word-style bash

if [ -e "$NVIM_LISTEN_ADDRESS" ]; then
	export EDITOR=nvr
else
	export EDITOR=nvim
fi

# }}}
# Programs {{{

# Allows setting up shims & stuff for Pyenv
zinit light zinit-zsh/z-a-bin-gem-node

# Use Zinit to automatically install some useful programs (might not be such a 
# good idea but eeh)

# sharkdp/bat
zinit ice wait lucid as'command' from'gh-r' mv'bat* -> bat' pick'bat/bat'
zinit light sharkdp/bat

# ogham/exa, replacement for ls
zinit ice wait lucid as'program' from'gh-r' mv'exa* -> exa'
zinit light ogham/exa

# denilsonsa/prettyping
zinit ice wait lucid as'program' mv'prettyping* -> prettyping' \
    atload'alias ping=prettyping'
zinit light denilsonsa/prettyping

# Pyenv
zinit ice wait as'null' lucid \
    atclone'./bin/pyenv-virtualenv-init init - > zpyenv-virtualenv.zsh' \
    atpull'%atclone' src'zpyenv-virtualenv.zsh' nocompile'!' sbin'bin/*'
zinit light pyenv/pyenv-virtualenv
zinit ice wait as'command' lucid \
    atinit'export PYENV_ROOT="$PWD"' \
    atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
    atpull'%atclone' src'zpyenv.zsh' nocompile'!' pick'bin/pyenv'
zinit light pyenv/pyenv

# FZF
zinit ice wait lucid as'program' pick"$ZPFX/bin/(fzf|fzf-tmux)" \
    atclone"cp shell/completion.zsh _fzf_completion; \
      cp bin/(fzf|fzf-tmux) $ZPFX/bin; \
      PREFIX=$ZPFX ./install --xdg --no-update-rc --key-bindings --completion" \
    atload"source $HOME/.config/fzf/fzf.zsh"
zinit light junegunn/fzf

# diff-so-fancy
zinit ice wait lucid as'program' pick'bin/git-dsf'
zinit load zdharma/zsh-diff-so-fancy

# fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# }}}
# Plugins {{{
# Use Zinit's way of installing plugins (in  T U R B O  mode)

# Zinit annexes (plugins)...

# Actual Zsh plugins...

# Some Prezto modules to improve misc stuff
zinit ice svn wait lucid
zinit snippet PZT::modules/environment
zinit ice svn wait lucid
zinit snippet PZT::modules/helper
zinit ice svn wait lucid
zinit snippet PZT::modules/spectrum
# Since the `utility` plugin adds aliases for `ls`, `l`, etc., then we need to 
# re-define those after the `utility` plugin has been loaded. So, call 
# `setup_ls_alias` callback
zinit ice svn wait lucid
zinit snippet PZT::modules/directory
zinit ice svn wait lucid
zinit snippet PZT::modules/completion

# Do not load the prompt asynchronously since it's super fast anyways!
zinit ice depth=1 atload'!source $ZDOTDIR/p10k.zsh' nocd lucid
zinit light romkatv/powerlevel10k

# Apply NVM when moving around
precmd() {
    if [ "$PWD" != "$PREV_PWD" ]; then
        PREV_PWD="$PWD";
        if [ -e ".nvmrc" ]; then
            nvm use &> /dev/null;
        fi
    fi
}

# Completion for Docker
zinit ice wait lucid as'completion'
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Docker Compose
zinit ice wait lucid as'completion'
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# Completion for Pipenv
zinit ice wait lucid atclone"cp pipenv.plugin.zsh _pipenv"
zinit snippet https://github.com/gangleri/pipenv/blob/master/pipenv.plugin.zsh

zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit'zpcompinit; zpcdreplay' nocd
zinit light zdharma/fast-syntax-highlighting

# history-substring-search for smarter up/down arrow
# MUST be after fast-syntax-highlighting
zinit ice wait lucid atload'setup_history_substring_search' nocd
zinit light zsh-users/zsh-history-substring-search
setup_history_substring_search() {
    export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
}

zinit ice wait lucid atload'_zsh_autosuggest_start' nocd
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light MichaelAquilina/zsh-autoswitch-virtualenv

# Auto-activate environment
zinit ice wait lucid
zinit light darvid/zsh-poetry

# Zoxide - fast Z alternative
# `cargo install zoxide`
zinit ice wait lucid
zinit light agkozak/zsh-z

zinit ice wait lucid src"manydots-magic"
zinit light knu/zsh-manydots-magic


# }}}
# Aliases {{{

# Base
alias sudo='sudo -E'  # Use current user configs
alias grep='grep  --color=auto --exclude-dir={.git}'
alias c='clear'

# Navigation
alias dev='cd ~/Devel'
alias projects='cd ~/Devel/Projects'
alias work='cd ~/Devel/Work'

# Programs
alias vim='nvim'
alias v='vim'
alias r='ranger'
alias e=$EDITOR

alias up='docker-compose up'
alias down='docker-compose down'
alias build='docker-compose build'
alias dps='docker ps'

# Add `--directory XYZ` if needed
alias server='python -m http.server 3030'

alias tree='tree -aC -I .git -I node_modules'

take() {
    # Create a directory and cd into it
    mkdir -p $@ && cd ${@:$#}
}

# Git
alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gco='git checkout'

alias gd='git diff'

alias gl='git pull'
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'

alias gm='git merge'

alias gp='git push'

alias gst='git status'

# Transmission
alias tsm-start='transmission-daemon'
alias tsm='transmission-remote -l'
tsm-add() { transmission-remote -a "$1" ;}


# Utils & alternatives

alias ls='exa --group-directories-first'
alias ll='ls -la'
alias l='ls -1'

alias p='sudo pacman'

alias cat='bat'
alias ping='prettyping --nolegend'

alias preview="fzf --preview 'bat --color \"always\" {}'"
THEME="material-palenight"
if [ "$THEME" = "OceanicNext" ]; then
    export FZF_DEFAULT_OPTS="
        --bind='ctrl-o:execute(nvim {})+abort' 
        --inline-info
        --color=bg+:#1b2b34,bg:#16242c,spinner:#c594c5,hl:#6699cc
        --color=fg:#c0c5ce,header:#586e75,info:#fac863,pointer:#c594c5
        --color=marker:#fac863,fg+:#c0c5ce,prompt:#c594c5,hl+:#c594c5
    "
elif [ "$THEME" = "material-palenight" ]; then
    export FZF_DEFAULT_OPTS="
        --bind='ctrl-o:execute(nvim {})+abort' 
        --inline-info
        --color=bg+:#212331,bg:#252837,spinner:#c594c5,hl:#82aaff
        --color=fg:#a6accd,header:#7982B4,info:#ffcb6b,pointer:#c792ea
        --color=marker:#ffcb6b,fg+:#a6accd,prompt:#c792ea,hl+:#c792ea
    "
elif [ "$THEME" = "tender" ]; then
    export FZF_DEFAULT_OPTS="
        --bind='ctrl-o:execute(nvim {})+abort' 
        --inline-info
    "
fi
if type ncdu > /dev/null; then
    alias du='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
fi
if type tldr > /dev/null; then
    alias help='tldr'
fi
if type brew > /dev/null; then
    steep() {
        brew update
        brew upgrade
        brew cask upgrade
        brew cleanup
    }
fi
if type hub > /dev/null; then
    alias git='hub'
fi

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-javascript}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# Thorgate
if [[ -d "$HOME/Programs/temposync" ]]; then
    alias temposync='(cd ~/Programs/temposync && pipenv run python main.py clockify)'
fi

# NVM
# Function to set up NVM
setup_nvm() {
    # Load manually installed NVM into the shell session.
    if [[ -s "${NVM_DIR:=$HOME/.nvm}/nvm.sh" ]]; then
        source "${NVM_DIR}/nvm.sh"

    # Load package manager installed NVM into the shell session.
    elif (( $+commands[brew] )) && \
      [[ -d "${nvm_prefix::="$(brew --prefix 2> /dev/null)"/opt/nvm}" ]]; then
      source "$(brew --prefix nvm)/nvm.sh"
      unset nvm_prefix
    fi
}
# NVM is not loaded on shell startup since it's slow. Also, loading it in turbo 
# mode freezes the command prompt for a bit. So, we need to set up NVM only 
# when actually required -- when the `nvm` command is used or any other Node 
# commands.
declare -a NODE_GLOBALS=(`find ~/.config/nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")
for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; setup_nvm; ${cmd} \$@ }"
done

# }}}
# Startup {{{

# Start graphical server if i3 not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep -x i3 || exec startx
fi

(( ! ${+functions[p10k]} )) || p10k finalize

# }}}
# Overview {{{
set modelines=3
# Custom folding for this file
# vim:foldmethod=marker:foldlevel=0
# }}}
