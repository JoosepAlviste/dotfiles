"
" Vim settings
"

set nocompatible  " Do not think about vi, warding off unexpected things 


"
" Controls
"

set scrolloff=3  " Lines to scroll when cursor leaves screen

" Integration with the system clipboard
if has('clipboard')
  if has('unnamedplus')
    " When possible, use the + register for copy/paste
    set clipboard=unnamed,unnamedplus
  else
    " On Mac and Windows, use the * register
    set clipboard=unnamed
  endif
endif


"
" Vim UI
"

if (has('termguicolors'))
    set termguicolors  " Enable true colors
endif
