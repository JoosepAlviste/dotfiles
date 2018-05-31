# My dotfiles

## Requirements

* Zsh

### Autocomplete:

* Vim compiled with python 3
* Globally installed `neovim` package with pip3
* [https://github.com/roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
* [https://github.com/Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [https://github.com/carlitux/deoplete-ternjs](https://github.com/carlitux/deoplete-ternjs)

## Installation

```
git clone git@github.com:JoosepAlviste/dotfiles.git .dotfiles

cd .dotfiles
chmod +x makesymlinks.sh
./makesymlinks.sh
```

The next time you start `vim`, it will automatically install Plug as well as trigger PlugInstall in order to install plugins.

## Update

```
git pull
```

