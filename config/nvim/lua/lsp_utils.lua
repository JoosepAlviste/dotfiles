local lspconfig = require'lspconfig'
local saga = require 'lspsaga'

saga.init_lsp_saga{
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Configure that we accept snippets so that the server would send us snippet 
-- completion items. Snippets are not supported by default, but 
-- `vim-vsnip-integ` adds support for them.
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Set up keymaps
  local opts = { noremap = true, silent = true }
  buf_map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_map('n', 'gr', '<cmd>lua require("lspsaga.provider").lsp_finder()<cr>', opts)
  buf_map('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<cr>', opts)
  buf_map('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  buf_map('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)

  buf_map('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)

  buf_map('n', '<leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<cr>', opts)

  buf_map('i', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>', opts)

  -- Navigate diagnostics
  buf_map('n', '[g', '<cmd> lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_map('n', ']g', '<cmd> lua vim.lsp.diagnostic.goto_next()<cr>', opts)

  -- Show diagnostics popup with <leader>d
  buf_map('n', '<leader>d', '<cmd>lua require"lspsaga.diagnostic".show_line_diagnostics()<cr>', opts)

  -- Show a lightbulb if there are any code actions available
  vim.api.nvim_command [[augroup LspUtils]]
  vim.api.nvim_command [[autocmd! * <buffer>]]
  vim.api.nvim_command [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  vim.api.nvim_command [[augroup END]]

  -- Set the LSP omnifunc
  vim.api.nvim_command('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

  vim.api.nvim_command'command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())'
end

-- Setting up specific language servers

-- https://github.com/theia-ide/typescript-language-server
lspconfig.tsserver.setup{
  on_attach = function(client, bufnr)
    -- Disable the document formatting for tsserver because we want to use efm 
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- https://github.com/iamcco/vim-language-server
lspconfig.vimls.setup{on_attach = on_attach, capabilities = capabilities}

-- https://github.com/vuejs/vetur/tree/master/server
lspconfig.vuels.setup{
  on_attach = function(client, bufnr)
    -- Disable the document formatting for vuels because we want to use efm 
    -- with ESLint
    client.resolved_capabilities.document_formatting = false

    on_attach(client, bufnr)
  end,
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
        }
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'trailing-space' },
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

-- https://intelephense.com
lspconfig.intelephense.setup{
  on_attach = on_attach,
  settings = {
    intelephense = {
      environment = {
        shortOpenTag = true,
      },
    },
  },
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
  lintCommand = 'eslint_d -f ~/dotfiles/resources/eslint-formatter-vim.js --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {'%f:%l:%c:%t: %m'},
  formatCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT} --fix-to-stdout',
  formatStdin = true,
}

lspconfig.efm.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern('package.json'),
  filetypes = {'typescript', 'typescriptreact', 'vue', 'javascript'},
  init_options = {
    documentFormatting = false,
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
