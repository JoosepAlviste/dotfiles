"
" Settings
"

" Appropriate tab size
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
setlocal define=\\(class\\s\\\|const\\s\\\|function\\s\\)

if has_key(plugs, 'nvim-treesitter')
  setlocal foldmethod=expr
  setlocal foldexpr=nvim_treesitter#foldexpr()
else
  setlocal foldmethod=syntax
endif


" Plugin settings

let b:pear_tree_pairs = extend(deepcopy(g:pear_tree_pairs), {
      \ '/\*\*': {'closer': '\*/'},
      \ '<*>': {'closer': '</*>', 'not_like': '/$'},
      \ }, 'keep')


"
" Commands
"

command! -bang AddReturn call joosep#javascript#add_return()


"
" Mappings
"

" Go to definition
if has_key(plugs, 'coc.nvim')
  nnoremap <silent> <c-]> :call CocAction('jumpDefinition')<cr>
endif
