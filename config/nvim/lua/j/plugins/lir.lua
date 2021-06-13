local actions = require('lir.actions')
local mark_actions = require('lir.mark.actions')
local clipboard_actions = require('lir.clipboard.actions')

local create_augroups = require('j.utils').create_augroups

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('lir').setup ({
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['K'] = actions.mkdir,
    ['N'] = actions.newfile,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    size_percentage = 0.5,
    winblend = 15,
    shadow = true,
  },
  hide_cursor = true,
})

function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(0, 'x', 'J', [[:<C-u>lua require'lir.mark.actions'.toggle_mark('v')<CR>]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(0, 'n', '-', [[:<C-u>lua require'lir.actions'.up()<CR>]], {noremap = true, silent = true})
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false

  -- echo cwd
  vim.api.nvim_echo({{vim.fn.expand('%:p'), 'Normal'}}, false, {})
end

create_augroups({
  lir_settings = {
    {'Filetype', 'lir', ':lua LirSettings()'},
    -- Reload lir once a session has been loaded. Otherwise, lir might load 
    -- after the session and if a folder was active, then the buffer would 
    -- break.
    {'SessionLoadPost', '*', [[lua require('lir').init()]]},
  },
})
