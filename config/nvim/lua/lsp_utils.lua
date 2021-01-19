local lspconfig = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Configure that we accept snippets so that the server would send us snippet 
-- completion items. Snippets are not supported by default, but 
-- `vim-vsnip-integ` adds support for them.
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client)
  -- Set up keymaps
  vim.api.nvim_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', { noremap = true })

  vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { noremap = true })

  vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { noremap = true })

  -- Navigate diagnostics
  vim.api.nvim_set_keymap('n', '[g', '<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>', { noremap = true })
  vim.api.nvim_set_keymap('n', ']g', '<cmd> lua vim.lsp.diagnostic.goto_next()<cr>', { noremap = true })

  -- Show diagnostics popup with <leader>d
  vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', { noremap = true })

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.api.nvim_command [[augroup END]]
  end

  -- Set the LSP omnifunc
  vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')
end

-- Handle formatting in a smarter way
-- If the buffer has been edited before formatting has completed, do not try to 
-- apply the changes
vim.lsp.handlers['textDocument/formatting'] = function(err, _, result, _, bufnr)
  if err ~= nil or result == nil then
    return
  end

  -- If the buffer hasn't been modified before the formatting has finished, 
  -- update the buffer
  if not vim.api.nvim_buf_get_option(bufnr, 'modified') then
    local view = vim.fn.winsaveview()
    vim.lsp.util.apply_text_edits(result, bufnr)
    vim.fn.winrestview(view)
    if bufnr == vim.api.nvim_get_current_buf() then
      vim.api.nvim_command('noautocmd :update')

      -- Trigger post-formatting autocommand which can be used to refresh 
      -- gitgutter
      vim.api.nvim_command('silent doautocmd <nomodeline> User FormatterPost')
    end
  end
end

-- Customize diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = false,
    underline = true,
  }
)

-- Setting up specific language servers

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup{
  on_attach = function(client)
    -- Disable the document formatting for tsserver because we want to use efm 
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    on_attach(client)
  end,
  capabilities = capabilities,
}

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup{on_attach = on_attach, capabilities = capabilities}

-- https://github.com/vuejs/vetur/tree/master/server
lspconfig.vuels.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    vetur = {
      experimental = {
        templateInterpolationService = true,
      },
      validation = {
        templateProps = true,
      },
      completion = {
        tagCasing = 'initial',
      },
    },
  },
}

-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
lspconfig.cssls.setup{on_attach = on_attach, capabilities = capabilities}

-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
lspconfig.graphql.setup{on_attach = on_attach, capabilities = capabilities}

-- https://github.com/sumneko/lua-language-server
local system_name
if vim.fn.has('mac') == 1 then
  system_name = 'macOS'
elseif vim.fn.has('unix') == 1 then
  system_name = 'Linux'
elseif vim.fn.has('win32') == 1 then
  system_name = 'Windows'
else
  print('Unsupported system for sumneko')
end
local sumneko_root_path = vim.fn.expand('$HOME')..'/Programs/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = {
          '?.lua',
          '?/init.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
          '/usr/share/5.3/?.lua',
          '/usr/share/lua/5.3/?/init.lua'
        }
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { '' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  capabilities = capabilities,
}

-- https://github.com/vscode-langservers/vscode-json-languageserver
lspconfig.jsonls.setup{
  on_attach = on_attach,
  settings = {
    json = {
      schemas = {
        { fileMatch = { 'jsconfig.json' }; url = 'https://json.schemastore.org/jsconfig' },
        { fileMatch = { 'tsconfig.json' }; url = 'https://json.schemastore.org/tsconfig' },
        { fileMatch = { 'package.json' }; url = 'https://json.schemastore.org/package' },
      },
    },
  },
  capabilities = capabilities,
}

-- https://github.com/redhat-developer/yaml-language-server
lspconfig.yamlls.setup{
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        ['http://json.schemastore.org/gitlab-ci'] = '.gitlab-ci.yml',
        ['http://json.schemastore.org/composer'] = 'composer.yaml',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
        ['https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json'] = '.graphqlrc*',
      },
    },
  },
}

-- https://github.com/mattn/efm-langserver
local eslint = {
  lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  formatCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT} --fix-to-stdout',
  formatStdin = true,
}

lspconfig.efm.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('package.json'),
  init_options = {
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {'package.json'},
    languages = {
      typescript = {eslint},
      typescriptreact = {eslint},
      javascript = {eslint},
      vue = {eslint},
    },
  },
}