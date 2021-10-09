local null_ls = require 'null-ls'
local b = null_ls.builtins

null_ls.config {
  sources = {
    b.diagnostics.eslint_d,
    require('null-ls.helpers').conditional(function(utils)
      local have_prettier = utils.root_has_file 'node_modules/.bin/prettier'
      return utils.root_has_file '.eslintrc.js' and b.formatting.eslint_d
        or have_prettier
          and b.formatting.prettier.with {
            command = './node_modules/.bin/prettier',
          }
    end),

    b.diagnostics.stylelint.with {
      condition = function(utils)
        return utils.root_has_file '.stylelintrc'
      end,
    },
    b.formatting.stylelint.with {
      condition = function(utils)
        return utils.root_has_file '.stylelintrc'
      end,
    },

    b.formatting.stylua.with {
      condition = function(utils)
        return utils.root_has_file 'stylua.toml'
      end,
    },

    b.code_actions.gitsigns,
  },
  diagnostics_format = '#{m} [#{c}]',
}

require('lspconfig')['null-ls'].setup {
  on_attach = require('j.plugins.lsp').on_attach,
}
