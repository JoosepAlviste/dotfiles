function! joosep#git#issue()
    " Capture group with 2-6 letters and some numbers. For example, matches
    " 'ABC-123' in 'ABC-123-make-it-better'
    let regex = '^\(feature/\)\?\(fix/\)\?\(\w\{2,6}-\d\+\).*$'
    let branch = fugitive#head()
    let issue = ''

    if branch =~# regex
        let issue = toupper(matchlist(branch, regex)[3])
    endif

    return issue
endfunction

function! joosep#git#insert_issue_prefix()
  " Insert the issue prefix to a Git commit message. Make sure that we only 
  " insert it once since sometimes the filetype autocmd gets called multiple 
  " times.
  let issue = joosep#git#issue()

  let b:inserted_prefix = get(b:, 'inserted_prefix', 0)

  " We only want to insert the prefix if the line is empty (not --amend)
  let is_empty_line = strlen(getline(1, "$")[0]) == 0

  if b:inserted_prefix == 0 && is_empty_line
    call feedkeys('O')
    if strlen(issue) > 0
      call feedkeys(issue . ' ')
    endif

    let b:inserted_prefix = 1
  endif
endfunction
