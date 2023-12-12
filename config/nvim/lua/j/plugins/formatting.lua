return {
  'stevearc/conform.nvim',
  ft = { 'lua', 'vue', 'typescript', 'typescriptreact', 'javascript' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      vue = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    })
  end,
}
