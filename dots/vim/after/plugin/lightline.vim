"
" Options
"

let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'percent' ],
            \              [ 'filetype' ] ],
            \ },
            \ 'component_function': {
            \   'readonly': 'LightlineReadonly',
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'MyFiletype',
            \ },
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '|', 'right': '|' }
            \ }


"
" Helper functions
"

function! LightlineFilename()
    let l:folder=expand('%:p:h:t')
    let l:filename=expand('%:p:t')
    return l:folder . '/' . l:filename
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ''.branch : ''
    endif
    return ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70
                \ ? (strlen(&filetype) 
                \       ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype
                \       : 'no ft')
                \ : ''
endfunction
