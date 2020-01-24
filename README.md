# My dotfiles

![Busy](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Busy.png)

Some of the configuration includes:

* Editor - [neovim](https://neovim.io)
    * See `dots/vim/plugins.vim` for the used plugins
    * Slightly modified [Material Palenight colorscheme](https://github.com/kaicataldo/material.vim/)
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org)
    * With [Zinit](https://github.com/zdharma/zinit/)
* Window manager on macOS - [yabai](https://github.com/koekeishiya/yabai)
* Window manager on Linux - [i3-gaps](https://github.com/Airblader/i3)
    * With [Polybar](https://github.com/polybar/polybar) and 
      [Rofi](https://github.com/davatorium/rofi)
* Wallpaper - https://mikaelgustafsson.artstation.com/projects/nA9Lr


## Utilities

If some of these utilities are installed, they will be aliased:

* [`bat`](https://github.com/sharkdp/bat) - `cat` replacement (installed 
  automatically with Zinit)
* [`prettyping`](https://github.com/denilsonsa/prettyping) - `ping` 
  replacement (installed automatically with Zinit)
* [`tldr`](http://tldr.sh/) - simpler `man` pages, aliased to `help`
* [`hub`](https://github.com/github/hub) - `git` replacement, integrates with 
  GitHub. (Can run `git clone dotfiles` to clone your own dotfiles)

Just useful utilities that aren't aliased:

* [fd](https://github.com/sharkdp/fd/) - simpler `find` replacement
* [noti](https://github.com/variadico/noti) - notifications when processes end


## Linux

Just some notes and things I use on Linux:

* `i3-gaps`
* `platerctl` - media controls
* `feh` - wallpaper
* `compton` - opacity
* `rofi` - better dmenu
* `xkblayout`-state
    - Probably needs `apt install libx11-dev`
* `polybar`
* `playerctl` - control audio
* `betterlockscreen` - nice lock screen for i3lock


## macOS

Just some notes and things I use on macOS:

* Fix slow `yabai` controls by using `dash` as the shell
    * `zsh` is the default shell and is horribly slow, so let's use a faster 
        shell for running `skhd`
    * Edit `/usr/local/Cellar/skhd/0.3.4/homebrew.mxcl.skhd.plist`
    * Add environment variable `SHELL = /usr/local/bin/dash`
    * More info at [this GitHub issue](https://github.com/koekeishiya/chunkwm/issues/232)
* Start `yabai` services
    * `brew services start yabai`
    * `brew services start skhd`

# Vim configuration structure

The (neo)vim configuration is split into many files since there is quite a bit 
of configuration and it would be crazy to have it all in one file. I try to 
leverage as much of Vims built-in logic for splitting files.

Neovim specific configuration is located in `config/nvim/init.vim`, everything 
else vim-related is in `dots/vim/`.

* `after/plugin/` - configuration related to plugins (settings, mappings, etc.)
* `autoload/` - functions that are used in other files
    * `lightline/` - custom color schemes for Lightline
* `colors/` - custom color schemes (currently includes `nightowl` but I don't 
    use it anymore)
* `ftdetect/` - logic for detecting file types
* `ftplugin/` - configuration for specific file types
* `plugin/` - configuration split into files, kind of like *"my own plugins"*. 
    File names should be pretty descriptive
    * `mappings/` - mappings not related to any plugins
    * `highlight.vim` - some non-colorscheme-related highlighting syntax 
        improvements
    * `settings.vim` - most global `set XYZ` calls are here. I would like to 
        split this even more but it works OK for now
* `plugins.vim` - declaring used plugins using `Plug`
* `vimrc` - settings that don't really fit into anywhere else (aim is to have as 
    little as possible here)


## Installation

```
git clone --recurse-submodules git@github.com:JoosepAlviste/dotfiles.git

cd dotfiles
chmod +x bin/makesymlinks.sh
./bin/makesymlinks.sh
```

(Submodules are required since `ranger` theme is a cloned repository).

This will symlink all of the files and folders inside `dots/` into your home 
folder prefixed by `.` and everything from `config/` to your `~/.config/` 
folder.

The next time you start `vim`, it will automatically install Plug. You might 
need to manually run `:PlugInstall` in order to install plugins.

The utility scripts in `bin/` are automatically added to the Zsh path so you can 
run `makesymlinks` anywhere.


### Custom Firefox theme

![Firefox custom 
theme](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Firefox-Theme.png)

I have some custom CSS which makes my Firefox look a bit better and have the 
Material Palenight color scheme. If you want to install the theme, copy or 
symlink the files from `resources/firefox/` to your [Firefox profile 
folder](https://www.howtogeek.com/255587/how-to-find-your-firefox-profile-folder-on-windows-mac-and-linux/):

```bash
ln -s ~/dotfiles/resources/firefox/userChrome.css $PROFILE_DIR/chrome
ln -s ~/dotfiles/resources/firefox/userContent.css $PROFILE_DIR/chrome
```


## Update

```
git pull
```

Maybe run `./bin/makesymlinks.sh` again.


## Automatically installed through Zinit

These packages will be automatically installed when zsh is started.

They are installed & set up asynchronously with Zinit's turbo mode, so it's 
probably best to not use `pacman` or `homebrew` versions of those packages.

* [`bat`](https://github.com/sharkdp/bat)
* [`exa`](https://github.com/ogham/exa)
* [`pyenv`](https://github.com/pyenv/pyenv)
* [`pyenv-virtualenv`](https://github.com/pyenv/pyenv-virtualenv)
* [`fzf`](https://github.com/junegunn/fzf)
* [`zsh-z`](https://github.com/agkozak/zsh-z)
* [`diff-so-fancy`](https://github.com/zdharma/zsh-diff-so-fancy)
* [`prettyping`](https://github.com/denilsonsa/prettyping)

## Packages list (very incomplete)

This will maybe one day include all the pacman and AUR packages that should be 
installed.

```bash
pacman -S \
    xorg \  # Display server
    xorg-xinit \  # startx
    xorg-xrdb \  # Xresources
    xorg-xmodmap \
    xbindkeys \
    i3-gaps \  # Window manager
    feh \
    compton \
    zsh \  # Default shell
    kitty \  # Terminal
    gnome-keyring \
    vim \
    neovim \
    polybar \
    rofi \
    firefox-developer-edition \
    hub \
    htop \
    ripgrep \
    bibata-cursor-theme \
    flameshot \

    evince \
    xdg-utils \
    surfraw \
    ranger \
    networkmanager \
    network-manager-applet \
    noto-fonts-emoji \
    nodejs \
    npm \
    yarn \
    ruby \
    the_silver_searcher \
    flatpak \
    arc-gtk-theme \
    mpv \
    dconf-editor (??)
```

```bash
yay -S \
    polybar \

    flat-remix-git \
    betterlockscreen \
    system-san-francisco-font-git \
    rofi \
    google-chrome \
    rofi-calc
```

### macOS

```bash
brew install \
    tmux \
    hub \
    dash \
    htop \
    ranger \
    neovim \
    ripgrep \
    yarn \
    koekeishiya/formulae/chunkwm \
    koekeishiya/formulae/skhd \
    universal-ctags/universal-ctags/universal-ctags \
    jq
```


### Python

Zinit automatically installs `pyenv` and `pyenv-virtualenv`! Zinit installs 
`pyenv` to `~/.zinit/plugins/pyenv---pyenv/` and Pyenv versions will end up in 
`~/.zinit/plugins/pyenv---pyenv/versions/`. This means that if you delete the 
`~/.zinit/plugins/` folder for whatever reason (debugging, etc.), then your 
pyenv virtualenvs would also be destroyed (this is bad). So, it might make 
sense to symlink the versions folder so some other folder. For example, 
something like this: `ln -s ~/.pyenv/versions 
~/.zinit/plugins/pyenv---pyenv/versions`.

Neovim plugins require that there's a virtualenv with the `neovim` package 
installed. Create a Pyenv virtualenv `neovim3` from Python 3 and `neovim2` from 
Python 2, there:

```bash
pip install \
    neovim \
    i3-py
```

The location of this virtualenv is configured in `nvim/init.vim`.


### Global NPM packages

Some packages that are useful and should probably be installed into the global 
node modules.

```bash
yarn global add \
    bash-language-server
```


## FAQ (my own reference)

### Docker fails with error creating new backup file '/var/lib/dpkg/status-old? 
`echo N | sudo tee /sys/module/overlay/parameters/metacopy`

### `i3` workspace switching screws up PyCharm focus: 
`https://intellij-support.jetbrains.com/hc/en-us/community/posts/360001411659-Lose-Focus-after-Switching-Workspace-in-i3wm`

### Default Google Chrome with `i3`

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

### Overriding environment variables

If you want to override environment variables without polluting the Git status, 
then you can create a new file `dots/zprofile.local` and run `makesymlinks`. 
This will link that file to `~/.zprofile.local` and source it inside `zprofile`. 
Feel free to override any environment variables here (for example, monitors).

### To change the color scheme in Vim & terminal

1. Change the Vim color scheme in `dots/vim/vimrc`
2. Change the terminal color scheme in `config/kitty/kitty.conf`, find the 
   `include themes/*.conf` file & change the theme file name
3. Change the `THEME` variable in `dots/zshrc` in order to customize the FZF 
   colors

Available themes include:

* `OceanicNext`
* `palenight` -- in `dots/vim/vimrc` change to `colorscheme material` and add 
  `let g:material_theme_style = 'palenight'` before the `colorscheme` 
  setting).

## More screenshots

![Split](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Split.png)

![FZF](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/FZF.png)
