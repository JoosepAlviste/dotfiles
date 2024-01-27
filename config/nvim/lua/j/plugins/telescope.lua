return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  cmd = 'Telescope',
  dependencies = { 'nvim-lua/plenary.nvim', 'natecraddock/telescope-zf-native.nvim' },
  opts = function()
    local actions = require 'telescope.actions'
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
          },
        },
      },
      pickers = {
        oldfiles = {
          sort_lastused = true,
          cwd_only = true,
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
    }
  end,

  config = function(_, opts)
    require('telescope').setup(opts)

    require('telescope').load_extension 'zf-native'
  end,

  keys = {
    {
      '<c-p>',
      function()
        require('j.telescope_pretty_pickers').pretty_files_picker { picker = 'find_files' }
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
        require('j.telescope_pretty_pickers').pretty_files_picker { picker = 'oldfiles' }
      end,
    },
    { '<leader>fx', '<cmd>Telescope git_status<cr>' },
    { '<leader>fc', '<cmd>Telescope git_commits<cr>' },
  },
}
