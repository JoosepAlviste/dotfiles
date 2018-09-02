# # PATH {{{

export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.composer/vendor/bin:$PATH
export PATH=/usr/local/opt/python@2/bin:$PATH
export PATH=/usr/local/opt/gettext/bin:$PATH

export NODE_ENV=development

# }}}
# ## Env variables {{{

# Java
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export JAVA_HOME="$(jenv javahome)"

# Oh my zsh
export ZSH=~/.oh-my-zsh

# Set language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Colorls
source $(dirname $(gem which colorls))/tab_complete.sh

# }}}
# # Oh my zsh {{{

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  composer
  laravel5
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# }}}
# # Aliases {{{
alias cd..="cd .."
alias p="vendor/bin/phpunit"
alias pf="p --filter"
alias art="php artisan"

alias vim=nvim

# Docker compose
alias up='docker-compose up'
alias down='docker-compose down'
alias build='docker-compose build'

# Useful alternatives/aliases
if type bat > /dev/null; then
    alias cat='bat'
fi
if type prettyping > /dev/null; then
    alias ping='prettyping --nolegend'
fi
if type fzf > /dev/null; then
    alias preview="fzf --preview 'bat --color \"always\" {}'"
    export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(nvim {})+abort'"
fi
if type ncdu > /dev/null; then
    alias du='ncdu --color dark -rr -x --exclude .git --exclude node_modules'
fi
if type tldr > /dev/null; then
    alias help='tldr'
fi
if type hub > /dev/null; then
    alias git='hub'
fi
# }}}
# # Visuals {{{

ZSH_THEME=""

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# }}}
# # Packages {{{

# Python Virtualenv
VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@2/bin/python2
source /usr/local/bin/virtualenvwrapper.sh

# Z
source /usr/local/etc/profile.d/z.sh

# }}}
# # Generic {{{

# Use vim as the default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Use up/down arrow to search history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Use a better command for searching with fzf
export FZF_DEFAULT_COMMAND='ag -l --hidden .'

# Zsh syntax highlighting. Must be at the end of the file!
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# }}}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# # Overview {{{
set modelines=3
# Custom folding for this file
# vim:foldmethod=marker:foldlevel=0
# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
