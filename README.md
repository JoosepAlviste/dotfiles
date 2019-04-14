# My dotfiles

## Requirements

* Zsh
    - [Prezto](https://github.com/sorin-ionescu/prezto/)
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

### Utilities

If these are installed, will be aliased.

* [`bat`](https://github.com/sharkdp/bat) - `cat` replacement
* [`prettyping`](https://github.com/denilsonsa/prettyping) - `ping` replacement
* [`tldr`](http://tldr.sh/) - simpler `man` pages, aliased to `help`
* [`hub`](https://github.com/github/hub) - `git` replacement, integrates with 
  github. (Can run `git clone dotfiles` to clone your own dotfiles)

Just useful utilities:

* [fd](https://github.com/sharkdp/fd/) - simpler `find` replacement
* [noti](https://github.com/variadico/noti) - notifications when processes end

### Vim

* Neovim compiled with python 3
* Pyenv virtual environment called `neovim3` and `neovim2`
    - With `pynvim` package installed
* [Universal ctags](https://github.com/universal-ctags/ctags) for better ctags 
(React files, etc.). Can just be installed with brew.

### Fzf

Fuzzy finder.

* Needs fzf installed globally (from brew)
    - If it is not installed, it will be installed as a vim plugin though
* Needs `rg` (`ripgrep`) for smarter file searching

### i3

* `i3-gaps`
* `platerctl` - media controls
* `feh` - wallpaper
* `compton` - opacity
* `rofi` - better dmenu
* `xkblayout`-state
    - Probably needs `apt install libx11-dev`
* `polybar`
* `maim` + `xclip` - screenshots with prt screen and copy to clipboard
* `playerctl` - control audio
* `betterlockscreen` - nice lock screen for i3lock


### Other

* arc theme
* Flat remix icon theme


## Installation

```
git clone git@github.com:JoosepAlviste/dotfiles.git dotfiles

cd .dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh
```

This will symlink all of the files and folders inside `dots/` into your home 
folder prefixed by `.` and everything from `config/` to your `~/.config/` 
folder.

The next time you start `vim`, it will automatically install Plug. You might 
need to manually run `:PlugInstall` in order to install plugins.

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
    xdg-utils \
    maim \
    surfraw \
    ranger \
    networkmanager \
    network-manager-applet \
    alacritty \
    compton \
    feh \
    xbindkeys \
    noto-fonts-emoji \
    gnome-keyring \
    zsh \
    tmux \
    nodejs \
    npm \
    yarn \
    ruby \
    the_silver_searcher \
    neovim \
    flatpak \
    arc-gtk-theme \
    mpv \
    hub \
    dconf-editor (??)
```

```bash
yay -S \
    flat-remix-git \
    betterlockscreen \
    pyenv-virtualenv \
    system-san-francisco-font-git \
    rofi \
    polybar \
    google-chrome \
    rofi-calc
```

```bash
gem install colorls
```


### MacOS

```bash
brew install \
    pyenv \
    pyenv-virtualenv \
    fzf
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

## FAQ (my own reference)

Docker fails with error creating new backup file '/var/lib/dpkg/status-old? 
`echo N | sudo tee /sys/module/overlay/parameters/metacopy`

`i3` workspace switching screws up PyCharm focus: 
`https://intellij-support.jetbrains.com/hc/en-us/community/posts/360001411659-Lose-Focus-after-Switching-Workspace-in-i3wm`

## Default Google Chrome with `i3`

Edit `~/.config/mimeapps.list` and/or 
`~/.local/share/applications/mimeapps.list` and make sure that it looks 
something like this:

```
[Default Applications]
x-scheme-handler/mailto=google-chrome.desktop
text/html=google-chrome.desktop
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
x-scheme-handler/about=google-chrome.desktop
x-scheme-handler/unknown=google-chrome.desktop
```
