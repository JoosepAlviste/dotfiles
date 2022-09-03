local fn = vim.fn

-- Automatically install packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup {
  function(use)
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
        require 'j.plugins.auto_session'
      end,
    }
    use {
      'rcarriga/nvim-notify',
      config = function()
        require 'j.plugins.notify'
      end,
      requires = { 'palenightfall.nvim' },
    }
    use 'lewis6991/impatient.nvim'
    use {
      'antoinemadec/FixCursorHold.nvim',
      config = function()
        vim.g.cursorhold_updatetime = 250
      end,
    }
    use {
      'andymass/vim-matchup',
      config = function()
        vim.g.matchup_matchparen_offscreen = {}
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
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        }
      end,
    }
    use {
      'kylechui/nvim-surround',
      config = function()
        require('nvim-surround').setup()
      end,
    }
    -- Move between Vim & Kitty windows easily
    use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }

    -- Navigation
    use {
      -- Fuzzy finder
      'nvim-telescope/telescope.nvim',
      config = function()
        require 'j.plugins.telescope'
      end,
      requires = {
        'nvim-lua/plenary.nvim', -- Useful Lua utilities

        -- FZF sorter for Telescope
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
      },
    }
    use {
      'tamago324/lir.nvim', -- File explorer
      config = function()
        require 'j.plugins.lir'
      end,
      after = { 'nvim-web-devicons' },
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
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require 'j.plugins.web_devicons'
      end,
    }

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
        require 'j.plugins.lsp.ltex_ls'
        require 'j.plugins.lsp.prisma_ls'
        require 'j.plugins.lsp.html_ls'
        require 'j.plugins.lsp.svelte_ls'
        require 'j.plugins.lsp.tailwind_ls'
      end,
      requires = {
        {
          'hrsh7th/nvim-cmp',
          requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'petertriho/cmp-git',
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
        'jose-elias-alvarez/typescript.nvim',
        'folke/lua-dev.nvim',
      },
    }

    use {
      'L3MON4D3/LuaSnip',
      config = function()
        require 'j.plugins.luasnip'
      end,
    }

    use {
      'rcarriga/nvim-dap-ui',
      requires = { 'mfussenegger/nvim-dap' },
      config = function()
        require 'j.plugins.dap'
      end,
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
      cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gdiff' },
    }
    use {
      'lewis6991/gitsigns.nvim', -- Git status signs in the gutter
      config = function()
        require 'j.plugins.gitsigns'
      end,
    }

    -- Notes
    use {
      'mickael-menu/zk-nvim',
      requires = { 'neovim/nvim-lspconfig' },
      config = function()
        require 'j.plugins.zk'
      end,
    }

    -- Testing
    use { -- Use Ctrl+Q to toggle a terminal
      'kassio/neoterm',
      config = function()
        require('j.plugins.neoterm').setup()
      end,
    }

    use {
      'nvim-neotest/neotest',
      requires = { 'KaiSpencer/neotest-vitest', 'haydenmeade/neotest-jest' },
      config = function()
        require 'j.plugins.neotest'
      end,
    }

    use {
      'ThePrimeagen/refactoring.nvim',
      config = function()
        require 'j.plugins.refactoring'
      end,
    }
    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer_compiled.lua',
  },
}
