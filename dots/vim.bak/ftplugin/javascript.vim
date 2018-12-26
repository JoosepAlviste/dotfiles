" Appropriate tab size
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Set node env to develop, for eslint
let $NODE_ENV="development"

set foldmethod=syntax

" Override the inline variable function so that it fits better for javascript
function! InlineVariable()
    normal ^w*''
    normal 2w
    normal "zDdd''
    normal cwz
    " Replace the semicolon which might be present from the line above
    execute "s/\\(.\\);\\(.\\)/\\1\\2/g"
endfunction

if !empty(glob('.flowconfig'))
    " Minimal LSP configuration for Flow
    if executable('flow-language-server')
        call LanguageClient_registerServerCommands({'javascript.jsx': ['flow-language-server', '--stdio']})
    else
        echo "flow-language-server not installed!\n"
        :cq
    endif
else
    " Minimal LSP configuration for JavaScript
    if executable('javascript-typescript-stdio')
        call LanguageClient_registerServerCommands({'javascript.jsx': ['javascript-typescript-stdio']})
    else
        echo "javascript-typescript-stdio not installed!\n"
        :cq
    endif
endif
