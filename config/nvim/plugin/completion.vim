lua <<EOF
  local nvim_lsp = require('nvim_lsp')
  local nvim_command = vim.api.nvim_command
  local completion = require('completion')
  local completion_utils = require('completion_utils')

  completion_utils.configure_lsp()

  local on_attach = function(client, bufnr)
    completion.on_attach(client, bufnr)
    -- Show diagnostics details on cursor hold
    -- nvim_command('autocmd CursorHold <buffer> lua require"completion_utils".show_line_diagnostics()')

    -- Highlight symbols on cursor hold
    vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-space>', 'completion#trigger_completion()', {
      noremap = true, silent = true, expr = true,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua require"completion_utils".show_line_diagnostics()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end

  -- Attach language servers
  local servers = {
    'tsserver',
    -- 'flow',
  }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

let g:completion_enable_auto_paren = 1
let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_ignore_case = 1
