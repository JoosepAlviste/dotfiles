-- Automatically install packer.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  {
    'JoosepAlviste/palenightfall.nvim',
    priority = 1000,
    config = function()
      require 'j.plugins.palenightfall'
    end,
  },

  -- Core utilities
  'tpope/vim-repeat', -- Make repeat (.) command smarter
  { -- Automatic sessions
    'rmagatti/auto-session',
    config = function()
      require 'j.plugins.auto_session'
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require 'j.plugins.notify'
    end,
    dependencies = { 'palenightfall.nvim' },
  },
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 500
    end,
  },

  -- Mapping improvements
  {
    'windwp/nvim-autopairs',
    config = function()
      require 'j.plugins.autopairs'
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  -- Move between Vim & Kitty windows easily
  {
    'knubie/vim-kitty-navigator',
    build = 'cp ./*.py ~/.config/kitty/',
    event = 'VimEnter',
  },
  {
    'JoosepAlviste/cinnamon.nvim',
    branch = 'feature/skip-lines-when-scrolling',
    config = function()
      require('cinnamon').setup {
        extra_keymaps = true,
        default_delay = 2,
        max_length = 60,
        hide_cursor = true,
        scroll_limit = -1,
      }
    end,
  },

  -- Navigation
  {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'j.plugins.telescope'
    end,
    dependencies = {
      'nvim-lua/plenary.nvim', -- Useful Lua utilities

      -- FZF sorter for Telescope
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
  },
  {
    'tamago324/lir.nvim', -- File explorer
    config = function()
      require 'j.plugins.lir'
    end,
  },
  {
    'tpope/vim-projectionist', -- Alternative files
    config = function()
      require 'j.plugins.projectionist'
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  {
    'kyazdani42/nvim-tree.lua',
    enabled = false,
    config = function()
      require 'j.plugins.tree'
    end,
  },

  -- Advanced highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'j.plugins.treesitter'
    end,
    dependencies = {
      'windwp/nvim-ts-autotag', -- Automatically end & rename tags
      -- Dynamically set commentstring based on cursor location in file
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
  },

  -- Misc
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require 'j.plugins.web_devicons'
    end,
  },
  {
    'nvim-zh/colorful-winsep.nvim',
    config = function()
      local c = require('palenightfall').colors
      require('colorful-winsep').setup {
        highlight = {
          fg = c.line_numbers,
        },
      }
    end,
  },

  -- Programming
  --------------

  -- Smarts
  {
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
    dependencies = {
      {
        'hrsh7th/nvim-cmp',
        dependencies = {
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
      'folke/neodev.nvim',
    },
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require 'j.plugins.luasnip'
    end,
  },
  {
    'scoro.vim',
    url = 'git@github.com:JoosepAlviste/scoro.vim',
  },
  {
    'editorconfig/editorconfig-vim', -- Project-specific settings
    config = function()
      vim.g.EditorConfig_preserve_formatoptions = 1
    end,
  },

  -- Debugging
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require 'j.plugins.dap'
    end,
  },

  -- Web dev
  {
    'NvChad/nvim-colorizer.lua', -- Preview colors
    config = function()
      require('colorizer').setup {
        filetypes = { '*', '!packer' },
        user_default_options = {
          tailwind = 'lsp',
          names = false,
          sass = { enable = true, parsers = { css = true } },
        },
      }
    end,
  },

  {
    'axelvc/template-string.nvim',
    config = function()
      require('template-string').setup {
        filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
        remove_template_string = true,
        restore_quotes = {
          normal = [[']],
          jsx = [["]],
        },
      }
    end,
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
  },

  -- Git
  -- I only use the "blame" feature from this
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gstatus', 'Gblame', 'Gpush', 'Gpull', 'Gdiff' },
  },
  {
    'lewis6991/gitsigns.nvim', -- Git status signs in the gutter
    config = function()
      require 'j.plugins.gitsigns'
    end,
  },

  -- Notes
  {
    'mickael-menu/zk-nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require 'j.plugins.zk'
    end,
  },

  -- Testing
  { -- Use Ctrl+Q to toggle a terminal
    'kassio/neoterm',
    config = function()
      require 'j.plugins.neoterm'
    end,
    keys = {
      { '<c-q>', [[:Ttoggle<cr>]], silent = true },
      { '<c-q>', [[<c-\><c-n>:Ttoggle<cr>]], mode = 't', silent = true },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = { 'KaiSpencer/neotest-vitest', 'haydenmeade/neotest-jest' },
    config = function()
      require 'j.plugins.neotest'
    end,
  },
}, {
  install = {
    colorscheme = { 'palenightfall' },
  },
  checker = {
    enabled = true,
    frequency = 3600 * 12, -- Every 12 hours
  },
})
