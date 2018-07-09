set nospell

" Appropriate tab size
set tabstop=2 
set shiftwidth=2 
set softtabstop=2

" Set node env to develop, for eslint
let $NODE_ENV="development"

set foldmethod=syntax
        
" Minimal LSP configuration for JavaScript
if executable('javascript-typescript-stdio')
    call LanguageClient_registerServerCommands({'javascript.jsx': ['javascript-typescript-stdio']})
else
    echo "javascript-typescript-stdio not installed!\n"
    :cq
endif
