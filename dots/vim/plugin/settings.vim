"
" Vim settings
"

set nocompatible    " Do not think about vi, warding off unexpected things

set expandtab       " Always use spaces instead of tabs

set backspace=indent,eol,start  " Make backspace work normally
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap lines

set mouse=a     " Enable mouse usage
set mousehide   " Hide cursor when starting to type 

set hidden      " Buffer switching without saving


"
" Graphical
"

" Show relative line numbers and current line's absolute number
set number
if exists('+relativenumber')
    set relativenumber
endif

set signcolumn=yes                    " Always show sign column or it might flicker

set list                              " Show whitespace
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:\|_
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:⋅                " Dot Operator (U+22C5)
if has('linebreak')
  let &showbreak='↳ '                 " DOWNWARDS ARROW WITH TIP RIGHTWARDS (U+21B3, UTF-8: E2 86 B3)
endif

" Enable true-color
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

