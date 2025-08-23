# My dotfiles

![Main](https://github.com/user-attachments/assets/3d183c91-0cc5-4c4a-a530-0e13d51fd927)

Some of the configuration includes:

* Editor - [neovim](https://neovim.io)
    * Configured in Lua
    * See [`config/nvim/lua/j/plugins/`](./config/nvim/lua/j/plugins) for 
      the used plugins
    * [Kanagawa color 
      scheme](https://github.com/rebelot/kanagawa.nvim)
    * Neovim's built-in LSP client
    * [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter/) 
      for highlighting
    * [`snacks.nvim` picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md) for 
      navigation
* Terminal emulator - [Kitty](https://sw.kovidgoyal.net/kitty)
* Shell - [Zsh](https://www.zsh.org) (custom configuration)
* [Wallpaper](https://www.reddit.com/r/ghibli/comments/16scnnt/i_made_a_set_of_totoro_wallpaper_for_pc_and/)


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
[`Brewfile`](./Brewfile) for extra programs to 
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

![Busy](https://github.com/user-attachments/assets/5e280aea-374c-4808-8f63-3d39d437e59b)

![Finder](https://github.com/user-attachments/assets/30d8bde9-9be6-4216-abb2-b6eaf844b2d0)

![Completion](https://github.com/user-attachments/assets/e19e2f6e-b175-4424-a141-05d1235f0c6f)
