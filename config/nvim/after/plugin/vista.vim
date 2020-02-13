let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

let g:vista_echo_cursor_strategy = 'floating_win'

let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
      \ 'typescriptreact': 'coc',
      \ 'javascript': 'coc',
      \ 'markdown': 'toc',
      \ 'python': 'coc',
      \ }

let g:vista_keep_fzf_colors = 1
