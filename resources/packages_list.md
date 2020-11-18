# Packages List

Here's a list of packages that I install. This list is not complete and is here 
just for my own reference.


## Arch

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


## macOS

```bash
brew install \
    hub \
    dash \
    htop \
    neovim \
    ripgrep \
    yarn \
    koekeishiya/formulae/yabai \
    koekeishiya/formulae/skhd \
    universal-ctags/universal-ctags/universal-ctags \
    jq
```


## Global NPM packages

Some packages that are useful and should probably be installed into the global 
node modules.

```bash
yarn global add \
    bash-language-server
```