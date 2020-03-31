"
" Settings
"

let g:infowindow_timeout = 5000


"
" Customize the data shown in the window
"

command! InfoWindowCustomToggle call infowindow#toggle(
      \ {},
      \ { default_lines -> [
      \ ['name', expand('%')],
      \ ['type', strlen(&filetype) > 0 ? &filetype : 'unknown'],
      \ ['format',&fileformat ],
      \ ['lines', line('$') ],
      \ ['branch', fugitive#head()],
      \ ] },
      \ )


"
" Mapping
"

nnoremap <silent> <c-g> :InfoWindowCustomToggle<cr>
