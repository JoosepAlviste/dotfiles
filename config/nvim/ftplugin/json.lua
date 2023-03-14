local termcode = require('j.utils').termcode

-- When creating a new line with o, make sure there is a trailing comma on the
-- current line
vim.keymap.set('n', 'o', function()
  -- Add the trailing comma if it doesn't exist
  vim.cmd [[silent! keeppatterns substitute/\(.*[^{[][^,{[]\)$/\1,/g]]
  -- And add the new line
  vim.fn.feedkeys(termcode 'A<cr>')
end, { buffer = true })
