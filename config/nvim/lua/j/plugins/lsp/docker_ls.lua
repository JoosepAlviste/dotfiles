-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
require('lspconfig').dockerls.setup {
  capabilities = require('j.plugins.lsp').capabilities,
}
