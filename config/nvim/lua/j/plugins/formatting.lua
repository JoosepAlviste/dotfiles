return {
  'stevearc/conform.nvim',
  ft = { 'lua', 'vue', 'typescript', 'typescriptreact', 'javascript', 'json', 'jsonc', 'html', 'css' },
  opts = {
    formatters = {
      oxfmt = {
        require_cwd = true,
      },
      prettier = {
        require_cwd = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      vue = { 'eslint_d' },
      typescript = { 'eslint_d', 'oxfmt' },
      typescriptreact = { 'eslint_d' },
      javascript = { 'eslint_d' },
      json = { 'prettier', 'oxfmt' },
      jsonc = { 'prettier', 'oxfmt' },
      html = { 'oxfmt' },
      css = { 'oxfmt' },
    },
    format_on_save = {
      timeout_ms = 500,
      quiet = true,
    },
  },
}
