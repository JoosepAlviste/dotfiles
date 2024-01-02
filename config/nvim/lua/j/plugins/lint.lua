return {
  'mfussenegger/nvim-lint',
  ft = { 'vue', 'typescript', 'typescriptreact', 'javascript' },
  config = function()
    local util = require 'lspconfig.util'

    require('lint').linters_by_ft = {
      vue = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
      callback = function(args)
        require('lint').try_lint(nil, {
          cwd = util.root_pattern { '.eslintrc.json', 'package.json', '.git' }(args.file),
        })
      end,
    })
  end,
}
