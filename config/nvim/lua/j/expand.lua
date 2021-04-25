local termcode = require('j.utils').termcode

local M = {}

-- When creating a new line with o, make sure there is a trailing comma on the 
-- current line. Mainly meant to be used in JSON files.
function M.insert_trailing_comma()
  -- Add the trailing comma if it doesn't exist
  vim.cmd [[silent! keeppatterns substitute/\(.*[^{[][^,{[]\)$/\1,/g]]
  -- And add the new line
  vim.fn.feedkeys(termcode('A<cr>'))
end

return M
