local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'
local layout_strategies = require 'telescope.pickers.layout_strategies'

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

-- Add an extra line between the prompt and results so that the theme looks OK
local original_center = layout_strategies.center
layout_strategies.center = function(picker, columns, lines, layout_config)
  local res = original_center(picker, columns, lines, layout_config)

  -- Move results down one line so that the prompt bottom border is visible
  res.results.line = res.results.line + 1

  return res
end

require('telescope').setup {
  defaults = {
    prompt_prefix = '   ',
    selection_caret = '  ',
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
    path_display = function(_, path)
      local filename = path:gsub(vim.pesc(vim.loop.cwd()) .. '/', ''):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
      local tail = require('telescope.utils').path_tail(filename)
      return string.format('%s  —  %s', tail, filename)
    end,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      require('telescope.themes').get_cursor {},
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

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'notify'
require('telescope').load_extension 'ui-select'
require('telescope').load_extension 'noice'

-- New filetypes
require('plenary.filetype').add_file 'filetypes'
