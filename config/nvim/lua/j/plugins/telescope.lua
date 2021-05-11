local actions = require('telescope.actions')

local map = require('j.utils').map

map('n', '<c-p>',      [[<cmd>Telescope find_files<cr>]])
map('n', '<leader>ff', [[<cmd>Telescope live_grep<cr>]])

map('n', '<leader>fb', [[<cmd>Telescope buffers<cr>]])
map('n', '<leader>fh', [[<cmd>Telescope help_tags<cr>]])
map('n', '<leader>fr', [[<cmd>lua require'telescope.builtin'.oldfiles({cwd_only=true})<cr>]])
map('n', '<leader>fq', [[<cmd>lua require'telescope.builtin'.quickfix()<cr>]])

map('n', '<leader>fx', [[<cmd>lua require'telescope.builtin'.git_status()<cr>]])
map('n', '<leader>fc', [[<cmd>lua require'telescope.builtin'.git_commits()<cr>]])

require('telescope').setup({
  defaults = {
    prompt_prefix = ' ➤ ',
    selection_caret = '➤ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
      }
    }
  },
})

require('telescope').load_extension('fzy_native')
