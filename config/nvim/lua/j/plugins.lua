local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Colorscheme
  use {
    'kaicataldo/material.vim',
    config = function() require('j.plugins.material').setup() end,
  }

  -- Core utilities
  use 'mjlbach/neovim-ui'  -- Useful UI utilities (might be merged into Neovim)
  use 'tpope/vim-repeat'  -- Make repeat (.) command smarter
  use {
    'rmagatti/auto-session',  -- Automatic sessions
    config = function()
      -- After restoring a session, restart Lir so that it correctly picks up 
      -- if the restored buffer is a folder.
      require('auto-session').setup({
        post_restore_cmds = {[[lua require('lir').init()]]},
      })
    end,
  }

  -- Mapping improvements
  use {
    'windwp/nvim-autopairs',
    config = function() require('j.plugins.autopairs') end,
  }
  use 'tpope/vim-commentary'  -- Commenting
  use 'tpope/vim-surround'  -- Surround stuff with things
  use 'knubie/vim-kitty-navigator'  -- Move between Vim & Kitty windows easily

  -- Navigation
  use {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    config = function() require('j.plugins.telescope') end,
    requires = {
      'nvim-lua/plenary.nvim',  -- Useful Lua utilities
      'nvim-lua/popup.nvim',

      -- FZF sorter for Telescope
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    },
  }
  use {
    'tamago324/lir.nvim',  -- File explorer
    config = function() require('j.plugins.lir') end,
  }
  use {
    'tpope/vim-projectionist',  -- Alternative files
    config = function() require('j.plugins.projectionist') end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    disable = true,
    config = function() require('j.plugins.tree') end,
  }

  -- Advanced highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('j.plugins.treesitter') end,
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
    config = function()
      require('j.plugins.lsp')
      require('j.plugins.lsp.css_ls')
      require('j.plugins.lsp.docker_ls')
      require('j.plugins.lsp.graphql_ls')
      require('j.plugins.lsp.json_ls')
      require('j.plugins.lsp.php_ls')
      require('j.plugins.lsp.tsserver_ls')
      require('j.plugins.lsp.vue_ls')
      require('j.plugins.lsp.yaml_ls')
      require('j.plugins.lsp.lua_ls')
      require('j.plugins.lsp.efm_ls')
    end,
    requires = {
      'glepnir/lspsaga.nvim',  -- LSP UI improvements
      {
        'hrsh7th/nvim-compe',  -- Autocompletion
        config = function() require('j.plugins.completion') end,
      },
      {
        'hrsh7th/vim-vsnip',  -- Snippets
        config = function() require('j.plugins.vsnip') end,
      },
    },
  }

  use {'git@github.com:JoosepAlviste/scoro.vim.git', branch = 'main'}
  use {
    'editorconfig/editorconfig-vim',  -- Project-specific settings
    config = function() vim.g.EditorConfig_preserve_formatoptions = 1 end,
  }

  -- Web dev
  use {
    'norcalli/nvim-colorizer.lua',  -- Preview hex colors
    config = function()
      require('colorizer').setup({
        '*',
        '!packer',
      })
    end,
    after = 'material.vim',
  }

  -- Git
  use 'tpope/vim-fugitive'  -- I only use the "blame" feature from this
  use {
    'lewis6991/gitsigns.nvim',  -- Git status signs in the gutter
    config = function() require('j.plugins.gitsigns') end,
  }
end)
