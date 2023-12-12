return vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities(),
  {
    workspace = {
      -- PERF: didChangeWatchedFiles is too slow.
      -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
      didChangeWatchedFiles = { dynamicRegistration = false },
    },
  }
)
