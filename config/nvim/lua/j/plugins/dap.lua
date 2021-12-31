local dap = require 'dap'

local map = require('j.utils').map

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv 'HOME' .. '/Code/Programs/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

require('dapui').setup()

map('n', '<F5>', dap.continue, { silent = true })
map('n', '<F6>', dap.step_over, { silent = true })
map('n', '<F7>', dap.step_into, { silent = true })
map('n', '<F8>', dap.step_out, { silent = true })
--
-- map('n', '<leader>db', [[:lua require('dap').toggle_breakpoint()<cr>]], { silent = true })
-- map(
--   'n',
--   '<leader>dB',
--   [[:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]],
--   { silent = true }
-- )
-- map('n', '<leader>dr', [[:lua require('dap').repl_open()<cr>]], { silent = true })
--
-- map('n', '<leader>du', [[:lua require('dapui').toggle()<cr>]], { silent = true })
