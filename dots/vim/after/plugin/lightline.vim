"
" Options
"

let g:lightline = {
            \ 'colorscheme': 'myoceanicnext',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'percent' ],
            \              [ 'testingstatus', 'zoom', 'gutentags', 'cocstatus', 'filetype' ] ],
            \ },
            \ 'component_function': {
            \   'readonly': 'LightlineReadonly',
            \   'fugitive': 'LightlineFugitive',
            \   'filename': 'LightlineFilename',
            \   'filetype': 'MyFiletype',
            \   'cocstatus': 'coc#status',
            \   'gutentags': 'gutentags#statusline',
            \   'zoom': 'zoom#statusline',
            \   'testingstatus': 'TestingStatus',
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

function! TestingStatus() abort
  if g:TESTING_STATUS == 'passing'
    return "\ue342"
  elseif g:TESTING_STATUS == 'running'
    return "\uf499"
  elseif g:TESTING_STATUS == 'failing'
    return "\uf528"
  endif
endfunction
