local util = require 'vim.lsp.util'
local nvim_lsp = require('nvim_lsp')
local split = vim.split
local api = vim.api
local validate = vim.validate
local nvim_command = vim.api.nvim_command

-- These functions are copied from Neovim source 
-- (https://github.com/neovim/neovim/blob/44fe8828f06a22bc9aa3617a6fd8aae447a838de/runtime/lua/vim/lsp/util.lua)

local function split_lines(value)
    return split(value, '\n', true)
end

local function show_line_diagnostics()
    local lines = {"Diagnostics:"}
    local highlights = {{0, "Bold"}}
    local line_diagnostics = vim.lsp.util.get_line_diagnostics()
    if vim.tbl_isempty(line_diagnostics) then return end

    for i, diagnostic in ipairs(line_diagnostics) do
        local prefix = string.format("%d. ", i)
        local hiname = vim.lsp.util.get_severity_highlight_name(diagnostic.severity)
        assert(hiname, 'unknown severity: ' .. tostring(diagnostic.severity))
        local message_lines = split_lines(diagnostic.message)
        table.insert(lines, prefix..message_lines[1])
        table.insert(highlights, {#prefix + 1, hiname})
        for j = 2, #message_lines do
            table.insert(lines, message_lines[j])
            table.insert(highlights, {0, hiname})
        end
    end

    -- Create the popup
    local popup_bufnr, winnr = vim.lsp.util.focusable_preview('diagnostic', function()
        local window_width = api.nvim_win_get_width(0)
        local preferred_size = math.floor(window_width * 0.8)
        local max_width = math.min(100, preferred_size)
        local min_width = math.min(50, window_width)
        return lines, 'plaintext', {
            width = math.max(math.min(preferred_size, max_width), min_width),
        }
    end)
    -- Make sure that the text wraps in the floating window
    api.nvim_win_set_option(winnr, 'wrap', true)
    for i, hi in ipairs(highlights) do
        local prefixlen, hiname = unpack(hi)
        -- Start highlight after the prefix
        api.nvim_buf_add_highlight(popup_bufnr, -1, hiname, i-1, prefixlen, -1)
    end
    return popup_bufnr, winnr
end

-- Copied from Neovim source: 
-- https://github.com/neovim/neovim/tree/master/src/runtime/lua/vim/lsp/callback.lua
-- Removed the lines where the virtual text is shown as well as where the signs 
-- are shown
local function customize_diagnostics()
    local method = 'textDocument/publishDiagnostics'
    local default_callback = vim.lsp.callbacks[method]
    vim.lsp.callbacks[method] = function(err, method, result, client_id)
        if not result then return end
        local uri = result.uri
        local bufnr = vim.uri_to_bufnr(uri)
        if not bufnr then
            err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
            return
        end

        -- Unloaded buffers should not handle diagnostics.
        --    When the buffer is loaded, we'll call on_attach, which sends textDocument/didOpen.
        --    This should trigger another publish of the diagnostics.
        --
        -- In particular, this stops a ton of spam when first starting a server for current
        -- unloaded buffers.
        if not api.nvim_buf_is_loaded(bufnr) then
            return
        end

        util.buf_clear_diagnostics(bufnr)

        -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#diagnostic
        -- The diagnostic's severity. Can be omitted. If omitted it is up to the
        -- client to interpret diagnostics as error, warning, info or hint.
        -- TODO: Replace this with server-specific heuristics to infer severity.
        for _, diagnostic in ipairs(result.diagnostics) do
            if diagnostic.severity == nil then
                diagnostic.severity = protocol.DiagnosticSeverity.Error
            end
        end

        util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
        util.buf_diagnostics_underline(bufnr, result.diagnostics)
        -- util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)
        -- util.buf_diagnostics_signs(bufnr, result.diagnostics)
        nvim_command("doautocmd User LspDiagnosticsChanged")
    end
end

-- Called when an LSP is attached to a buffer
local on_attach = function(client, bufnr)
    -- Show diagnostics details on cursor hold
    -- nvim_command('autocmd CursorHold <buffer> lua require"completion_utils".show_line_diagnostics()')

    local can = client.resolved_capabilities

    -- Highlight symbol on cursor hold
    if can.document_highlight then
        nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end

    -- Mappings.
    api.nvim_buf_set_keymap(bufnr, 'i', '<c-space>', 'completion#trigger_completion()', {
        noremap = true, silent = true, expr = true,
    })

    local opts = { noremap=true, silent=true }
    api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua require"completion_utils".show_line_diagnostics()<cr>', opts)
end

local function configure_lsp()
    customize_diagnostics()

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

    nvim_lsp.pyls_ms.setup {
        on_attach = on_attach;
        root_dir = nvim_lsp.util.root_pattern('requirements.txt', 'Pipfile', '.git');
        settings = {
            python = {
                envFile = './.env';
                -- autoComplete = {
                --     extraPaths = {'./subfolder'};
                -- };
            };
        };
    }

    nvim_lsp.jsonls.setup {
        on_attach = on_attach;
        settings = {
            json = {
                schemas = {
                    {
                        fileMatch = {'package.json'};
                        url = 'https://json.schemastore.org/package';
                    };
                    {
                        fileMatch = {'tsconfig.json'};
                        url = 'https://json.schemastore.org/tsconfig';
                    };
                    {
                        fileMatch = {'jsconfig.json'};
                        url = 'https://json.schemastore.org/jsconfig';
                    };
                    {
                        fileMatch = {'.eslintrc'};
                        url = 'https://json.schemastore.org/eslintrc';
                    };
                    {
                        fileMatch = {'.prettierrc', '.prettierrc.json'};
                        url = 'https://json.schemastore.org/prettierrc';
                    };
                };
            };
        };
    }

    nvim_lsp.yamlls.setup {
        on_attach = on_attach;
        settings = {
            yaml = {
                schemas = {
                    ['http://json.schemastore.org/composer'] = "composer.yaml";
                    ['http://json.schemastore.org/gitlab-ci'] = ".gitlab-ci.yml";
                    ['https://gist.githubusercontent.com/JoosepAlviste/5e806ca470e37eb442b839945d9ef359/raw/9b8f10cdaa5537822338f35a48902c5ef21a5068/schema-1.0.0.json'] = "tg-project.yaml";
                    ['https://raw.githubusercontent.com/docker/compose/master/compose/config/config_schema_v3.0.json'] = "docker-compose.yml";
                };
            };
        };
    }
end

return {
  show_line_diagnostics = show_line_diagnostics,
  configure_lsp = configure_lsp,
}
