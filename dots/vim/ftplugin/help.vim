if has('syntax')
    setlocal spell
endif

setlocal signcolumn=no

setlocal textwidth=80

" Autoformatting
" a - audo format paragraph
" w - trailing whitespace indicates a paragraph
" 2 - use the second line's indent value when indenting paragraphs (allows 
" indented first line)
" t - auto-wrap text using textwidth
" q - allow formatting of comments
setlocal formatoptions=aw2tq
