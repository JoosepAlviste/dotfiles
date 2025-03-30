return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
      'danielfalk/smart-open.nvim',
      dependencies = {
        'kkharji/sqlite.lua',
        { 'nvim-telescope/telescope-fzy-native.nvim' },
      },
      opts = {
        mappings = {
          i = {
            -- Delete word backward, might be able to remove once this is resolved:
            -- https://github.com/danielfalk/smart-open.nvim/issues/71
            ['<C-w>'] = function()
              vim.api.nvim_input '<c-s-w>'
            end,
          },
        },
      },
    },
  },
  opts = function()
    local actions = require 'telescope.actions'
    local themes = require 'telescope.themes'
    local custom_pickers = require 'j.telescope_custom_pickers'

    return {
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,

            ['<s-up>'] = actions.cycle_history_prev,
            ['<s-down>'] = actions.cycle_history_next,

            ['<c-w>'] = function()
              vim.api.nvim_input '<c-s-w>'
            end,
            ['<c-u>'] = function()
              vim.api.nvim_input '<c-s-u>'
            end,
            ['<c-a>'] = function()
              vim.api.nvim_input '<home>'
            end,
            ['<c-e>'] = function()
              vim.api.nvim_input '<end>'
            end,

            ['<c-f>'] = actions.preview_scrolling_down,
            ['<c-b>'] = actions.preview_scrolling_up,

            ['<c-p>'] = require('telescope.actions.layout').toggle_preview,
          },
        },
      },
      pickers = {
        oldfiles = {
          sort_lastused = true,
          cwd_only = true,
          path_display = { 'filename_first' },
        },
        find_files = {
          hidden = true,
          find_command = {
            'rg',
            '--files',
            '--color',
            'never',
            '--ignore-file',
            vim.env.XDG_CONFIG_HOME .. '/ripgrep/ignore',
          },
        },
        live_grep = {
          path_display = { 'shorten' },
          mappings = {
            i = {
              ['<c-f>'] = custom_pickers.actions.set_extension,
              ['<c-l>'] = custom_pickers.actions.set_folders,
            },
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          themes.get_cursor {},
        },
      },
    }
  end,

  config = function(_, opts)
    require('telescope').setup(opts)

    require('telescope').load_extension 'smart_open'
    require('telescope').load_extension 'ui-select'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'TelescopeFindPre',
      callback = function()
        vim.opt_local.winborder = 'none'
        vim.api.nvim_create_autocmd('WinLeave', {
          once = true,
          callback = function()
            vim.opt_local.winborder = 'rounded'
          end,
        })
      end,
    })
  end,

  keys = {
    {
      '<c-p>',
      function()
        local ignores = require('telescope._extensions.smart_open.default_config').ignore_patterns

        require('telescope').extensions.smart_open.smart_open {
          cwd_only = true,
          ignore_patterns = vim.list_extend(ignores, { 'node_modules/*' }),
        }
      end,
    },
    {
      '<leader>ff',
      function()
        require('j.telescope_custom_pickers').live_grep()
      end,
    },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    {
      '<leader>fr',
      function()
        require('telescope.builtin').oldfiles()
      end,
    },
    { '<leader>fx', '<cmd>Telescope git_status<cr>' },
    { '<leader>fc', '<cmd>Telescope git_commits<cr>' },
    { '<leader>ca', vim.lsp.buf.code_action },
  },
}
