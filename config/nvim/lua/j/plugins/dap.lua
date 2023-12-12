local dap = require 'dap'
local dapui = require 'dapui'

local map = require('j.utils').map

require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('dap-vscode-js').setup {
  debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
}

for _, language in ipairs { 'typescriptreact', 'typescript', 'javascript', 'vue' } do
  require('dap').configurations[language] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach debugger to existing `node --inspect` process',
      resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
      cwd = '${workspaceFolder}',
      -- we don't want to debug code inside node_modules, so skip it!
      skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
    },
    {
      type = 'pwa-chrome',
      name = 'Launch Chrome to debug client',
      request = 'launch',
      url = 'http://localhost:3000',
      sourceMaps = true,
      protocol = 'inspector',
      port = 9222,
      webRoot = '${workspaceFolder}/src',
      -- skip files from vite's hmr
      skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
    },

    {
      type = 'pwa-node',
      name = 'Attach to testing',
      port = 9232,
      request = 'attach',
      skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      outFiles = { '${workspaceFolder}/dist/**/*.js' },
      cwd = '${workspaceFolder}',
    },

    {
      type = 'pwa-node',
      name = 'Attach Service Platform',
      port = 9231,
      request = 'attach',
      skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      outFiles = { '${workspaceFolder}/service-platform/dist/**/*.js' },
      -- localRoot DOES NOT WORK in Neovim for some reason, but it works in VSCode
      localRoot = '${workspaceFolder}/service-platform',
      remoteRoot = '${workspaceFolder}/service-platform',
      cwd = '${workspaceFolder}/service-platform',
    },
    {
      name = 'Attach Service SD',
      port = 9230,
      request = 'attach',
      skipFiles = { '<node_internals>/**', '**/node_modules/**' },
      type = 'pwa-node',
      outFiles = { '${workspaceFolder}/service-sd/dist/**/*.js' },
      localRoot = '${workspaceFolder}/service-sd',
      remoteRoot = '${workspaceFolder}/service-sd',
      cwd = '${workspaceFolder}/service-sd',
    },
  }
end

vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = '', numhl = '' })

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

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open { reset = true }
end
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
