local map = require('j.utils').map

local M = {}

function M.setup()
  vim.g.vsnip_snippet_dir = '~/.config/nvim/vsnip'
  vim.g.vsnip_filetypes = {
    typescript = {'javascript'},
    typescriptreact = {'javascript', 'typescript'},
  }

  -- Expand or jump
  map('i', '<tab>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>']], {expr = true, noremap = false})
  map('s', '<tab>', [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>']], {expr = true, noremap = false})

  map('i', '<s-tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>']], {expr = true, noremap = false})
  map('s', '<s-tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>']], {expr = true, noremap = false})
end

return M
