if exists('loaded_fzf')
    " === FZF options ==="

    " Jump to existing window if possible
    let g:fzf_buffers_jump = 1

    " Customize colors to match the color scheme
    let g:fzf_colors = { 
                \ 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'], }


    " === FZF Commands ==="

    " Show file preview while grepping through files in fullscreen (Ag!). Or if ? is
    " pressed,  then show small preview on the right.
    command! -bang -nargs=* Ag
                \ call fzf#vim#ag(<q-args>,
                \                 <bang>0 ? fzf#vim#with_preview('up:60%')
                \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
                \                 <bang>0)
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)


    " === FZF Mappings ==="

    " Working directory files
    nnoremap <silent> <C-p> :FZF<cr>
    " Current file's directory files
    nnoremap <silent> <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
    nnoremap <silent> <leader>ft :Tags<cr>
    " Lines in all buffers
    nnoremap <silent> <leader>/ :Lines<cr>
    " All lines in all files in the project
    nnoremap <silent> <leader>ff :Rg!<cr>
    " Buffers
    nnoremap <silent> <leader>b :Buffer<cr>
    " Vim file editing history
    nnoremap <silent> <leader>fr :History<cr>
    nnoremap <silent> <leader>fh :Helptags<cr>
    " Commands history
    nnoremap <silent> <leader>f: :History:<cr>
    " Search history
    nnoremap <silent> <leader>f/ :History/<cr>
    " Git staged files
    nnoremap <silent> <leader>fs :GFiles?<cr>
    " Commit history
    nnoremap <silent> <leader>fc :Commits<cr>
    " All commands
    nnoremap <silent> <leader>fa :Commands<cr>
else
    echo 'FZF not installed. It should work after running :PlugInstall'
endif
