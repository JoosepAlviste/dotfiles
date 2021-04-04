local utils = require('j.utils')
local map = utils.map
local create_augroups = utils.create_augroups

map('n', '<c-p>',      [[<cmd>lua require('j.plugins.fzf.functions').files()<cr>]])
map('n', '<leader>ff', [[<cmd>lua require('j.plugins.fzf.functions').grep()<cr>]])
map('n', '<leader>fa', [[<cmd>lua require('j.plugins.fzf.functions').grep()<cr>]])
map('v', '<space>ff',  [[<cmd>lua require('j.plugins.fzf.functions').grep_selected()<cr>]])
map('n', '<leader>fr', [[<cmd>lua require('j.plugins.fzf.functions').history()<cr>]])
map('n', '<leader>fx', [[<cmd>lua require('j.plugins.fzf.functions').git_status()<cr>]])
map('n', '<leader>fd', [[<cmd>lua require('j.plugins.fzf.functions').directories()<cr>]])
map('n', '<leader>fh', [[<cmd>lua require('j.plugins.fzf.functions').help_tags()<cr>]])

create_augroups({
  fzf = {
    {'FileType', 'fzf', [[tunmap <buffer> <esc>]]},
  },
})

-- Grep in files with the given extension
vim.cmd [[command! -nargs=1 GrepFT lua require('j.plugins.fzf.functions').grep_folder('**/*.<args>')]]
