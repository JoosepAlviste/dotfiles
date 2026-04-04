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

alias nx='pnpm exec nx'

# Add `--directory XYZ` if needed
alias server='python -m http.server 3030'

alias tree='tree -aC -I .git -I node_modules'

alias a="source $HOME/dotfiles/bin/project"

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
alias gpf='git push --force'
alias gst='git status'
alias gs='git stash'
alias gsp='git stash pop'
alias lg='lazygit'


# Utils & alternatives

alias ls='eza --group-directories-first'
alias ll='ls -la'
alias l='ls -1'

alias p='pnpm'

alias cat='bat'
alias ping='prettyping --nolegend'

alias preview="fzf --preview 'bat --color \"always\" {}'"
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

# Delete all node_modules folders in the current directory, recursively
alias clean-node-modules="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"

# Cleaning up ~
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"
