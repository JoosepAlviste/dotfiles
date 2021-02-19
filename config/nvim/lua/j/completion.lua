local compe = require('compe')

local map = require('j.utils').map

local M = {}

function M.setup()
  compe.setup {
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
      ultisnips = true,
    },
  }

  local opts = {expr = true, silent = true}
  map('i', '<c-space>', 'compe#complete()', opts)
  map('i', '<c-e>', 'compe#close(\'<c-e>\')', opts)
  map('i', '<c-y>', 'compe#confirm(\'<c-y>\')', opts)
end

return M
