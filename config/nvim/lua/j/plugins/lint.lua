return {
  'mfussenegger/nvim-lint',
  ft = { 'vue', 'typescript', 'typescriptreact', 'javascript' },
  config = function()
    local stylelint = vim.fn.executable(require('lint').linters['stylelint'].cmd()) == 1 and 'stylelint' or nil

    require('lint').linters_by_ft = {
      vue = { 'eslint_d', stylelint },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
      css = { stylelint },
      scss = { stylelint },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
      callback = function(args)
        require('lint').try_lint(nil, {
          cwd = vim.fs.root(args.file, { '.eslintrc.json', '.git' }),
        })
      end,
    })
  end,
}
