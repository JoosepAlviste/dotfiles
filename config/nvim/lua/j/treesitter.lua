local treesitter = require('nvim-treesitter.configs')

local M = {}

function M.setup()
  treesitter.setup {
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = {
      enable = true,
    },
    ensure_installed = {
      'query', 'javascript', 'jsdoc', 'typescript', 'tsx', 'json', 'php',
      'python', 'html', 'graphql', 'lua', 'yaml',
    },
  }
end

return M
