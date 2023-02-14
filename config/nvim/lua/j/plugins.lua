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
    dev = false,
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
    event = 'VeryLazy',
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
  { -- Improve folding
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require 'j.plugins.ufo'
    end,
  },

  -- Mapping improvements
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require 'j.plugins.autopairs'
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, 'gcc' },
    },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'kylechui/nvim-surround',
    keys = { 'ys', 'cs', 'ds' },
    config = function()
      require('nvim-surround').setup()
    end,
  },
  -- Move between Vim & Kitty windows easily
  {
    'knubie/vim-kitty-navigator',
    build = 'cp ./*.py ~/.config/kitty/',
    keys = { '<c-h>', '<c-j>', '<c-k>', '<c-l>' },
  },
  {
    'JoosepAlviste/cinnamon.nvim',
    branch = 'feature/skip-lines-when-scrolling',
    event = 'BufEnter',
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

  -- UI
  {
    'folke/noice.nvim',
    config = function()
      require 'j.plugins.noice'
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },

  -- Navigation
  {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
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
      { 'JoosepAlviste/nvim-ts-context-commentstring', dev = false },
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

  -- Programming
  --------------

  -- Automatic package management
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()

      local ensure_installed = {
        -- Language servers
        'css-lsp',
        'dockerfile-language-server',
        'graphql-language-service-cli',
        'json-lsp',
        'intelephense',
        'typescript-language-server',
        'vue-language-server',
        'yaml-language-server',
        'lua-language-server',
        'terraform-ls',
        'eslint-lsp',
        'ltex-ls',
        'prisma-language-server',
        'html-lsp',
        'svelte-language-server',
        'tailwindcss-language-server',
        'zk',

        -- Linting and formatting
        'eslint_d',
        'stylua',

        -- DAP servers
        'node-debug2-adapter',
        'firefox-debug-adapter',
        'php-debug-adapter',
      }

      vim.api.nvim_create_user_command('MasonInstallAll', function()
        vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
      end, {})
    end,
  },

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
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
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
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
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
    keys = {
      '<localleader>dc',
      '<localleader>do',
      '<localleader>di',
      '<localleader>dt',
      '<localleader>db',
      '<localleader>dB',
      '<localleader>dr',
      '<localleader>du',
    },
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
    event = 'InsertEnter',
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
    ft = 'markdown',
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
    keys = {
      '<leader>tn',
      '<leader>tf',
      '<leader>ta',
      '<leader>tl',
      '<leader>ts',
    },
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
    frequency = 3600 * 60 * 12, -- Every 12 hours
    notify = false,
  },
  dev = {
    path = '~/Code/Projects',
  },
})
