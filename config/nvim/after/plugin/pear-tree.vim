"
" Settings
"

let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '`': {'closer': '`', 'not_at': ['^\s*']},
      \ }

let g:pear_tree_repeatable_expand = 0

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1


"
" Mappings
"

" Disable automatic mapping of keys so that it's easier to remap the keys
let g:pear_tree_map_special_keys = 0

imap jk <Plug>(PearTreeFinishExpansion)
imap <esc> <Plug>(PearTreeFinishExpansion)
imap <bs> <Plug>(PearTreeBackspace)
imap <space> <Plug>(PearTreeSpace)
imap <cr> <Plug>(PearTreeExpand)
