"
" Options
"

let g:UltiSnipsSnippetsDir = $HOME . '/.vim/ultisnips'

let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

call deoplete#custom#source('ultisnips', 'rank', 1000)


"
" Autocmds
"

if has('autocmd')
  augroup JoosepAutocomplete
    autocmd!
    autocmd! User UltiSnipsEnterFirstSnippet
    autocmd User UltiSnipsEnterFirstSnippet call joosep#autocomplete#setup_mappings()
    autocmd! User UltiSnipsExitLastSnippet
    autocmd User UltiSnipsExitLastSnippet call joosep#autocomplete#teardown_mappings()
  augroup END
endif

if has('nvim')
  inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
  inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif


"
" Startup
"

call joosep#autocomplete#deoplete_init()
