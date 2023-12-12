local M = {}

function M.tabline()
  local tabs = {}

  for i = 1, vim.fn.tabpagenr '$' do
    local tabnr = i
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    local bufmodified = vim.fn.getbufvar(bufnr, '&mod') == 1
    local tabpagenr = vim.fn.tabpagenr()

    local is_selected = tabnr == tabpagenr

    local tab_highlight = is_selected and '%#TabLineSel#' or '%#TabLine#'
    local tab_text_prefix = vim.fn.empty(bufname) == 1 and ' [No Name]' or ' '

    table.insert(tabs, tab_highlight .. tab_text_prefix .. bufname .. ' ' .. (bufmodified and '+  ' or ' '))
  end

  return table.concat(tabs, '')
end

vim.o.tabline = '%!v:lua.require("j.tabline").tabline()'

return M
