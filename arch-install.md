# Arch install

Install guide

## Misc

AUR package manager `yay`.

Enable num lock:

```
yay -S systemd-numlockontty
systemctl enable numLockOnTty
```

## Graphical user interface

```
pacman -S xorg-server xorg-init
```

Video card

```
lspci | grep -e VGA -e 3D

# Find driver
pacman -Ss xf86-video

# download driver
pacman -S xf86-... 
```

Terminal

```
pacman -S rxvt-unicode
```

Zsh

```
pacman -S zsh zsh-completions

# Set the shell as the default
chsh -s /usr/bin/zsh
```

Monitor stuff

```
pacman -S xorg-xrandr
```

Fonts

```
pacman -S noto-fonts
```

`Overpass` from somewhere.

### i3

```
pacman -S i3-gaps i3status dmenu
```

[Polybar](https://github.com/jaagr/polybar)


## Development

```
pacman -S openssh
ssh-keygen -t rsa -b 4096 -C "joosep.alviste@gmail.com"
```

* nodejs
* npm
* yarn
* yarn global add spaceship-prompt
    * add global thingies to path

