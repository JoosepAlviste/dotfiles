let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ "'": {'closer': "'"},
      \ '"': {'closer': '"'},
      \ '`': {'closer': '`', 'not_at': ['^\s*']},
      \ '<*>': {'closer': '</*>', 'not_like': '/$'},
      \ '/\*\*': {'closer': '\*/'},
      \ '{%': {'closer': '%}'},
      \ }

let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

imap jk <Plug>(PearTreeFinishExpansion)
imap <esc> <Plug>(PearTreeFinishExpansion)
imap <space> <Plug>(PearTreeSpace)
