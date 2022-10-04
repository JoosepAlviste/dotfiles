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

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = { os.getenv 'HOME' .. '/Code/Programs/vscode-firefox-debug/dist/adapter.bundle.js' },
}

dap.configurations.typescript = {
  {
    name = 'Debug with Firefox',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = 'http://localhost:3000',
    webRoot = '${workspaceFolder}',
  },
}

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { os.getenv 'HOME' .. '/Code/Programs/vscode-php-debug/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    hostname = 'localhost.scoro.ee',
    port = 9003,
    pathMappings = {
      ['/var/www/scoro'] = os.getenv 'SCORO_PATH' .. '/scoro-base',
    },
  },
}

require('dapui').setup()

vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

map('n', '<localleader>dc', dap.continue, { silent = true })
map('n', '<localleader>do', dap.step_over, { silent = true })
map('n', '<localleader>di', dap.step_into, { silent = true })
map('n', '<localleader>dt', dap.step_out, { silent = true })

map('n', '<localleader>db', [[:lua require('dap').toggle_breakpoint()<cr>]], { silent = true })
map(
  'n',
  '<localleader>dB',
  [[:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>]],
  { silent = true }
)
map('n', '<localleader>dr', [[:lua require('dap').repl_open()<cr>]], { silent = true })

map('n', '<localleader>du', [[:lua require('dapui').toggle()<cr>]], { silent = true })
