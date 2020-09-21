if has('autocmd')
  augroup JoosepAutocmds
    autocmd!

    " Disable cursorline in diff mode
    autocmd OptionSet diff let &cursorline=!v:option_new

    " Hide cursorline in insert mode
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline

    " Automatically update changed file in Vim
    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! if mode() != 'c' | checktime | endif
    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
          \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

    " Open some files with `xdg-open` or `open` automatically
    autocmd FileType pdf silent call joosep#specialfiles#openspecial()
    autocmd FileType video silent call joosep#specialfiles#openspecial()
    autocmd FileType image silent call joosep#specialfiles#openspecial()

    " Save buffer when focus lost
    autocmd FocusLost * silent! wa

    " Automatically open quickfix window
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow

    " Automatically close Vim if the quickfix window is the only one open
    autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif

    " Automatically activate Limelight
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

    if exists('##TextYankPost')
      " The TextYankPost autocmd is available from Neovim's `master` branch
      " Highlight yanked text temporarily
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({ higroup = 'Substitute', timeout = 200 })
    endif
  augroup END
endif
