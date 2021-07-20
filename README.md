# My dotfiles

![Main](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Main.png)

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
    * [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) for 
      navigation
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org)
    * With [Zsh for Humans](https://github.com/romkatv/zsh4humans)
* Window manager on macOS - [yabai](https://github.com/koekeishiya/yabai)
* Wallpaper - 
  https://www.reddit.com/r/wallpapers/comments/d6jy5b/mount_palenight6000_3892/


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

The next time you start `vim`, it will automatically install Packer. You should 
run `:PackerSync` in order to install plugins.

The utility scripts in `bin/` are automatically added to the Zsh path so you can 
run `makesymlinks` anywhere.


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


## Neovim configuration structure

The Neovim configuration is split into many files and is located in 
[`config/nvim/`](./config/nvim).

* [`autoload/`](./config/nvim/autoload): functions that are used in other files 
  and can be autoloaded. I still have a few functions here that I haven't 
  converted to Lua.
* [`ftdetect/`](./config/nvim/ftdetect): logic for detecting file types
* [`ftplugin/`](./config/nvim/ftplugin): configuration for specific file types
* [`lua/j/`](./config/nvim/lua/j): Lua files for settings, mappings, and my own 
  "plugins"
* [`lua/j/plugins/`](./config/nvim/lua/j/plugins): configuration of plugins
* [`lua/j/plugins/lsp/`](./config/nvim/lua/j/plugins/lsp): configuration for 
  Neovim's built-in LSP
* [`init.lua`](./config/nvim/init.lua): basic settings and requiring other files


## More screenshots

![Busy](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/Busy.png)

![FZF](https://raw.githubusercontent.com/JoosepAlviste/dotfiles/master/img/FZF.png)
