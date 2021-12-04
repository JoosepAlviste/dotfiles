local actions = require 'telescope.actions'

local map = require('j.utils').map
local custom_pickers = require 'j.plugins.telescope_custom_pickers'

map('n', '<c-p>', [[<cmd>lua require'telescope.builtin'.find_files()<cr>]])
map('n', '<leader>ff', [[<cmd>lua require'j.plugins.telescope_custom_pickers'.live_grep()<cr>]])

map('n', '<leader>fb', [[<cmd>lua require'telescope.builtin'.buffers()<cr>]])
map('n', '<leader>fh', [[<cmd>lua require'telescope.builtin'.help_tags()<cr>]])
map('n', '<leader>fr', [[<cmd>lua require'telescope.builtin'.oldfiles()<cr>]])
map('n', '<leader>fq', [[<cmd>lua require'telescope.builtin'.quickfix()<cr>]])

map('n', '<leader>fx', [[<cmd>lua require'telescope.builtin'.git_status()<cr>]])
map('n', '<leader>fc', [[<cmd>lua require'telescope.builtin'.git_commits()<cr>]])

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
