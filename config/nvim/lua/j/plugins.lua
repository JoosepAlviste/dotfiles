vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Colorscheme
  use {'kaicataldo/material.vim', branch = 'main'}

  -- Mapping improvements
  use 'windwp/nvim-autopairs'

  -- External programs
  use 'knubie/vim-kitty-navigator'

  -- Fuzzy finder
  use 'vijaymarupudi/nvim-fzf'
  use 'vijaymarupudi/nvim-fzf-commands'

  -- Advanced highlighting
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Programming
  --------------

  -- LSP
  use 'neovim/nvim-lspconfig'

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}

  -- Vue
  use 'posva/vim-vue'
end)
