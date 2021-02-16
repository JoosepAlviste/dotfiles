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

  -- Programming
  --------------

  -- LSP
  use 'neovim/nvim-lspconfig'

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}

  -- Git
  use 'tpope/vim-fugitive'

  -- Vue
  use 'posva/vim-vue'
end)
