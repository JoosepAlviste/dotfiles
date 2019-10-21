function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')

    " let s .= '%' . tabnr . 'T'
    let s .= tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
    " let s .= ' ' . tabnr

    let n = tabpagewinnr(tabnr,'$')

    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '

    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '+ ' | endif
  endfor

  let s .= '%#TabLineFill%T'

  return s
endfunction

set tabline=%!MyTabLine()
