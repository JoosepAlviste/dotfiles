local compe = require('compe')

local map = require('j.utils').map

-- Configuration
compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    vsnip = true,
    calc = true,
  },
}

-- Mappings
local opts = {expr = true, silent = true}
map('i', '<c-space>', 'compe#complete()', opts)
map('i', '<c-e>', 'compe#close(\'<c-e>\')', opts)
map('i', '<c-y>', 'compe#confirm(\'<c-y>\')', opts)
