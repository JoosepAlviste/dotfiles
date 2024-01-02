-- When creating a new line with o, make sure there is a trailing comma on the
-- current line
vim.keymap.set('n', 'o', function()
  return require('j.json').add_trailing_comma_if_needed()
end, { buffer = true, expr = true })
