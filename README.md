# My dotfiles

![Busy](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Busy.png)

Some of the configuration includes:

* Editor - [neovim](https://neovim.io)
    * See `dots/vim/plugins.vim` for the used plugins
    * Slightly modified [OceanicNext 
        colorscheme](https://github.com/mhartington/oceanic-next)
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org)
    * With [Prezto](https://github.com/sorin-ionescu/prezto)
* Window manager on macOS - [yabai](https://github.com/koekeishiya/yabai)
* Window manager on Linux - [i3-gaps](https://github.com/Airblader/i3)
    * With [Polybar](https://github.com/polybar/polybar) and 
      [Rofi](https://github.com/davatorium/rofi)
* `tmux` (I don't use it anymore but left the configuration since it might be 
    useful)
* Wallpaper - https://mikaelgustafsson.artstation.com/projects/Y2Wew (I haven't 
    updated the screenshots to this one yet)


## Utilities

If some of these utilities are installed, they will be aliased:

* [`bat`](https://github.com/sharkdp/bat) - `cat` replacement
* [`prettyping`](https://github.com/denilsonsa/prettyping) - `ping` replacement
* [`tldr`](http://tldr.sh/) - simpler `man` pages, aliased to `help`
* [`hub`](https://github.com/github/hub) - `git` replacement, integrates with 
  GitHub. (Can run `git clone dotfiles` to clone your own dotfiles)

Just useful utilities that aren't aliased:

* [fd](https://github.com/sharkdp/fd/) - simpler `find` replacement
* [noti](https://github.com/variadico/noti) - notifications when processes end

Firefox color theme

https://color.firefox.com/?theme=XQAAAAIYAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xNKlhRZV3WyJgLznIpdqgXIgRu0RnvYWDfkxQOiMDH8G8w62UzSuCTn9Qe_JwV3pZBx_N-ipogfdGTdWX2NYbkjKNS776KDnbhCxvRIO8nuk0VpvP7UJS3lKCGWH6lt2oOfxAu0aoFfUXvameh8PYAVmISMbtpuyoFBaYYNVExt7dhQV7BY97wc4ZfgWK4W989hbRFoMqL8D-WtdSlXcT_kNixlkwu_-24HJ8


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
* `maim` + `xclip` - screenshots with prt screen and copy to clipboard
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


## Update

```
git pull
```

Maybe run `./bin/makesymlinks.sh` again.


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
    fzf \
    polybar \
    rofi \
    firefox-developer-edition \
    bat \
    hub \
    htop \
    ripgrep \
    bibata-cursor-theme \

    evince \
    xdg-utils \
    maim \
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
    pyenv-virtualenv \
    system-san-francisco-font-git \
    rofi \
    google-chrome \
    rofi-calc
```

```bash
gem install colorls
```


### macOS

```bash
brew install \
    zsh-completions \
    tmux \
    fzf \
    hub \
    bat \
    dash \
    diff-so-fancy \
    htop \
    ranger \
    neovim \
    ripgrep \
    yarn \
    pyenv \
    pyenv-virtualenv \
    koekeishiya/formulae/chunkwm \
    koekeishiya/formulae/skhd \
    universal-ctags/universal-ctags/universal-ctags \
    jq
```


### Python

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
