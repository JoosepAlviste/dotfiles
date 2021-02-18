local M = {}

function _G.tabline()
  local tabs = {}

  for i = 1,vim.fn.tabpagenr('$') do
    local tabnr = i
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local buflist = vim.fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    local bufmodified = vim.fn.getbufvar(bufnr, '&mod') == 1
    local tabpagenr = vim.fn.tabpagenr()

    table.insert(tabs, (tabnr == tabpagenr and '%#TabLineSel#' or '%#TabLine#') .. (vim.fn.empty(bufname) == 1 and ' [No Name]' or ' ') .. bufname .. ' ' .. (bufmodified and '+ ' or ''))
  end

  return table.concat(tabs, '')
end

function M.setup()
  vim.cmd [[set tabline=%!v:lua.tabline()]]
end

return M
