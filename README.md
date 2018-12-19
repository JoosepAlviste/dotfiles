# My dotfiles

Since this project uses git submodules for some things (tmux plugins), it needs
to be cloned with submodules.

```
git clone --recurse-submodules git@github.com:JoosepAlviste/dotfiles.git
```

## Requirements

* Zsh
* Spaceship prompt or pure prompt
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

### Utilities

If these are installed, will be aliased.

* [bat](https://github.com/sharkdp/bat) - `cat` replacement
* [prettyping](https://github.com/denilsonsa/prettyping) - `ping` replacement
* [tldr](http://tldr.sh/) - simpler `man` pages, aliased to `help`
* [hub](https://github.com/github/hub) - `git` replacement, integrates with github

Just useful utilities:

* [fd](https://github.com/sharkdp/fd/) - simpler `find` replacement
* [noti](https://github.com/variadico/noti) - notifications when processes end

### Autocomplete:

* Vim compiled with python 3
* Globally installed `neovim` package with pip3
    - `pip3 install neovim`
* [vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
* [deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* Language servers for autocompletion

### Ctags:

* [Universal ctags](https://github.com/universal-ctags/ctags) for better ctags 
(React files, etc.). Can just be installed with brew.

### Fzf

Fuzzy finder.

* Needs fzf installed globally (from brew)
    - If it is not installed, it will be installed as a vim plugin though
* Needs `ag` for smarter file searching

### i3

* i3
* platerctl - media controls
* feh - wallpaper
* compton - opacity
* rofi - better dmenu
* ~i3blocks - status bar info~
* xkblayout-state
    * Probably needs `apt install libx11-dev`
* polybar
* maim + xclip - screenshots with prt screen and copy to clipboard
* playerctl - control audio
* betterlockscreen - nice lock screen for i3lock


### Other

* lightdm-webkit2-greeter + Litarvan theme - login screen
* arc theme
* Flat remix icon theme


## Installation

```
git clone git@github.com:JoosepAlviste/dotfiles.git .dotfiles

cd .dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh
```

The next time you start `vim`, it will automatically install Plug as well as 
trigger PlugInstall in order to install plugins.

## Update

```
git pull
```

Maybe run `./makesymlinks.sh` again.


## Packages list (very incomplete)

This will maybe one day include all the pacman and AUR packages that should be 
installed.

```bash
pacman -S \
    i3-gaps \
    rofi \
    htop \
    evince \
    ranger \
    alacritty \
    xdg-utils \
    maim \
    surfraw
```

```bash
yay -S \
    numix-circle-icon-theme \
    betterlockscreen \
    pyenv-virtualenv \
    system-san-francisco-font-git
```


### MacOS

```bash
brew install \
    pyenv \
    pyenv-virtualenv
```


### Pip

Pyenv virtualenv `neovim3` from Python 3, there:

```bash
pip install \
    neovim \
    'python-language-server[all]' \
    pyls-mypy \
    pyls-isort \
    i3-py
```

## Utils

Docker fails with error creating new backup file '/var/lib/dpkg/status-old? 
`echo N | sudo tee /sys/module/overlay/parameters/metacopy`

`i3` workspace switching screws up PyCharm focus: 
`https://intellij-support.jetbrains.com/hc/en-us/community/posts/360001411659-Lose-Focus-after-Switching-Workspace-in-i3wm`

