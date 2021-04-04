local M = {}

function M.add_diagnostics_to_loclist()
  vim.lsp.diagnostic.set_loclist({open_loclist = false})
end

return M
