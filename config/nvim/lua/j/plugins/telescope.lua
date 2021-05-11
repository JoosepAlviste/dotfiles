local actions = require('telescope.actions')

local map = require('j.utils').map

map('n', '<c-p>',      [[<cmd>Telescope find_files<cr>]])
map('n', '<leader>ff', [[<cmd>lua require'j.plugins.telescope'.live_grep()<cr>]])

map('n', '<leader>fb', [[<cmd>Telescope buffers<cr>]])
map('n', '<leader>fh', [[<cmd>Telescope help_tags<cr>]])
map('n', '<leader>fr', [[<cmd>lua require('telescope').extensions.frecency.frecency()<cr>]])
map('n', '<leader>fq', [[<cmd>lua require'telescope.builtin'.quickfix()<cr>]])

map('n', '<leader>fx', [[<cmd>lua require'telescope.builtin'.git_status()<cr>]])
map('n', '<leader>fc', [[<cmd>lua require'telescope.builtin'.git_commits()<cr>]])

map('n', '<leader>fgw', [[<cmd>lua require'telescope.builtin'.grep_string()<cr>]])

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
      }
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

require('telescope').load_extension('fzf')

local M = {}

function M.live_grep()
  require('telescope.builtin').live_grep({
    shorten_path = true,
  })
end

function M.grep_string()
  require("telescope.builtin").grep_string({
    shorten_path = true,
    search = vim.fn.input("Grep > "),
  })
end

return M
