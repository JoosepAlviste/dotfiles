return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        automatic_installation = true,
      }

      vim.fn.sign_define('DiagnosticSignError', { numhl = 'LspDiagnosticsLineNrError', text = '' })
      vim.fn.sign_define('DiagnosticSignWarn', { numhl = 'LspDiagnosticsLineNrWarning', text = '' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '' })

      vim.diagnostic.config {
        virtual_text = false,
      }

      ---If the LSP response includes any `node_modules`, then try to remove them and
      ---see if there are any options left. We probably want to navigate to the code
      ---in OUR codebase, not inside `node_modules`.
      ---
      ---This can happen if a type is used to explicitly type a variable:
      ---```ts
      ---const MyComponent: React.FC<Props> = () => <div />
      ---````
      ---
      ---Running "Go to definition" on `MyComponent` would give the `React.FC`
      ---definition in `node_modules/react` as the first result, but we don't want
      ---that.
      ---@param results lsp.LocationLink[]
      ---@return lsp.LocationLink[]
      local function filter_out_libraries_from_lsp_items(results)
        local without_node_modules = vim.tbl_filter(function(item)
          return item.targetUri and not string.match(item.targetUri, 'node_modules')
        end, results)

        if #without_node_modules > 0 then
          return without_node_modules
        end

        return results
      end

      ---@param results lsp.LocationLink[]
      ---@return lsp.LocationLink[]
      local function filter_out_same_location_from_lsp_items(results)
        return vim.tbl_filter(function(item)
          local from = item.originSelectionRange
          local to = item.targetSelectionRange

          return not (
            from
            and from.start.character == to.start.character
            and from.start.line == to.start.line
            and from['end'].character == to['end'].character
            and from['end'].line == to['end'].line
          )
        end, results)
      end

      ---This function is mostly copied from Telescope, I only added the
      ---`node_modules` filtering.
      local function list_or_jump(action, title, opts)
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values
        local make_entry = require 'telescope.make_entry'

        opts = opts or {}

        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, action, params, function(err, result, ctx)
          if err then
            vim.api.nvim_err_writeln('Error when executing ' .. action .. ' : ' .. err.message)
            return
          end
          local flattened_results = {}
          if result then
            -- textDocument/definition can return Location or Location[]
            if not vim.tbl_islist(result) then
              flattened_results = { result }
            end

            vim.list_extend(flattened_results, result)
          end

          -- This is the only added step to the Telescope function
          flattened_results =
            filter_out_same_location_from_lsp_items(filter_out_libraries_from_lsp_items(flattened_results))

          local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding

          if #flattened_results == 0 then
            return
          elseif #flattened_results == 1 and opts.jump_type ~= 'never' then
            local uri = params.textDocument.uri
            if uri ~= flattened_results[1].uri and uri ~= flattened_results[1].targetUri then
              if opts.jump_type == 'tab' then
                vim.cmd.tabedit()
              elseif opts.jump_type == 'split' then
                vim.cmd.new()
              elseif opts.jump_type == 'vsplit' then
                vim.cmd.vnew()
              elseif opts.jump_type == 'tab drop' then
                local file_uri = flattened_results[1].uri
                if file_uri == nil then
                  file_uri = flattened_results[1].targetUri
                end
                local file_path = vim.uri_to_fname(file_uri)
                vim.cmd('tab drop ' .. file_path)
              end
            end

            vim.lsp.util.jump_to_location(flattened_results[1], offset_encoding, opts.reuse_win)
          else
            local locations = vim.lsp.util.locations_to_items(flattened_results, offset_encoding)
            pickers
              .new(opts, {
                prompt_title = title,
                finder = finders.new_table {
                  results = locations,
                  entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
                },
                previewer = conf.qflist_previewer(opts),
                sorter = conf.generic_sorter(opts),
                push_cursor_on_edit = true,
                push_tagstack_on_edit = true,
              })
              :find()
          end
        end)
      end

      local function definitions(opts)
        return list_or_jump('textDocument/definition', 'LSP Definitions', opts)
      end

      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']g', vim.diagnostic.goto_next)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', '<c-]>', definitions, opts)
          vim.keymap.set('n', 'gr', function()
            require('telescope.builtin').lsp_references()
          end, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

          vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Highlight symbol references on hover
          local document_highlight_disabled_ls = { 'zk', 'jsonls', 'yamlls', 'copilot' }
          if
            client.supports_method 'documentHighlightProvider'
            and not vim.tbl_contains(document_highlight_disabled_ls, client.name)
          then
            vim.api.nvim_create_augroup('LspDocumentHighlight', {
              clear = false,
            })
            vim.api.nvim_clear_autocmds {
              buffer = event.buf,
              group = 'LspDocumentHighlight',
            }
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = 'LspDocumentHighlight',
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              group = 'LspDocumentHighlight',
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Disable semantic token highlighting, it is worse in some cases than
          -- treesitter (e.g., SCREAMING_SNAKE_CASE constants or builtin variables)
          -- I think that "modifiers" is what we need in order to be able to have a bit
          -- nicer highlighting with LSP?
          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

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
    'folke/neodev.nvim',
    ft = 'lua',
    config = function()
      require('neodev').setup()
      require 'j.plugins.lsp.lua_ls'
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript' },
    config = function()
      require 'j.plugins.lsp.typescript_ls'
    end,
  },
  {
    'mickael-menu/zk-nvim',
    ft = 'markdown',
    config = function()
      require('zk').setup {
        picker = 'telescope',
        lsp = {
          config = {
            capabilities = require 'j.plugins.lsp.capabilities',
          },
        },
      }

      require('telescope').load_extension 'zk'
    end,
    keys = {
      { '<leader>zn', [[:ZkNew {title=''}<left><left>]], mode = 'n' },
      { '<leader>zn', [[<cmd>ZkNewFromTitleSelection<cr>]], mode = 'x' },
      { '<leader>zl', [[<cmd>ZkNotes<cr>]] },
      { '<leader>zt', [[<cmd>ZkTags<cr>]] },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        accept = false,
        auto_trigger = true,
      },
    },
  },
}
