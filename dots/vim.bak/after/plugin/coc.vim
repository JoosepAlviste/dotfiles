"
" Mappings
"

inoremap <expr> <tab> joosep#autocomplete#handle_tab()
inoremap <expr> <S-tab> "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current 
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

" Use `[g` and `]g` for navigating diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to *
nnoremap <silent> gd :call CocAction('jumpDefinition')<cr>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show documentation in preview window
nnoremap <silent> K :call <SID>ShowDocumentation()<CR>

" Format selected region
vmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)

" CodeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>ca  <Plug>(coc-codeaction-selected)
" nmap <leader>ca  <Plug>(coc-codeaction-selected)

" CodeAction of current line
nnoremap <leader>ca :call CocAction('codeAction')<cr>
" Fix autofix problem of current line
nmap <leader>cf <Plug>(coc-fix-current)

" Run jest for current test
nnoremap <leader>ct :call CocAction('runCommand', 'jest.singleTest')<CR>

" Rename the word under the cursor
nnoremap <leader>rn :call CocAction('rename')<cr>

" Show all diagnostics
nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ce :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>cc :<C-u>CocList commands<cr>

" Find symbol of current document
nnoremap <silent> <leader>fo :<C-u>CocList outline<cr>
" Find workspace symbols
nnoremap <silent> <leader>fs :<C-u>CocList -I symbols<cr>

" Do default action for next item.
nnoremap <silent> <leader>cj :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck :<C-u>CocPrev<CR>


"
" Autocommands
"

augroup myCocAuGroup
  autocmd!
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent! call CocActionAsync('highlight')
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Disable colorcolumn in floating windows
  autocmd User CocOpenFloat setlocal colorcolumn=
augroup end


"
" Commands
"

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Typescript
command! -nargs=0 TSLint :call CocAction('runCommand', 'tslint.lintProject')

" Jest
" Run jest for current project
command! -nargs=0 Jest :call CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call CocAction('runCommand', 'jest.fileTest', ['%'])
" Init jest in cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')


"
" Helper functions
"

function! s:ShowDocumentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


"
" Extensions
"

" Coc will automatically install these extensions. Specific extensions can
" still be installed using :CocInstall
let g:coc_global_extensions = [
            \ "coc-css",
            \ "coc-emmet",
            \ "coc-eslint",
            \ "coc-git",
            \ "coc-jest",
            \ "coc-python",
            \ "coc-snippets",
            \ "coc-tslint-plugin",
            \ "coc-tsserver",
            \ "coc-vimtex",
            \ "coc-prettier",
            \ "coc-yaml",
            \ "coc-stylelint",
            \ ]


"
" coc-git
"

nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <leader>hp <Plug>(coc-git-chunkinfo)
nnoremap <leader>hs :CocCommand git.chunkStage<cr>
nnoremap <leader>hu :CocCommand git.chunkUndo<cr>


"
" coc-snippet
"

let g:coc_snippet_next = '<tab>'
