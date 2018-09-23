function! InlineVariable()
    normal ^*''
    normal 2w
    normal "zDdd''
    normal cwz
endfunction

nnoremap <silent> <leader>rt :call InlineVariable()<cr>
