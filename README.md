# My dotfiles

![Main](https://github.com/JoosepAlviste/dotfiles/assets/9450943/01d33a36-c8d5-44a2-815d-450100733da1)

Some of the configuration includes:

* Editor - [neovim](https://neovim.io)
    * Configured in Lua
    * See [`config/nvim/lua/j/plugins.lua`](./config/nvim/lua/j/plugins.lua) for 
      the used plugins
    * [Palenightfall color 
      scheme](https://github.com/JoosepAlviste/palenightfall.nvim)
    * Neovim's built-in LSP client
    * [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/) 
      for highlighting
    * [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) for 
      navigation
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org) (custom configuration)
* [Wallpaper](https://www.reddit.com/r/wallpaper/comments/pc8uq4/samurai_doge_3840x2160/)


## Installation

```sh
git clone --recurse-submodules git@github.com:JoosepAlviste/dotfiles.git

cd dotfiles
chmod +x bin/makesymlinks
./bin/makesymlinks
```

This will symlink all of the files and folders inside `dots/` into your home 
folder prefixed by `.` and everything from `config/` to your `~/.config/` 
folder.

The next time you start `vim`, it will automatically install `lazy.nvim` and Vim 
plugins. You should run `:MasonInstallAll` in order to install the required 
external programs. Also, check out 
[`packages_list.md`](./resources/packages_list.md) for extra programs to 
install.

The utility scripts in `bin/` are automatically added to the Zsh path, so you 
can run `makesymlinks` anywhere.


## Update

```bash
git pull
```

Maybe run `./bin/makesymlinks` again.


## Neovim configuration structure

The Neovim configuration is split into many files and is located in 
[`config/nvim/`](./config/nvim).

* [`autoload/`](./config/nvim/autoload): functions that are used in other files 
  and can be autoloaded. I still have a few functions here that I haven't 
  converted to Lua.
* [`ftplugin/`](./config/nvim/ftplugin): configuration for specific file types
* [`lua/j/`](./config/nvim/lua/j): Lua files for settings, mappings, and my own 
  modules
* [`lua/j/plugins/`](./config/nvim/lua/j/plugins): configuration of plugins
* [`lua/j/plugins/lsp/`](./config/nvim/lua/j/plugins/lsp): configuration for 
  Neovim's built-in LSP
* [`init.lua`](./config/nvim/init.lua): basic settings and requiring other files


## More screenshots

![Busy](https://github.com/JoosepAlviste/dotfiles/assets/9450943/4037709d-1637-4b7f-9598-6a3b6697f734)

![Finder](https://github.com/JoosepAlviste/dotfiles/assets/9450943/211e152f-24ef-45ec-9bed-36ee61b95fd5)

![Completion](https://github.com/JoosepAlviste/dotfiles/assets/9450943/f2b877e1-dd52-4935-832b-7b6c4896328c)
