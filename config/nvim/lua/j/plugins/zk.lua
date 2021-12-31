local zk = require 'zk'

local map = require('j.utils').map

zk.setup {
  lsp = {
    config = {
      on_attach = require('j.plugins.lsp').on_attach,
      capabilities = require('j.plugins.lsp').capabilities,
    },
  },
}
require('telescope').load_extension 'zk'

map('n', '<leader>zn', [[:lua require('zk').new(nil, {title=''})<left><left><left>]])
map('x', '<leader>zn', zk.new_link)
map('n', '<leader>zl', require('telescope').extensions.zk.notes)
map('n', '<leader>zt', require('telescope').extensions.zk.tags)
