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
  use 'kaicataldo/material.vim'

  -- Core utilities
  use 'mjlbach/neovim-ui'  -- Useful UI utilities (might be merged into Neovim)
  use 'tpope/vim-repeat'  -- Make repeat (.) command smarter
  use 'tpope/vim-obsession'  -- Nicer session management

  -- Mapping improvements
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-commentary'  -- Commenting
  use 'tpope/vim-surround'  -- Surround stuff with things
  use 'knubie/vim-kitty-navigator'  -- Move between Vim & Kitty windows easily

  -- Navigation
  use {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',  -- Useful Lua utilities
      'nvim-lua/popup.nvim',

      -- FZF sorter for Telescope
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      {
        -- Improved editing history
        'nvim-telescope/telescope-frecency.nvim',
        config = function() require('telescope').load_extension('frecency') end,
        requires = {'tami5/sql.nvim'},
      },
    },
  }
  use 'tamago324/lir.nvim'  -- File explorer
  use 'tpope/vim-projectionist'  -- Alternative files
  use 'kyazdani42/nvim-tree.lua'

  -- Advanced highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'windwp/nvim-ts-autotag',  -- Automatically end & rename tags
      -- Dynamically set commentstring based on cursor location in file
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
  }

  -- Misc
  use 'kyazdani42/nvim-web-devicons'

  -- Programming
  --------------

  -- Smarts
  use {
    'neovim/nvim-lspconfig',  -- Built-in LSP configurations
    requires = {
      'glepnir/lspsaga.nvim',  -- LSP UI improvements
      'hrsh7th/nvim-compe',  -- Autocompletion
      'hrsh7th/vim-vsnip',  -- Snippets
    },
  }

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}
  use 'editorconfig/editorconfig-vim'  -- Project-specific settings

  -- Web dev
  use 'norcalli/nvim-colorizer.lua'  -- Preview hex colors

  -- Git
  use 'tpope/vim-fugitive'  -- I only use the "blame" feature from this
  use 'lewis6991/gitsigns.nvim'  -- Git status signs in the gutter
end)
