vim.lsp.config('unocss', {
  on_init = function(client)
    -- Disable documentColor feature since my projects have CSS variables for
    -- UnoCSS colors, which won't work anyways
    client.server_capabilities.colorProvider = false
  end,
})
vim.lsp.enable 'unocss'
