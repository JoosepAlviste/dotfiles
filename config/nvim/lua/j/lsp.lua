local lspconfig = require('lspconfig')

local M = {}

local function on_attach(client, bufnr)
  local function buf_map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Set up keymaps
  local opts = {noremap = true, silent = true}
  buf_map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_map('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

  buf_map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  -- Navigate diagnostics
  buf_map('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_map('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  -- Show diagnostics popup with <leader>d
  buf_map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

  -- Formatting
  buf_map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

function M.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "»",
      spacing = 4,
    },
    signs = false,
    update_in_insert = false,
  }
  )

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- Configure that we accept snippets so that the server would send us snippet 
  -- completion items. Snippets are not supported by default, but 
  -- `vim-vsnip-integ` adds support for them.
  capabilities.textDocument.completion.completionItem.snippetSupport = true

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

	-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
	lspconfig.graphql.setup{on_attach = on_attach, capabilities = capabilities}

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
  local sumneko_root_path = vim.fn.expand('$HOME') .. '/Programs/lua-language-server'
  local sumneko_binary = sumneko_root_path..'/bin/' .. system_name .. '/lua-language-server'

  lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
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
          globals = {'vim'},
          disable = {'trailing-space'},
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
end

return M
