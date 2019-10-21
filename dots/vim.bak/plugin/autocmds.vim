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

        " Dim inactive windows
        " autocmd FocusLost,WinLeave * call joosep#autocmds#blur_window()
        " autocmd BufEnter,FocusGained,VimEnter,WinEnter * call joosep#autocmds#focus_window()

        autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
        " TODO: Delete this if it is not useful?
        " autocmd BufWinEnter * call joosep#autocmds#prevent_buffers_in_nerd_tree()
    augroup END
endif