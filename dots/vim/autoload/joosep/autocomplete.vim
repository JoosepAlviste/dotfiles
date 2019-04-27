" Handle pressing of the tab key. Will either confirm a PUM selection, jump
" forward in a snippet placeholder, or send a TAB character if nothing else
" should be done.
function! joosep#autocomplete#handle_tab() abort
    if pumvisible()
        return coc#_select_confirm() 
    elseif coc#expandableOrJumpable()
        return coc#rpc#request('doKeymap', ['snippets-expand-jump','']) 
    elseif <SID>check_back_space()
        return "\<tab>"
    else
        return coc#refresh()
    endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
