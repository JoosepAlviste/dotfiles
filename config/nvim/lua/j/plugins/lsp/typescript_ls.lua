local vue_language_server_path = vim.fn.expand '$HOME/dotfiles/pnpm-global/5/node_modules' .. '/@vue/typescript-plugin'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = {
      tsserver = {
        maxTsServerMemory = 8192,
        nodePath = 'node',
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})
vim.lsp.enable 'vtsls'
