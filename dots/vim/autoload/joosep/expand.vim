function! joosep#expand#insertComma()
    " When creating a new line with o, make sure there is a trailing comma on
    " the current line. Mainly meant to be used in JSON files.

    " Add the trailing comma if it doesn't exist
    substitute/\(.*[^{[][^,{[]\)$/\1,/g
    " And add the new line
    call feedkeys("A\<cr>")
endfunction
