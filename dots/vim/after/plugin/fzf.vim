if exists('loaded_fzf')

    " FZF Options

    " Jump to existing window if possible
    let g:fzf_buffers_jump = 1

    " Customize colors to match the color scheme
    let g:fzf_colors = {
                \ 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Function'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Keyword'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Keyword'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment'], }


    " FZF Commands

    " Show file preview while grepping through files in fullscreen. Or if ? is
    " pressed, then show small preview on the right.
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
                \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
                \   <bang>0)

    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


    " FZF Mappings

    " Working directory files
    nnoremap <silent> <C-p> :FZF<cr>
    " Current file's directory files
    nnoremap <silent> <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
    nnoremap <silent> <leader>ft :Tags!<cr>
    " Lines in all buffers
    nnoremap <silent> <leader>/ :Lines!<cr>
    " All lines in all files in the project
    nnoremap <silent> <leader>ff :Rg!<cr>
    " Buffers
    nnoremap <silent> <leader>b :Buffer<cr>
    nnoremap <silent> <C-b> :Buffer<cr>
    " Vim file editing history
    nnoremap <silent> <leader>fr :History<cr>
    nnoremap <silent> <leader>fh :Helptags<cr>
    " Commands history
    nnoremap <silent> <leader>f: :History:<cr>
    " Search history
    nnoremap <silent> <leader>f/ :History/<cr>
    " Commit history
    nnoremap <silent> <leader>fc :Commits!<cr>
    " All commands
    nnoremap <silent> <leader>fa :Commands<cr>
    nnoremap <silent> <leader>fx :GFiles!?<cr>

    let g:fzf_history_dir = '~/.local/share/fzf-history'
    let $FZF_DEFAULT_OPTS='--layout=reverse'

    if has('nvim')
        let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    endif

    function! FloatingFZF()
        let buf = nvim_create_buf(v:false, v:true)

        let height = &lines / 2
        let width = float2nr(&columns - (&columns * 4 / 10))
        let col = float2nr((&columns - width) / 2)

        let opts = {
                    \ 'relative': 'editor',
                    \ 'row': &lines / 4,
                    \ 'col': col,
                    \ 'width': width,
                    \ 'height': height
                    \ }

        call nvim_open_win(buf, v:true, opts)
    endfunction

    nnoremap <leader>fg :set operatorfunc=<SID>GrepOperator<cr>g@
    vnoremap <leader>fg :<c-u>call <SID>GrepOperator(visualmode())<cr>

    function! s:GrepOperator(type)
        " Save previously copied text
        let saved_unnamed_register = @@

        " Copy the motion-ed or visually selected text
        if a:type ==# 'v'
            execute "normal! `<v`>y"
        elseif a:type ==# 'char'
            execute "normal! `[v`]y"
        else
            return
        endif

        " Open Ripgrep search with the term
        silent execute "Rg! " . @@

        " Restore previously copied text
        let @@ = saved_unnamed_register
    endfunction

    function! s:FzfStatusline()
      setlocal statusline=%#StatuslineAccent#\ »\ %*fz%#StatuslineAccent#\ «%*%=%{getcwd()}\ 
    endfunction

    autocmd! User FzfStatusLine call <SID>FzfStatusline()
else
    echo 'FZF not installed. It should work after running :PlugInstall'
endif
