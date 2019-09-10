"
" Settings
"

setlocal signcolumn=no


"
" Mappings
"

" Open commit message vertically so that status and commit splits have more
" vertical room
nnoremap <buffer> <silent> ca        :<C-U>vertical Gcommit --amend<CR>
nnoremap <buffer> <silent> <expr> cc <SID>Commit()
nnoremap <buffer> <silent> cw        :<C-U>vertical Gcommit --amend --only<CR>


"
" Helper functions
"

function! s:Commit()
    " Pre-populate the commit message with the issue number if it is specified
    " in the branch. Leaves the user in insert mode

    " Capture group with 2-6 letters and some numbers. For example, matches
    " 'ABC-123' in 'ABC-123-make-it-better'
    let regex = '^\(\w\{2,6}-\d\+\).*$'
    let branch = fugitive#head()
    let issue = ''

    if branch =~# regex
        let issue = toupper(matchlist(branch, regex)[1]) . ' '
    endif

    return ":\<C-u>vertical Gcommit\<cr>O" . issue
endfunction
