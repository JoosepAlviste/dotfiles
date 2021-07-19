require'gitsigns'.setup({
  signs = {
    add          = {hl = 'GitsignsAdd'   , text = '│', numhl='GitSignsAddNr'},
    change       = {hl = 'GitsignsChange', text = '│', numhl='GitSignsChangeNr'},
    delete       = {hl = 'GitsignsDelete', text = '_', numhl='GitSignsDeleteNr'},
    topdelete    = {hl = 'GitsignsDelete', text = '‾', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'GitsignsChange', text = '│', numhl='GitSignsChangeNr'},
  },
  keymaps = {
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
  },
})
