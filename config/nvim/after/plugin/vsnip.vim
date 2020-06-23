"
" Options
"

let g:vsnip_snippet_dir = stdpath('config') .. '/vsnip'


"
" Mappings
"

" Expand snippets with `<c-y>` or `<tab>`
imap <expr> <c-y>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<c-y>'
imap <expr> <tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <tab>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
imap <expr> <s-tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<s-tab>'
smap <expr> <s-tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<s-tab>'
