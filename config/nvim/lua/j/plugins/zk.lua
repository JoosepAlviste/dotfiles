local map = require('j.utils').map

require('zk').setup {
  lsp = {
    config = {
      on_attach = require('j.plugins.lsp').on_attach,
      capabilities = require('j.plugins.lsp').capabilities,
    },
  },
}
require('telescope').load_extension 'zk'

map('n', '<leader>zn', [[:lua require('zk').new(nil, {title=''})<left><left><left>]])
map('x', '<leader>zn', [[<cmd>lua require('zk').new_link()<cr>]])
map('n', '<leader>zl', [[<cmd>lua require('telescope').extensions.zk.notes()<cr>]])
map('n', '<leader>zt', [[<cmd>lua require('telescope').extensions.zk.tags()<cr>]])
