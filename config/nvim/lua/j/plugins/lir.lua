local lir = require 'lir'
local actions = require 'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require 'lir.clipboard.actions'
local Path = require 'plenary.path'

local create_augroups = require('j.utils').create_augroups

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lcd = function(path)
  vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
end

-- A smarter function to create a new file or folder
local function new_file()
  -- Temporarily CD into the currently active directory so that completion
  -- works nicely
  local save_curdir = vim.fn.getcwd()
  lcd(lir.get_context().dir)
  local name = vim.fn.input('New file: ', '', 'file')
  lcd(save_curdir)

  if name == '' then
    return
  end

  local is_folder = string.match(name, '/$')

  local path = Path:new(lir.get_context().dir .. name)
  if is_folder then
    -- Create a new directory
    name = name:gsub('/$', '')
    path:mkdir {
      parents = true,
      mode = tonumber('700', 8),
      exists_ok = false,
    }

    actions.reload()

    -- Jump to a line in the parent directory of the file you created.
    local lnum = lir.get_context():indexof(name:match '^[^/]+')
    if lnum then
      vim.cmd(tostring(lnum))
    end
  else
    -- Create a new file
    path:touch {
      parents = true,
      mode = tonumber('644', 8),
    }

    vim.cmd(':e ' .. path:expand())
  end
end

require('lir').setup {
  show_hidden_files = true,
  devicons_enable = true,
  mappings = {
    ['l'] = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h'] = actions.up,
    ['q'] = actions.quit,

    ['N'] = new_file,
    ['R'] = actions.rename,
    ['@'] = actions.cd,
    ['Y'] = actions.yank_path,
    ['.'] = actions.toggle_show_hidden,
    ['D'] = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd 'normal! j'
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    winblend = 0,
  },
  hide_cursor = true,
}

function _G.LirSettings()
  vim.api.nvim_buf_set_keymap(
    0,
    'x',
    'J',
    [[:<C-u>lua require'lir.mark.actions'.toggle_mark('v')<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '-',
    [[:<C-u>lua require'lir.actions'.up()<CR>]],
    { noremap = true, silent = true }
  )
  vim.cmd [[setlocal nonumber]]
  vim.cmd [[setlocal norelativenumber]]

  -- echo cwd
  local filename = vim.fn.expand('%'):gsub(vim.pesc(vim.loop.cwd()), '.'):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')
  vim.api.nvim_echo({ { filename, 'Normal' } }, false, {})
end

create_augroups {
  lir_settings = {
    { 'Filetype', 'lir', ':lua LirSettings()' },
    -- Reload lir once a session has been loaded. Otherwise, lir might load
    -- after the session and if a folder was active, then the buffer would
    -- break.
    { 'SessionLoadPost', '*', [[lua require('lir').init()]] },
  },
}
