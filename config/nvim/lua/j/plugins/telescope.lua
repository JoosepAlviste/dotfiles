local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local map = require('j.utils').map
local custom_pickers = require 'j.plugins.telescope_custom_pickers'

map('n', '<c-p>', builtin.find_files)
map('n', '<leader>ff', custom_pickers.live_grep)

map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fr', builtin.oldfiles)
map('n', '<leader>fq', builtin.quickfix)

map('n', '<leader>fx', builtin.git_status)
map('n', '<leader>fc', builtin.git_commits)
map('n', '<leader>fg', builtin.git_branches)

map('n', '<leader>fs', function()
  custom_pickers.scripts(require('telescope.themes').get_dropdown {})
end)

require('telescope').setup {
  defaults = {
    prompt_prefix = ' ❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<s-up>'] = actions.cycle_history_prev,
        ['<s-down>'] = actions.cycle_history_next,

        ['<C-w>'] = function()
          vim.api.nvim_input '<c-s-w>'
        end,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
  },
  pickers = {
    oldfiles = {
      sort_lastused = true,
      cwd_only = true,
    },
    find_files = {
      hidden = true,
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

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'notify'
require('telescope').load_extension 'ui-select'
