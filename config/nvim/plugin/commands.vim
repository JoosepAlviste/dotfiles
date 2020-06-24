" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction

command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

" Change the project in a convenient way
command! -bang Project call fzf#run(fzf#wrap(
			\ 'project',
			\ { 'source':  'ls -d ~/Devel/Work/* ~/Devel/Projects/*',
			\   'sink':    'cd',
			\   'options': '--prompt "Project> " -d / --with-nth=-1 --preview="bat --style=plain --color=always {..}/README{.md,.org,.txt,} 2>/dev/null"' },
			\ <bang>0))

command! -nargs=1 NewFile call joosep#filesystem#create_file_or_folder(<f-args>)

command! -nargs=+ Move call joosep#filesystem#move(<f-args>)
