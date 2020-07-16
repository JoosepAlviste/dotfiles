local treesitter_configs = require('nvim-treesitter.configs')

local function configure_treesitter()
    treesitter_configs.setup {
        highlight = {
            enable = true,
            custom_captures = {
                ['variable'] = 'Normal',
                ['tag'] = 'Type',
                ['constructor'] = 'Type',
                ['constant.builtin'] = 'Constant',
                ['puctuation.special'] = 'Special',
                ['variable.builtin'] = 'Constant',
            }
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
        ensure_installed = {
            'typescript', 'javascript', 'tsx', 'python', 'json',
        },
    }
end

return {
    configure_treesitter = configure_treesitter,
}
