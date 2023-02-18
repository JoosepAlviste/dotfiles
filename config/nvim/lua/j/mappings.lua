local map = require('j.utils').map

local silent = { silent = true }

-- Normal mode

-- Store relative line number jumps in the jumplist if they exceed a threshold.
map('n', 'k', '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
map('n', 'j', '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- Faster scrolling
map('n', '<c-e>', '3<c-e>')
map('n', '<c-y>', '3<c-y>')

-- More comfortable jumping to marks
map('n', "'", '`')
map('n', '`', "'")

-- Repurpose arrow keys for quickfix list movement
map('n', '<up>', ':cprevious<cr>', silent)
map('n', '<down>', ':cnext<cr>', silent)

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
map('n', 'Q', '@@')

-- Split line with X
map('n', 'X', ':keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>', { silent = true })

-- Navigate merge conflict markers
map('n', ']n', [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'W')<cr>]], { silent = true })
map('n', '[n', [[:call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bW')<cr>]], { silent = true })

-- Navigate loclist
map('n', ']l', ':lnext<cr>', { silent = true })
map('n', '[l', ':lprev<cr>', { silent = true })

-- Open the file under the cursor with the default file handler for that file
-- type (e.g., Firefox for `http` links, etc.)
-- This mapping normally comes from `netrw`, but since we disable that (for
-- dirvish), then we need to manually configure the mapping again
map('n', 'gx', [[:call joosep#open#open_url_under_cursor()<cr>]], { silent = true })

map('n', '<F10>', function()
  require('j.syntax').print_syntax()
end, { silent = true })

-- Open the current file's directory
map('n', '-', [[expand('%') == '' ? ':e ' . getcwd() . '<cr>' : ':e %:h<cr>']], { expr = true, silent = true })
map('n', 'H', [[:echo 'Use - instead!'<cr>]])

-- Close floating windows, clear highlights, etc.
map('n', '<esc>', function()
  require('notify').dismiss()
  vim.lsp.buf.clear_references()
  vim.cmd.nohlsearch()

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local status, config = pcall(vim.api.nvim_win_get_config, win)
    if config and config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end)

-- Leader mappings

-- Open last buffer
map('n', '<leader><leader>', '<c-^>')

-- Quit the buffer
map('n', '<leader>q', ':quit<cr>', silent)
-- Quit Vim without closing windows (useful for keeping a session)
map('n', '<leader>x', ':quitall<cr>', silent)
-- Save
map('n', '<leader>w', ':silent w!<cr>', silent)

-- Search & replace word under cursor
map('n', '<leader>sr', ':%s/\\<<c-r><c-w>\\>/')

-- Command mode

-- Move to the start of the line
map('c', '<c-a>', '<home>')

-- Visual mode

-- Visual shifting does not exit Visual mode
map('v', '<', '<gv')
map('v', '>', '>gv')

map('x', '.', ':normal .<cr>')
map('x', '@', [[:<c-u>echo "@".getcmdline() | execute ":'<,'>normal @" . nr2char(getchar())<cr>]])

-- Custom text objects

-- Around line: with leading and trailing whitespace
map('v', 'al', ':<c-u>silent! normal! 0v$<cr>', { silent = true })
map('o', 'al', ':normal val<cr>', { noremap = false, silent = true })

-- Inner line: without leading or trailing whitespace
map('v', 'il', ':<c-u>silent! normal! ^vg_<cr>', { silent = true })
map('o', 'il', ':normal vil<cr>', { noremap = false, silent = true })

-- Whole file, jump back with <c-o>
map('v', 'ae', [[:<c-u>silent! normal! m'gg0VG$<cr>]], { silent = true })
map('o', 'ae', ':normal Vae<cr>', { noremap = false, silent = true })
