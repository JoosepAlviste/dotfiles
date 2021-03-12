# My dotfiles

![Busy](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Busy.png)

Some of the configuration includes:

* Editor - [neovim](https://neovim.io)
    * Configured in Lua
    * See [`config/nvim/lua/j/plugins.lua`](./config/nvim/lua/j/plugins.lua) for 
      the used plugins
    * Slightly modified [Material Palenight color 
      scheme](https://github.com/kaicataldo/material.vim/)
    * Neovim's built-in LSP client
    * [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/) 
      for highlighting
    * [`fzf`](https://github.com/junegunn/fzf) for navigation
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org)
    * With [Zinit](https://github.com/zdharma/zinit/)
* Window manager on macOS - [yabai](https://github.com/koekeishiya/yabai)
* Wallpaper - https://mikaelgustafsson.artstation.com/projects/nA9Lr


## Installation

```sh
git clone --recurse-submodules git@github.com:JoosepAlviste/dotfiles.git

cd dotfiles
chmod +x bin/makesymlinks.sh
./bin/makesymlinks.sh
```

(Submodules are required since `bat` theme is a cloned repository).

This will symlink all of the files and folders inside `dots/` into your home 
folder prefixed by `.` and everything from `config/` to your `~/.config/` 
folder.

The next time you start `vim`, it will automatically install Packer. You might 
need to manually run `:PackerUpdate` in order to install plugins.

The utility scripts in `bin/` are automatically added to the Zsh path so you can 
run `makesymlinks` anywhere.


### Custom Firefox theme

I use the [MaterialFox](https://github.com/muckSponge/MaterialFox) Firefox 
theme. Follow the installation instructions in their README.


### BetterTouchTool

This repository also includes my BetterTouchTool presets in the `resources/` 
folder.

The touch bar looks like so:

![Touch Bar 
preset](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/TouchBar.png)


## Update

```bash
git pull
```

Maybe run `./bin/makesymlinks.sh` again.


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


## Neovim configuration structure

The Neovim configuration is split into many files since there is quite a bit of 
configuration and it would be crazy to have it all in one file.

Neovim configuration is located in [`config/nvim/`](./config/nvim).

* [`autoload/`](./config/nvim/autoload): functions that are used in other files 
  and can be autoloaded. I still have a few functions here that I haven't 
  converted to Lua.
* [`ftdetect/`](./config/nvim/ftdetect): logic for detecting file types
* [`ftplugin/`](./config/nvim/ftplugin): configuration for specific file types
* [`lua/j/`](./config/nvim/lua/j): Lua files for settings, mappings, and my own 
  "plugins"
* [`lua/j/plugins/`](./config/nvim/lua/j/plugins): configuration of plugins
* `init.lua`: basic settings and autocommands


## Packages

### Automatically installed through Zinit

These packages will be automatically installed when Zsh is started.

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
* [ripgrep (`rg`)](https://github.com/BurntSushi/ripgrep)


### Python

Zinit automatically installs `pyenv` and `pyenv-virtualenv`! Zinit installs 
`pyenv` to `~/.zinit/plugins/pyenv---pyenv/` and Pyenv versions will end up in 
`~/.zinit/plugins/pyenv---pyenv/versions/`. This means that if you delete the 
`~/.zinit/plugins/` folder for whatever reason (debugging, etc.), then your 
Pyenv virtualenvs would also be destroyed (this is bad). So, it might make 
sense to symlink the versions folder to some other folder. For example, 
something like this:

```sh
mkdir -p ~/.config/pyenv/versions
rm -rf ~/.config/zsh/.zinit/plugins/pyenv---pyenv/versions
ln -s ~/.config/pyenv/versions ~/.config/zsh/.zinit/plugins/pyenv---pyenv/versions
```

Neovim plugins require that there's a virtualenv with the `neovim` package 
installed. Create a Pyenv virtualenv `neovim3` from Python 3 and `neovim2` from 
Python 2, there:

```bash
pip install \
    neovim \
    neovim-remote \
    pynvim \
    i3-py
```

The location of this virtualenv is configured in `nvim/init.vim`.


## More screenshots

![Split](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Split.png)

![FZF](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/FZF.png)
