local kommentary_config = require('kommentary.config')

local M = {}

function M.setup()
  kommentary_config.configure_language('default', {
    single_line_comment_string = 'auto',
    prefer_single_line_comments = true,
  })
end

return M
