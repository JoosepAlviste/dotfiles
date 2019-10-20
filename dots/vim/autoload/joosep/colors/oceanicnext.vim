" Default colors
let s:base00=['#1b2b34', '235']
let s:base01=['#343d46', '237']
let s:base02=['#4f5b66', '240']
let s:base03=['#65737e', '243']
let s:base04=['#a7adba', '145']
let s:base05=['#c0c5ce', '251']
let s:base06=['#cdd3de', '252']
let s:base07=['#d8dee9', '253']
let s:base08=['#ec5f67', '203'] " red
let s:base09=['#f99157', '209'] " orange
let s:base0A=['#fac863', '221'] " yellow
let s:base0B=['#99c794', '114'] " green
let s:base0C=['#62b3b2', '73'] " cyan
let s:base0D=['#6699cc', '68'] " blue
let s:base0E=['#c594c5', '176'] " magenta
let s:base0F=['#ab7967', '137'] " brown
let s:base10=['#ffffff', '15'] " white
let s:none=['NONE', 'NONE']

" Custom colors
let s:bg=["#16242c", "235"]
let s:highlight = ['#1F3446', '235']
let s:search = ['#0F4767', '235']
let s:slightly_brighterer = ["#233843", "234"]
let s:error_red = ["#E83B45", "203"]
let s:diff_green = ["#637E6B", "114"]
let s:diff_red = ["#7F4B54", "203"]

let s:statusline = ["#131f26", "235"]

let s:colors = {
            \ "base00": s:base00,
            \ "base01": s:base01,
            \ "base02": s:base02,
            \ "base03": s:base03,
            \ "base04": s:base04,
            \ "base05": s:base05,
            \ "base06": s:base06,
            \ "base07": s:base07,
            \ "base08": s:base08,
            \ "base09": s:base09,
            \ "base0A": s:base0A,
            \ "base0B": s:base0B,
            \ "base0C": s:base0C,
            \ "base0D": s:base0D,
            \ "base0E": s:base0E,
            \ "base0F": s:base0F,
            \ "base10": s:base10,
            \ "none": s:none,
            \ "bg": s:bg,
            \ "highlight":  s:highlight,
            \ "search":  s:search,
            \ "slightly_brighterer":  s:slightly_brighterer,
            \ "error_red":  s:error_red,
            \ "diff_green":  s:diff_green,
            \ "diff_red":  s:diff_red,
            \ "statusline":  s:statusline,
            \ }


function! g:joosep#colors#oceanicnext#GetColors()
    return s:colors
endfunction
