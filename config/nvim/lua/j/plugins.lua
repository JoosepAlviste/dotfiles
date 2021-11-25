local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- Colorscheme
  use {
    'JoosepAlviste/palenightfall.nvim',
    config = function()
      require 'j.plugins.palenightfall'
    end,
  }

  -- Core utilities
  use 'tpope/vim-repeat' -- Make repeat (.) command smarter
  use { -- Automatic sessions
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        -- Resize Neovim after it is started, otherwise the cmdheight might be
        -- super large when restoring the session
        -- https://github.com/rmagatti/auto-session/issues/64
        -- https://github.com/neovim/neovim/issues/11330
        post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' },
      }
    end,
  }
  use {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = require('palenightfall').colors.background,
      }

      vim.notify = require 'notify'
    end,
  }

  -- Mapping improvements
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'j.plugins.autopairs'
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = function(ctx)
          local U = require 'Comment.utils'

          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
          end

          return require('ts_context_commentstring.internal').calculate_commentstring {
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
          }
        end,
      }
    end,
  }
  use 'tpope/vim-surround' -- Surround stuff with things
  use 'knubie/vim-kitty-navigator' -- Move between Vim & Kitty windows easily

  -- Navigation
  use {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'j.plugins.telescope'
    end,
    requires = {
      'nvim-lua/plenary.nvim', -- Useful Lua utilities
      'nvim-lua/popup.nvim',

      -- FZF sorter for Telescope
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }
  use {
    'tamago324/lir.nvim', -- File explorer
    config = function()
      require 'j.plugins.lir'
    end,
  }
  use {
    'tpope/vim-projectionist', -- Alternative files
    config = function()
      require 'j.plugins.projectionist'
    end,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    disable = true,
    config = function()
      require 'j.plugins.tree'
    end,
  }
  use {
    'ThePrimeagen/harpoon',
    config = function()
      require 'j.plugins.harpoon'
    end,
  }
  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require('lightspeed').setup {
        exit_after_idle_msecs = {
          labeled = 1500,
          -- Increase timeout for f/t keys
          unlabeled = 3000,
        },
      }
    end,
  }

  -- Advanced highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'j.plugins.treesitter'
    end,
    requires = {
      'windwp/nvim-ts-autotag', -- Automatically end & rename tags
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
    'neovim/nvim-lspconfig', -- Built-in LSP configurations
    config = function()
      require 'j.plugins.lsp'
      require 'j.plugins.lsp.css_ls'
      require 'j.plugins.lsp.docker_ls'
      require 'j.plugins.lsp.graphql_ls'
      require 'j.plugins.lsp.json_ls'
      require 'j.plugins.lsp.php_ls'
      require 'j.plugins.lsp.tsserver_ls'
      require 'j.plugins.lsp.vue_ls'
      require 'j.plugins.lsp.volar_ls'
      require 'j.plugins.lsp.yaml_ls'
      require 'j.plugins.lsp.lua_ls'
      require 'j.plugins.lsp.terraform_ls'
      require 'j.plugins.lsp.haskell_ls'
      require 'j.plugins.lsp.eslint_ls'
    end,
    requires = {
      {
        'hrsh7th/vim-vsnip', -- Snippets
        config = function()
          require 'j.plugins.vsnip'
        end,
      },
      {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-vsnip',
        },
        config = function()
          require 'j.plugins.cmp'
        end,
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require 'j.plugins.lsp.null_ls'
        end,
      },
      'folke/lua-dev.nvim',
    },
  }

  use 'git@github.com:JoosepAlviste/scoro.vim.git'
  use {
    'editorconfig/editorconfig-vim', -- Project-specific settings
    config = function()
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  }

  -- Web dev
  use {
    'norcalli/nvim-colorizer.lua', -- Preview hex colors
    config = function()
      require('colorizer').setup {
        '*',
        '!packer',
      }
    end,
    after = 'palenightfall.nvim',
  }

  -- Git
  -- I only use the "blame" feature from this
  use {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  }
  use {
    'lewis6991/gitsigns.nvim', -- Git status signs in the gutter
    config = function()
      require 'j.plugins.gitsigns'
    end,
  }
end)
