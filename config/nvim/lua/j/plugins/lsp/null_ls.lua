local null_ls = require 'null-ls'
local b = null_ls.builtins

null_ls.setup {
  sources = {
    b.formatting.prettier.with {
      filetypes = { 'typescriptreact', 'typescript' },
      condition = function(utils)
        return utils.root_has_file '.prettierrc.json' and not utils.root_has_file '.eslintrc.js'
      end,
      command = './node_modules/.bin/prettier',
    },

    b.formatting.prettier.with {
      filetypes = { 'graphql' },
      condition = function(utils)
        return utils.root_has_file '.prettierrc.json'
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
}
