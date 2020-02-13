if has('autocmd')
  augroup JoosepAutocmds
    autocmd!

    " Disable cursorline in diff mode
    autocmd OptionSet diff let &cursorline=!v:option_new

    " Hide and show cursorline in inactive buffers
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline

    " Automatically update changed file in Vim
    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! if mode() != 'c' && expand('%') !=# '[Command Line]' | checktime | endif
    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
          \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

    autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')

    " Fix styled-components highlighting issue, not sure why this does not
    " work in the ftplugin/javascript.vim file
    autocmd BufReadPost *.tsx,*.ts,*.jsx,*.js :syntax sync fromstart

    " Open some files with `xdg-open` or `open` automatically
    autocmd FileType pdf silent call joosep#specialfiles#openspecial()
    autocmd FileType video silent call joosep#specialfiles#openspecial()
    autocmd FileType image silent call joosep#specialfiles#openspecial()

    " Save buffer when focus lost (not sure if this works in terminal Vim)
    autocmd FocusLost * silent! wa

    " Automatically open quickfix window
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
  augroup END
endif
