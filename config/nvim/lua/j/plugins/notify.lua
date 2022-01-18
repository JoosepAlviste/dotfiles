vim.opt.termguicolors = true

require('notify').setup {
  background_colour = require('palenightfall').colors.background,
}

vim.notify = require 'notify'

local notify = vim.notify
vim.notify = function(msg, ...)
  if type(msg) == 'string' and msg:match '%[lspconfig] Autostart for' then
    -- Do not show LSP autostart failed messages
    return
  end

  notify(msg, ...)
end
