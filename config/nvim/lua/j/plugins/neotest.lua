local neotest = require 'neotest'

local map = require('j.utils').map

neotest.setup {
  consumers = {
    statusline = require 'j.plugins.neotest_consumer_statusline',
  },

  adapters = {
    require 'neotest-jest' {
      jestCommand = 'npm test --',
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    },
    require 'neotest-vitest' {
      vitestCommand = 'pnpm test --',
      env = { CI = true },
    },
  },

  output = {
    enabled = true,
    open_on_run = true,
  },
}

map('n', '<leader>tn', function()
  neotest.run.run()
end)
map('n', '<leader>tf', function()
  neotest.run.run(vim.fn.expand '%')
end)
map('n', '<leader>ta', function()
  neotest.run.run 'src'
end)
map('n', '<leader>tl', function()
  neotest.run.run_last()
end)
