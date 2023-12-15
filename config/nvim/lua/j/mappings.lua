vim.keymap.set({ 'n', 'v' }, '<space>', '<nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local silent = { silent = true }

-- Normal mode

-- Store relative line number jumps in the jumplist if they exceed a threshold.
vim.keymap.set('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
vim.keymap.set('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- Faster scrolling
vim.keymap.set('n', '<c-e>', '3<c-e>', silent)
vim.keymap.set('n', '<c-y>', '3<c-y>', silent)

-- More comfortable jumping to marks
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', '`', "'")

-- Repurpose arrow keys for quickfix list movement
vim.keymap.set('n', '<up>', '<cmd>cprevious<cr>', silent)
vim.keymap.set('n', '<down>', '<cmd>cnext<cr>', silent)

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
vim.keymap.set('n', 'Q', '@@')

-- Split line with X
vim.keymap.set('n', 'X', '<cmd>keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>', silent)

-- Navigate merge conflict markers
vim.keymap.set('n', ']n', [[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'W')<cr>]], silent)
vim.keymap.set('n', '[n', [[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bW')<cr>]], silent)

-- Navigate loclist
vim.keymap.set('n', ']l', '<cmd>lnext<cr>', silent)
vim.keymap.set('n', '[l', '<cmd>lprev<cr>', silent)

-- Paste without populating the yank register
vim.keymap.set('x', '<leader>p', '"_dP')

-- Open the current file's directory
vim.keymap.set('n', '-', function()
  require('j.file_explorer').open_parent_dir()
end, { silent = true })

-- Close floating windows, clear highlights, etc.
vim.keymap.set('n', '<esc>', function()
  local close_all_floating_windows = require('j.utils').close_all_floating_windows

  vim.lsp.buf.clear_references()
  vim.cmd.nohlsearch()

  close_all_floating_windows()
end)

vim.keymap.set('n', '<c-g>', function()
  local shorten_path_relative = require('j.utils').shorten_path_relative

  local short_path = shorten_path_relative(vim.fn.expand '%')
  local number_of_lines = vim.fn.line '$'
  local branch = vim.b.gitsigns_head
  local lsp_client_names = table.concat(
    vim.tbl_map(function(client)
      return client.name
    end, vim.tbl_values(vim.lsp.get_clients { bufnr = 0 })),
    ', '
  )

  -- Copy path to clipboard
  vim.fn.setreg('+', short_path)

  vim.print(
    string.format('"%s"  Lines: %s  Branch: %s  LSP: %s', short_path, number_of_lines, branch, lsp_client_names)
  )
end)

-- Leader mappings

-- Open last buffer
vim.keymap.set('n', '<leader><leader>', '<c-^>')

-- Quit the buffer
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', silent)
-- Quit Vim without closing windows (useful for keeping a session)
vim.keymap.set('n', '<leader>x', '<cmd>quitall<cr>', silent)
-- Save
vim.keymap.set('n', '<leader>w', '<cmd>silent w!<cr>', silent)

-- Search & replace word under cursor
vim.keymap.set('n', '<leader>sr', '<cmd>%s/\\<<c-r><c-w>\\>/')

-- Command mode

-- Move to the start of the line
vim.keymap.set('c', '<c-a>', '<home>')

-- Visual mode

-- Visual shifting does not exit Visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('x', '.', ':normal .<cr>')
vim.keymap.set('x', '@', [[:<c-u>echo "@".getcmdline() | execute ":'<,'>normal @" . nr2char(getchar())<cr>]])

-- Custom text objects

-- Around line: with leading and trailing whitespace
vim.keymap.set('v', 'al', ':<c-u>silent! normal! 0v$<cr>', { silent = true })
vim.keymap.set('o', 'al', ':normal val<cr>', { noremap = false, silent = true })

-- Inner line: without leading or trailing whitespace
vim.keymap.set('v', 'il', ':<c-u>silent! normal! ^vg_<cr>', { silent = true })
vim.keymap.set('o', 'il', ':normal vil<cr>', { noremap = false, silent = true })

-- Whole file, jump back with <c-o>
vim.keymap.set('v', 'ae', [[:<c-u>silent! normal! m'gg0VG$<cr>]], { silent = true })
vim.keymap.set('o', 'ae', ':normal Vae<cr>', { noremap = false, silent = true })
