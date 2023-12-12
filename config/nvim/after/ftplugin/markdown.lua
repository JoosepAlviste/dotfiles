-- Settings

vim.opt_local.spell = true

vim.opt_local.wrap = true
vim.opt_local.textwidth = 80

-- Disable some weird autoindenting
-- https://github.com/plasticboy/vim-markdown/issues/126
vim.opt_local.indentexpr = ''

-- Mappings

local function is_in_list()
  return vim.fn.match(vim.fn.getline '.', '\\s*[*\\-+]\\s') ~= -1
end

vim.keymap.set('i', '<cr>', function()
  if is_in_list() then
    return '<cr>- '
  else
    return '<cr>'
  end
end, { buffer = true, expr = true })
vim.keymap.set('n', 'o', function()
  if is_in_list() then
    return 'o- '
  else
    return 'o'
  end
end, { buffer = true, expr = true })
vim.keymap.set('n', 'O', function()
  if is_in_list() then
    return 'O- '
  else
    return 'O'
  end
end, { buffer = true, expr = true })

vim.keymap.set('i', '<tab>', function()
  if is_in_list() then
    return '<esc>>>A'
  else
    return '<tab>'
  end
end, { buffer = true, expr = true })
vim.keymap.set('i', '<s-tab>', function()
  if is_in_list() then
    return '<esc><<A'
  else
    return '<tab>'
  end
end, { buffer = true, expr = true })
