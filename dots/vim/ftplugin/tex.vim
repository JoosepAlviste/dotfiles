if has('syntax')
    setlocal spell
endif

setlocal textwidth=80

" Autoformatting
setlocal formatoptions-=c

" For some reason the default keybindings don't work for vimtex, so we need to 
" re-declare the useful ones
nmap <localleader>ll :call vimtex#compiler#compile()<cr>
