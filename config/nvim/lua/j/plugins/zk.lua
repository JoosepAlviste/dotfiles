local zk = require 'zk'

local map = require('j.utils').map

zk.setup {
  picker = 'telescope',
  lsp = {
    config = {
      on_attach = require('j.plugins.lsp').on_attach,
      capabilities = require('j.plugins.lsp').capabilities,
    },
  },
}
require('telescope').load_extension 'zk'

map('n', '<leader>zn', [[:ZkNew {title=''}<left><left>]])
map('x', '<leader>zn', [[:ZkNewFromTitleSelection<cr>]], { silent = true })
map('n', '<leader>zl', [[:ZkNotes<cr>]], { silent = true })
map('n', '<leader>zt', [[:ZkTags<cr>]], { silent = true })
