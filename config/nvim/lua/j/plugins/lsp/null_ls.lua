local null_ls = require 'null-ls'
local Path = require 'plenary.path'
local b = null_ls.builtins

null_ls.setup {
  sources = {
    b.formatting.prettier.with {
      filetypes = { 'typescriptreact', 'typescript' },
      condition = function(utils)
        local has_prettier = utils.root_has_file '.prettierrc.json' 
        if not has_prettier then
          return false
        end

        local package_json_path = Path:new 'package.json'
        local package_json_contents = package_json_path:read()
        local package_json = vim.fn.json_decode(package_json_contents)

        local has_eslint_prettier_integration = package_json['devDependencies']['@developers/eslint-config-scoro']
          ~= nil

        return not has_eslint_prettier_integration
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
