-- https://github.com/mattn/efm-langserver
local eslint_lint = {
  lintCommand = 'eslint_d -f ~/dotfiles/resources/eslint-formatter-vim.js --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c:%t: %m'},
}

local eslint_format = {
  formatCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT} --fix-to-stdout',
  formatStdin = true,
}

local prettier = {
  formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local stylelint = {
  lintCommand = './node_modules/.bin/stylelint --cache --formatter unix --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c: %m [%trror]'}
}

local function file_exists(name)
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local eslint_or_prettier_format = file_exists('.eslintrc.js')
  and eslint_format
  or prettier

require('lspconfig').efm.setup {
  on_attach = require('j.plugins.lsp').on_attach,
  root_dir = require('lspconfig').util.root_pattern('package.json'),
  filetypes = {'typescript', 'typescriptreact', 'vue', 'javascript', 'scss'},
  init_options = {
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {'package.json'},
    languages = {
      typescript = {eslint_lint, eslint_or_prettier_format},
      typescriptreact = {eslint_lint, eslint_or_prettier_format},
      javascript = {eslint_lint, eslint_or_prettier_format},
      vue = {eslint_lint, stylelint, prettier},
      scss = {stylelint, prettier},
    },
  },
}
