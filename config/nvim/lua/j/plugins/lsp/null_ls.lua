local util = require 'lspconfig.util'
local null_ls = require 'null-ls'
local b = null_ls.builtins

null_ls.config {
  sources = {
    -- b.diagnostics.eslint_d,
    -- require('null-ls.helpers').conditional(function(utils)
    --   local have_prettier = utils.root_has_file 'node_modules/.bin/prettier'
    --   local have_eslint = utils.root_has_file '.eslintrc.js'
    --
    --   return have_eslint and b.formatting.eslint_d
    --     or have_prettier
    --       and b.formatting.prettier.with {
    --         command = './node_modules/.bin/prettier',
    --       }
    -- end),

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
      filetypes = { 'css', 'scss', 'vue' },
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
}

require('lspconfig')['null-ls'].setup {
  on_attach = require('j.plugins.lsp').on_attach,
  root_dir = util.root_pattern('package.json', '.git'),
}
