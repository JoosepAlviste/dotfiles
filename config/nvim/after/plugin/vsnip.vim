"
" Settings
"

let g:vsnip_snippet_dir = '~/.config/nvim/vsnip'

let g:vsnip_filetypes = {}
let g:vsnip_filetypes.typescript = ['javascript']
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']


"
" Mappings
"

" Expand or jump
imap <expr> <tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <tab> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'

" Jump backward
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
