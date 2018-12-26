"
" Options
"

let g:LanguageClient_serverCommands = {}

" Typescript & JavaScript
if executable('javascript-typescript-stdio')
  let s:js=[exepath('javascript-typescript-stdio')]
  let g:LanguageClient_serverCommands['typescript']=s:js
endif
if exists('s:js')
  let g:LanguageClient_serverCommands['javascript']=s:js
  let g:LanguageClient_serverCommands['javascript.jest']=s:js
  let g:LanguageClient_serverCommands['javascript.jest.jsx']=s:js
  let g:LanguageClient_serverCommands['javascript.jsx']=s:js
endif


"
" Mappings
"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

