vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Colorscheme
  use {'kaicataldo/material.vim', branch = 'main'}

  -- Core utilities
  use 'nvim-lua/plenary.nvim'

  -- Mapping improvements
  use 'windwp/nvim-autopairs'

  -- External programs
  use 'knubie/vim-kitty-navigator'

  -- Fuzzy finder
  use 'vijaymarupudi/nvim-fzf'

  -- Advanced highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'

  -- Programming
  --------------

  -- LSP
  use 'neovim/nvim-lspconfig'

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}

  -- Git
  use 'lewis6991/gitsigns.nvim'
end)
