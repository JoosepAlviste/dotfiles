local treesitter_configs = require('nvim-treesitter.configs')

local function customize_highlights()
    -- Import this file before customizing the highlights since that customizes 
    -- the `hl_map` as well and would override our changes
    require('nvim-treesitter.highlight')

    -- Customize the highlights
    local hlmap = vim.treesitter.TSHighlighter.hl_map
    hlmap['variable'] = 'Normal'
    hlmap['tag'] = 'Type'
    hlmap["constructor"] = "Type"
    hlmap["constant.builtin"] = "Constant"
    hlmap["punctuation.special"] = "Special"
    hlmap["variable.builtin"] = "Constant"
end

local function configure_treesitter()
    treesitter_configs.setup {
        highlight = {
            enable = false,
            disable = {},
        },
        incremental_selection = {
            enable = true,
            keymaps = {                       -- mappings for incremental selection (visual mappings)
                init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
                node_incremental = "grn",       -- increment to the upper named parent
                scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
                node_decremental = "grm",      -- decrement to the previous node
            },
        },
        ensure_installed = {'typescript', 'javascript', 'tsx', 'python'},
    }

    customize_highlights()
end

return {
    configure_treesitter = configure_treesitter,
}
