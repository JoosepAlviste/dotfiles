return {
  'mfussenegger/nvim-lint',
  ft = { 'vue', 'typescript', 'typescriptreact', 'javascript' },
  config = function()
    require('lint').linters_by_ft = {
      vue = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
