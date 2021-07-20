# Z4H setup {{{
# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Automaticaly wrap TTY with a transparent tmux ('integrated'), or start a
# full-fledged tmux ('system'), or disable features that require tmux ('no').
zstyle ':z4h:' start-tmux       'no'
# Move prompt to the bottom when zsh starts up so that it's always in the
# same position. Has no effect if start-tmux is 'no'.
zstyle ':z4h:' prompt-at-bottom 'no'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# ssh when connecting to these hosts.
# zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over ssh to the
# enabled hosts.
# zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Override the terminal tab title to show the current directory name
zstyle ':z4h:term-title:*' precmd '$(basename $(pwd))'
zstyle ':z4h:term-title:*' preexec '$(basename $(pwd))'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
# z4h install ohmyzsh/ohmyzsh || return
z4h install docker/cli || return
z4h install docker/compose || return
z4h install agkozak/zsh-z || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return
# }}}
# Environment {{{
# Export environment variables.
export GPG_TTY=$TTY

export BROWSER='open'
export TERMINAL='kitty'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# Clean up ~
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
    XDG_RUNTIME_DIR=/tmp
fi
export XDG_RUNTIME_DIR

export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

export JUPYTER_CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/jupyter
export MPLCONFIGDIR=${XDG_CONFIG_HOME:-$HOME/.config}/matplotlib

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export npm_config_devdir=$XDG_CONFIG_HOME/node-gyp

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

# Z
export ZSHZ_DATA="$XDG_DATA_HOME/z/z"

# Android
export ANDROID_SDK_ROOT="$XDG_CONFIG_HOME/android"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME/android/"
export ANDROID_AVD_HOME="$XDG_DATA_HOME/android/avd/"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

export LESSHISTFILE="-"

# Use a better command for searching with fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --ignore-file ~/.config/ripgrep/ignore'

# Java
if [[ -d "/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home" ]]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
fi

# Android
if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    export ANDROID_HOME=$HOME/Library/Android/sdk
fi

# Extend PATH.
path=(
  /usr/local/{bin,sbin}
  $HOME/dotfiles/bin
  $ANDROID_SDK_ROOT/emulator
  $ANDROID_SDK_ROOT/tools
  $ANDROID_SDK_ROOT/tools/bin
  $ANDROID_SDK_ROOT/platform-tools
  $path
)

# Source additional local files if they exist.
z4h source ~/.env.zsh
# }}}
# Bindings {{{

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h source $Z4H/ohmyzsh/ohmyzsh/lib/diagnostics.zsh
# z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/emoji-clock/emoji-clock.plugin.zsh
z4h source $Z4H/agkozak/zsh-z/zsh-z.plugin.zsh
fpath+=(
  $Z4H/docker/cli/contrib/completion/zsh
  $Z4H/docker/compose/contrib/completion/zsh
)

# Define key bindings.
z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Clear screen with ctrl+o (ctrl+l is used to navigate Vim splits)
z4h bindkey clear-screen Ctrl+O

# Edit command with Vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Suspend and foreground vim with ctrl+z
foreground-nvim() {
  fg %nvim
}
zle -N foreground-nvim
bindkey '^Z' foreground-nvim
# }}}

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function touch() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories touch

# Define named directories: ~w <=> Windows home directory on WSL.
# [[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Aliases {{{

# Base
alias sudo='sudo -E'  # Use current user configs
alias grep='grep  --color=auto --exclude-dir={.git}'
alias c='clear'
alias tree='tree -a -I .git'

# Programs
alias vim='nvim'
alias v='nvim'
alias r='ranger'
if type /Applications/love.app/Contents/MacOS/love > /dev/null; then
  alias love='/Applications/love.app/Contents/MacOS/love'
fi

alias up='docker compose up'
alias down='docker compose down'
alias build='docker compose build'
alias logs='docker compose logs --follow'
alias dps='docker ps'

# Add `--directory XYZ` if needed
alias server='python -m http.server 3030'

alias tree='tree -aC -I .git -I node_modules'

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
alias lg='lazygit'


# Utils & alternatives

alias ls='exa --group-directories-first'
alias ll='ls -la'
alias l='ls -1'

alias p='sudo pacman'

alias cat='bat'
alias ping='prettyping --nolegend'

alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="
--bind='ctrl-o:execute(nvim {})+abort' 
--inline-info
--color=bg+:#212331,bg:#252837,spinner:#c594c5,hl:#82aaff
--color=fg:#a6accd,header:#7982B4,info:#ffcb6b,pointer:#c792ea
--color=marker:#ffcb6b,fg+:#a6accd,prompt:#c792ea,hl+:#c792ea
"
if type tldr > /dev/null; then
  alias help='tldr'
fi
if type hub > /dev/null; then
  alias git='hub'
fi
# `trash-put` can be installed from `trash-cli`
if type trash-put > /dev/null; then
  alias trash='trash-put'
fi

# Cleaning up ~
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# }}}

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Source local zsh config file if it has been created
 [[ -f ~/.config/zsh/zprofile.local ]] && source ~/.config/zsh/zprofile.local
# Overview {{{
set modelines=3
# Custom folding for this file
# vim:foldmethod=marker:foldlevel=0
# }}}
