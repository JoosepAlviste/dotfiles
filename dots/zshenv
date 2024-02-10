# Set up simple environment variables

# Set up XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
    XDG_RUNTIME_DIR=/tmp
fi
export XDG_RUNTIME_DIR

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export GPG_TTY=$TTY

# Applications
export BROWSER='open'
export TERMINAL='kitty'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

export ZK_NOTEBOOK_DIR="$HOME/Dropbox/notes"

# Clean up ~

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

# FZF styles
export FZF_DEFAULT_OPTS="
--bind='ctrl-o:execute(nvim {})+abort' 
--inline-info
--color=bg+:#16161D,spinner:#957FB8,hl:#7E9CD8
--color=fg:#DCD7BA,header:#C8C093,info:#E6C384,pointer:#957FB8
--color=marker:#E6C384,fg+:#DCD7BA,prompt:#957FB8,hl+:#957FB8
"

# Java
if [[ -d "/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home" ]]; then
    export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
fi

# Android
if [[ -d "$HOME/Library/Android/sdk" ]]; then
    export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    export ANDROID_HOME=$HOME/Library/Android/sdk
fi

# XDebug
export XDEBUG_CONFIG="idekey=VSCODE"
