local null_ls = require 'null-ls'
local is_npm_package_installed = require('j.utils').is_npm_package_installed
local b = null_ls.builtins

null_ls.setup {
  sources = {
    b.formatting.prettier.with {
      filetypes = { 'typescriptreact', 'typescript', 'vue', 'javascript' },
      condition = function(utils)
        local has_prettier = utils.root_has_file('.prettierrc.json', '.prettierrc')
        if not has_prettier then
          return false
        end

        local has_eslint_prettier_integration = is_npm_package_installed '@developers/eslint-config-scoro'

        return not has_eslint_prettier_integration
      end,
      command = './node_modules/.bin/prettier',
    },

    b.formatting.prettier.with {
      filetypes = { 'graphql', 'css' },
      condition = function(utils)
        return utils.root_has_file { '.prettierrc.json', 'prettier.config.js' }
      end,
      command = './node_modules/.bin/prettier',
    },

    b.diagnostics.stylelint.with {
      filetypes = { 'css', 'scss', 'vue' },
      condition = function(utils)
        return utils.root_has_file '.stylelintrc.json'
      end,
      command = './node_modules/.bin/stylelint',
    },
    b.formatting.stylelint.with {
      filetypes = { 'css', 'scss' },
      condition = function(utils)
        return utils.root_has_file '.stylelintrc.json'
      end,
      command = './node_modules/.bin/stylelint',
    },

    b.formatting.stylua.with {
      condition = function(utils)
        return utils.root_has_file 'stylua.toml'
      end,
    },

    b.code_actions.gitsigns,
  },
  diagnostics_format = '#{m} [#{c}]',
  on_attach = require('j.plugins.lsp').on_attach,
  root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'Makefile', '.git', 'package.json'),
}
