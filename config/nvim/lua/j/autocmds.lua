require('j.utils').create_augroups({
  setup = {
    -- Automatically compile packer when saving the plugins' file
    {'BufWritePost', 'plugins.lua', 'PackerCompile'},
    -- Highlight text after yanking
    {'TextYankPost', '*', [[lua require('vim.highlight').on_yank({ higroup = 'Substitute', timeout = 200 })]]},
    -- Hide cursorline in insert mode
    {'InsertLeave,WinEnter', '*', 'set cursorline'},
    {'InsertEnter,WinLeave', '*', 'set nocursorline'},
    -- Automatically close Vim if the quickfix window is the only one open
    {'WinEnter', '*', [[if winnr('$') == 1 && &buftype == 'quickfix' | q | endif]]},
    -- Automatically update changed file in Vim
    -- Triger `autoread` when files changes on disk
    -- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    -- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    {
      'FocusGained,BufEnter,CursorHold,CursorHoldI',
      '*',
      [[silent! if mode() != 'c' | checktime | endif]],
    },
    -- Notification after file change
    -- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    {
      'FileChangedShellPost',
      '*',
      [[echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None]],
    },
    {'VimEnter', '*', [[lua require('j.utils').update_plugins_every_day()]]},
    -- Try to improve speed of snippet suggestions from compe
    {'FileType', '*', 'call vsnip#get_complete_items(bufnr())'},
  },
  -- Simple one-liner filetype specific things that I don't really want to put 
  -- into ftplugin files for whatever reason
  simple_filetypes = {
    -- The `typescriptreact` FileType autocmd gets executed BEFORE the 
    -- `ftplugin` file. However, we need to set the commentstring before any 
    -- other FileType autocmds
    {'FileType', 'typescriptreact', [[setlocal commentstring=//\ %s]]},
    {'FileType', 'vue', [[setlocal commentstring=<!--\ %s\ -->]]},
    -- Open images automatically
    {'FileType', 'image', [[lua require('j.filesystem').open_special_file()]]},
  },
})
