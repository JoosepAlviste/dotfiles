local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Colorscheme
  use {'kaicataldo/material.vim', branch = 'main'}

  -- Core utilities
  use 'nvim-lua/plenary.nvim'  -- Useful Lua utilities
  use 'mjlbach/neovim-ui'  -- Useful UI utilities (might be merged into Neovim)
  use 'tpope/vim-obsession'  -- Nicer session management

  -- Mapping improvements
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'b3nj5m1n/kommentary'  -- Commenting
  -- Dynamically set commentstring based on cursor location in file
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'tpope/vim-surround'  -- Surround stuff with things
  use 'knubie/vim-kitty-navigator'  -- Move between Vim & Kitty windows easily

  -- Navigation
  use 'vijaymarupudi/nvim-fzf'  -- Fuzzy finder
  use 'justinmk/vim-dirvish'  -- File explorer
  use 'tpope/vim-projectionist'  -- Alternative files
  use 'kyazdani42/nvim-tree.lua'

  -- Advanced highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/playground', disable = true}

  -- Misc
  use 'kyazdani42/nvim-web-devicons'

  -- Programming
  --------------

  -- Smarts
  use 'neovim/nvim-lspconfig'  -- Built-in LSP configurations
  use 'glepnir/lspsaga.nvim'  -- LSP UI improvements
  use 'hrsh7th/nvim-compe'  -- Autocompletion
  use 'hrsh7th/vim-vsnip'  -- Snippets

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}
  use 'editorconfig/editorconfig-vim'  -- Project-specific settings

  use 'norcalli/nvim-colorizer.lua'  -- Preview hex colors

  -- Git
  use 'tpope/vim-fugitive'  -- I only use the "blame" feature from this
  use 'lewis6991/gitsigns.nvim'  -- Git status signs in the gutter
end)
