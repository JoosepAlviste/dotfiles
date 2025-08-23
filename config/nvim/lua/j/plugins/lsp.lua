return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true,
      }

      vim.diagnostic.config {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'LspDiagnosticsLineNrError',
            [vim.diagnostic.severity.WARN] = 'LspDiagnosticsLineNrWarning',
          },
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', '<c-]>', function()
            require('snacks.picker').lsp_definitions {
              unique_lines = true,
              filter = {
                ---@param item snacks.picker.finder.Item
                ---@param filter snacks.picker.Filter
                filter = function(item, filter)
                  -- Only show results from node_modules if there are only
                  -- results from node_modules
                  -- Currently, only filters out node_modules AFTER a source file in the list :(

                  if not string.find(item.file, 'node_modules') then
                    filter.meta.has_source_file = true
                  else
                    return not filter.meta.has_source_file
                  end

                  return true
                end,
              },
            }
          end, opts)
          vim.keymap.set('n', 'grr', function()
            require('snacks.picker').lsp_references()
          end, opts)

          vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Highlight symbol references on hover
          if client:supports_method 'textDocument/documentHighlight' then
            local group = vim.api.nvim_create_augroup('LspDocumentHighlight', {
              clear = false,
            })
            vim.api.nvim_clear_autocmds { buffer = event.buf, group = group }
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = group,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if client:supports_method 'textDocument/foldingRange' then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
        end,
      })

      require 'j.plugins.lsp.typescript_ls'
      require 'j.plugins.lsp.css_ls'
      require 'j.plugins.lsp.docker_ls'
      require 'j.plugins.lsp.graphql_ls'
      require 'j.plugins.lsp.html_ls'
      require 'j.plugins.lsp.json_ls'
      require 'j.plugins.lsp.vue_ls'
      require 'j.plugins.lsp.yaml_ls'
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    config = function()
      require 'j.plugins.lsp.lua_ls'
      require('lazydev').setup {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      }
    end,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
    ---@type TailwindTools.Option
    opts = {},
  },
  {
    'zk-org/zk-nvim',
    ft = 'markdown',
    config = function()
      require('zk').setup {
        picker = 'snacks_picker',
        lsp = {
          config = {
            capabilities = require 'j.plugins.lsp.capabilities',
          },
        },
      }
    end,
    keys = {
      { '<leader>zn', [[:ZkNew {title=''}<left><left>]], mode = 'n' },
      { '<leader>zn', [[<cmd>ZkNewFromTitleSelection<cr>]], mode = 'x' },
      { '<leader>zl', [[<cmd>ZkNotes<cr>]] },
      { '<leader>zt', [[<cmd>ZkTags<cr>]] },
    },
  },
}
