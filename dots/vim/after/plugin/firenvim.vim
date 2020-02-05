function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, "name") &&
      \ l:ui.client.name is# "Firenvim"
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set laststatus=0
  endif
endfunction

if exists('g:started_by_firenvim')
  augroup FirenvimCommands
    " Set some settings when firenvim is loaded
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

    " Set filetypes when editing fields with firenvim
    autocmd BufEnter github.com_*.txt set filetype=markdown
    autocmd BufEnter gitlab.com_*.txt set filetype=markdown

    " Automatically write buffer to DOM in firenvim
    let g:dont_write = v:false
    function! My_Write(timer) abort
      let g:dont_write = v:false
      write
    endfunction
    function! Delay_My_Write() abort
      if g:dont_write
        return
      end
      let g:dont_write = v:true
      call timer_start(10000, 'My_Write')
    endfunction
    autocmd TextChanged * ++nested call Delay_My_Write()
    autocmd TextChangedI * ++nested call Delay_My_Write()
  augroup END
endif
