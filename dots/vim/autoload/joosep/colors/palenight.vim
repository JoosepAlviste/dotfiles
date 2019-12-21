"
" Export colors used in Material Theme's Palenight variant so that customizing 
" the colorscheme is easier. Also export some custom colors.
"

" Default colors from Material theme
let s:bg = '#292d3e'
let s:fg = '#a6accd'
let s:invisibles = '#4e5579'
let s:comments = '#676e95'
let s:selection = '#343A51'
let s:guides = '#4e5579'
let s:line_numbers = '#3a3f58'
let s:caret = '#ffcc00'
let s:line_highlight = '#000000'
let s:white = '#ffffff'
let s:black = '#000000'
let s:red = '#ff5370'
let s:orange = '#f78c6c'
let s:yellow = '#ffcb6b'
let s:green = '#c3e88d'
let s:cyan = '#89ddff'
let s:blue = '#82aaff'
let s:paleblue = '#b2ccd6'
let s:purple = '#c792ea'
let s:brown = '#c17e70'
let s:pink = '#f07178'
let s:violet = '#bb80b3'

" Custom colors
let s:background = '#252837'  " A bit darker background color
let s:statusline = '#1d1f2b'  " Statusline should be dark
let s:cursorline = '#212331'  " Cursorline should be a bit darker than bg
let s:darker_fg = '#7982B4'  " Some text should be a bit darker than normal fg

let s:colors = {
      \ "bg": s:bg,
      \ "fg": s:fg,
      \ "invisibles": s:invisibles,
      \ "comments": s:comments,
      \ "selection": s:selection,
      \ "guides": s:guides,
      \ "line_numbers": s:line_numbers,
      \ "caret": s:caret,
      \ "line_highlight": s:line_highlight,
      \ "white": s:white,
      \ "black": s:black,
      \ "red": s:red,
      \ "orange": s:orange,
      \ "yellow": s:yellow,
      \ "green": s:green,
      \ "cyan": s:cyan,
      \ "blue": s:blue,
      \ "paleblue": s:paleblue,
      \ "purple": s:purple,
      \ "brown": s:brown,
      \ "pink": s:pink,
      \ "violet": s:violet,
      \ "background": s:background,
      \ "statusline": s:statusline,
      \ "cursorline": s:cursorline,
      \ "darker_fg": s:darker_fg,
      \ }


function! g:joosep#colors#palenight#GetColors()
    return s:colors
endfunction
