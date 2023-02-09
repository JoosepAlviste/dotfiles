vim.opt.termguicolors = true

require('notify').setup()

vim.notify = require 'notify'

local notify = vim.notify
vim.notify = function(msg, ...)
  if type(msg) == 'string' then
    local is_suppressed_message = msg:match '%[lspconfig] Autostart for' or msg:match 'No information available'
    if is_suppressed_message then
      -- Do not show some messages
      return
    end
  end

  notify(msg, ...)
end
