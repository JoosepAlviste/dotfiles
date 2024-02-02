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

vim.keymap.set('n', '<leader>cd', function()
  require('j.disable_lint_rule').disable_current_line_lint_rule()
end)

vim.keymap.set('n', '<s-m-a>', 'mA')
vim.keymap.set('n', '<m-a>', "'A")
vim.keymap.set('n', '<s-m-r>', 'mR')
vim.keymap.set('n', '<m-r>', "'R")
vim.keymap.set('n', '<s-m-s>', 'mS')
vim.keymap.set('n', '<m-s>', "'S")
vim.keymap.set('n', '<s-m-t>', 'mT')
vim.keymap.set('n', '<m-t>', "'T")

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

vim.keymap.set('n', '<leader>ri', function()
  local cursor_position = vim.fn.getcurpos()
  vim.api.nvim_buf_set_mark(0, 'G', cursor_position[2], cursor_position[3] - 1, {})

  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx)
    if err then
      vim.api.nvim_err_writeln('Error when executing textDocument/definition: ' .. err.message)
      return
    end
    local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
    vim.lsp.util.jump_to_location(result[1], offset_encoding)

    local declaration_node = vim.treesitter.get_node({ ignore_injections = false }):parent()
    vim.cmd.normal "'G"

    if not declaration_node then
      vim.print 'Could not find declaration :('
      return
    end

    local lexical_declaration_node =
      require('j.treesitter_utils').find_node_ancestor({ 'lexical_declaration' }, declaration_node)
    if not lexical_declaration_node then
      vim.print 'Could not find declaration :('
      return
    end

    local declaration_value_node = declaration_node:child(2)
    if not declaration_value_node then
      vim.print 'Could not find declaration :('
      return
    end

    local declaration_value = vim.treesitter.get_node_text(declaration_value_node, 0)
    local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(lexical_declaration_node)
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {})

    local usage_node = vim.treesitter.get_node { ignore_injections = false }
    start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(usage_node)
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, vim.split(declaration_value, '\n'))
  end)
end)

-- Insert mode

-- Add new lines when pressing Enter between parentheses
vim.keymap.set('i', '<cr>', function()
  local char_to_left = vim.fn.getline('.'):sub(vim.fn.col '.' - 1, vim.fn.col '.' - 1)
  local char_to_right = vim.fn.getline('.'):sub(vim.fn.col '.', vim.fn.col '.')

  local is_middle_of_braces = char_to_left == '{' and char_to_right == '}'
  local is_middle_of_parentheses = char_to_left == '(' and char_to_right == ')'
  local is_middle_of_brackets = char_to_left == '[' and char_to_right == ']'
  local should_add_two_lines = is_middle_of_braces or is_middle_of_parentheses or is_middle_of_brackets

  if should_add_two_lines then
    return '<cr><esc>O'
  end

  return '<cr>'
end, { expr = true })
