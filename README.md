# My dotfiles

Since this project uses git submodules for some things (tmux plugins), it needs
to be cloned with submodules.

```
git clone --recurse-submodules git@github.com:JoosepAlviste/dotfiles.git
```

## Requirements

* Zsh

### Autocomplete:

* Vim compiled with python 3
* Globally installed `neovim` package with pip3
    - `pip3 install neovim`
* [https://github.com/roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
* [https://github.com/Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [https://github.com/carlitux/deoplete-ternjs](https://github.com/carlitux/deoplete-ternjs)

### Ctags:

* [Universal ctags](https://github.com/universal-ctags/ctags) for better ctags 
(React files, etc.). Can just be installed with brew.

### Fzf

Fuzzy finder.

* Needs fzf installed globally (from brew)
    - If it is not installed, it will be installed as a vim plugin though
* Needs `ag` for smarter file searching

### Colorls

[Url](https://github.com/athityakumar/colorls). Should be as simple as:

```
gem install colorls
```

Usable with `cl` or `colorls`.

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

