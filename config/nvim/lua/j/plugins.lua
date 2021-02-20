vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Colorscheme
  use {'kaicataldo/material.vim', branch = 'main'}

  -- Core utilities
  use 'nvim-lua/plenary.nvim'  -- Useful Lua utilities
  use 'mjlbach/neovim-ui'  -- Useful UI utilities (might be merged into Neovim)

  -- Mapping improvements
  use 'windwp/nvim-autopairs'
  use 'b3nj5m1n/kommentary'  -- Commenting
  use 'tpope/vim-surround'  -- Surround stuff with things
  use 'knubie/vim-kitty-navigator'  -- Move between Vim & Kitty windows easily

  -- Fuzzy finder
  use 'vijaymarupudi/nvim-fzf'

  -- File explorer
  use 'justinmk/vim-dirvish'

  -- Advanced highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/playground', disable = true}

  -- Programming
  --------------

  -- LSP
  use 'neovim/nvim-lspconfig'  -- Built-in LSP configurations
  use 'hrsh7th/nvim-compe'  -- Autocompletion
  use 'hrsh7th/vim-vsnip'  -- Snippets

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}

  -- Git
  use 'lewis6991/gitsigns.nvim'  -- Git status signs in the gutter
end)
