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

imap jk <Plug>(PearTreeFinishExpansion)
imap <esc> <Plug>(PearTreeFinishExpansion)
imap <space> <Plug>(PearTreeSpace)
