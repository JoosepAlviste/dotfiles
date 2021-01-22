if !has_key(plugs, 'completion-nvim')
  finish
endif

"
" Settings
"

let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_sorting = 'none'
let g:completion_matching_smart_case = 1
let g:completion_confirm_key = "\<C-y>"
let g:completion_timer_cycle = 400
let g:completion_auto_change_source = 1
let g:completion_trigger_keyword_length = 0

let g:completion_chain_complete_list = {
      \ 'markdown': [
      \   {'mode': 'file', 'triggered_only': ['/']},
      \   {'complete_items': ['snippet']},
      \   {'mode': 'incl'},
      \ ],
      \ 'default': [
      \   {'complete_items': ['path'], 'triggered_only': ['/']},
      \   {'complete_items': ['lsp', 'snippet']},
      \ ],
      \ }

"
" Mappings
"

imap <silent> <c-space> <Plug>(completion_trigger)

" If enter is pressed, always create a new line (even when pum open)
inoremap <expr> <cr> <sid>NewLine()

function! s:NewLine()
  let res = ""
  if pumvisible()
    let res .= "\<c-e>"
  endif

  return res . pear_tree#insert_mode#PrepareExpansion()
endfunction


"
" Autocmds
"

augroup CompletionNvimAutocmds
  autocmd!
  " Always attach `completion-nvim` to the buffer
  autocmd BufEnter * lua require'completion'.on_attach()
augroup END
