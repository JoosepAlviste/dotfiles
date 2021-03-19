local fzf = require('fzf').fzf

local utils = require('j.utils')
local map = utils.map
local create_augroups = utils.create_augroups

local M = {}

local default_preview = 'bat --color always -- {}'
local ripgrep_preview = 'fzf-preview {}'  -- fzf-preview is a script in my dotfiles

-- Open the given list of selected files
-- The first element of `choices` is the key that the user pressed (e.g., 
-- "ctrl-t") and the rest of the table is the files that were selected.
local function handle_selected_files(choices)
  if not choices then return end

  local vimcmd = 'e'
  if choices[1] == 'ctrl-t' then
    vimcmd = 'tabnew'
  elseif choices[1] == 'ctrl-v' then
    vimcmd = 'vnew'
  elseif choices[1] == 'ctrl-s' then
    vimcmd = 'new'
  end

  local qf_items = vim.tbl_map(function (choice)
    -- Split the selected item to filename + line nr. E.g., ripgrep outputs 
    -- "/my/file.txt:1:2: file content here" where we want "/my/file.txt" and 
    -- "1". Shouldn't break if no line number or column nr is output.

    local tokens = vim.split(choice, ':')
    local filename = tokens[1]
    local line_nr = tonumber(tokens[2])
    local column_nr = tonumber(tokens[3])

    return {filename = filename, lnum = line_nr, col = column_nr}
  end, {unpack(choices, 2)})

  if vimcmd == 'e' and #qf_items > 1 then
    -- If <cr> is pressed and multiple file are selected, add them all to the 
    -- quickfix list

    vim.fn.setqflist({}, ' ', {id = 'fzf', items = qf_items})
    vim.cmd [[copen]]
    vim.cmd [[cfirst]]
  else
    for i = 1, #qf_items do
      local filename = qf_items[i].filename
      local line_nr = qf_items[i].lnum
      local column_nr = qf_items[i].col
      if line_nr then
        -- Open the file at the specified line nr
        vim.cmd(vimcmd .. ' +' .. line_nr .. ' ' .. vim.fn.fnameescape(filename))
      else
        vim.cmd(vimcmd .. ' ' .. vim.fn.fnameescape(filename))
      end

      -- If a column number is given
      if column_nr then
        vim.cmd('normal! ' .. column_nr .. '|')
        vim.cmd('normal! zz')
      end
    end
  end
end

function M.setup()
  map('n', '<c-p>',      [[<cmd>lua require('j.plugins.fzf').files()<cr>]])
  map('n', '<leader>ff', [[<cmd>lua require('j.plugins.fzf').grep()<cr>]])
  map('n', '<leader>fa', [[<cmd>lua require('j.plugins.fzf').grep()<cr>]])
  map('v', '<space>ff',  [[<cmd>lua require('j.plugins.fzf').grep_selected()<cr>]])
  map('n', '<leader>fr', [[<cmd>lua require('j.plugins.fzf').history()<cr>]])
  map('n', '<leader>fx', [[<cmd>lua require('j.plugins.fzf').git_status()<cr>]])
  map('n', '<leader>fd', [[<cmd>lua require('j.plugins.fzf').directories()<cr>]])

  create_augroups({
    fzf = {
      {'FileType', 'fzf', [[tunmap <buffer> <esc>]]},
    },
  })

  -- Grep in files with the given extension
  vim.cmd [[command! -nargs=1 GrepFT lua require('j.plugins.fzf').grep_folder('**/*.<args>')]]
end

function M.files()
  local command = 'fd --color always -t f -L --hidden'
  local preview = default_preview

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      ('--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

function M.grep(search)
  search = search or ''
  local command = 'rg --line-number --no-heading --color=always --smart-case -- "' .. search .. '"'
  local preview = ripgrep_preview

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      ('--ansi --delimiter : --nth 3.. --prompt "Grep > " --delimiter : --preview-window "+{2}-/2" --expect=ctrl-s,ctrl-t,ctrl-v --multi --preview=%s'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

local function get_selection()
    local old_reg = vim.fn.getreg("v")
    vim.cmd [[normal! "vy]]
    local raw_search = vim.fn.getreg("v")
    vim.fn.setreg('v', old_reg)
    return vim.fn.substitute(vim.fn.escape(raw_search, '\\/.*$^~[]{}'), '\n', '\\n', 'g')
end

function M.grep_selected()
  return M.grep(get_selection())
end

function M.grep_folder(folder)
  local glob = vim.endswith(folder, '/') and folder .. '**/*' or folder
  local command = (
    [[rg --line-number --no-heading --color=always --smart-case -g '%s' -- ""]]
  ):format(glob)
  local preview = ripgrep_preview

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      ('--ansi --delimiter : --nth 3.. --prompt "%s > " --delimiter : --preview-window "+{2}-/2" --expect=ctrl-s,ctrl-t,ctrl-v --multi --preview=%s'):format(
        folder,
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

function M.history()
  local preview = default_preview
  local cwd = vim.loop.cwd()

  coroutine.wrap(function ()
    -- A filename can include some symbols that mess with filtering, escape 
    -- them
    local escaped_cwd = vim.pesc(cwd)
    local oldfiles = vim.v.oldfiles

    local cwd_oldfiles = vim.tbl_map(
      function (file)
        return vim.fn.fnamemodify(file, ':~:.')
      end,
      vim.tbl_filter(function (file)
        return string.match(file, escaped_cwd) and vim.fn.filereadable(file) ~= 0
      end, oldfiles)
    )

    local choices = fzf(
      cwd_oldfiles,
      ('--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

-- View modified or added Git files
function M.git_status()
  -- Preview Git diff if the file is changed, otherwise the whole file
  local preview = [=["sh -c \"if [ \"{1}\" = \"M\" ]; then git diff --color=always {-1}; else bat --color=always {-1}; fi\""]=]

  coroutine.wrap(function ()
    local choices = fzf(
      'git -c color.status=always status --short --untracked-files=all',
      ('--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi'):format(preview)
    )

    local first = true
    choices = vim.tbl_map(function (choice)
      if first then
        first = false
        return choice
      end

      -- The choice includes the Git status (' M foobar.txt')
      return vim.split(vim.trim(choice), ' ')[2]
    end, choices)

    handle_selected_files(choices)
  end)()
end

function M.directories()
  local command = 'fd --color always -t d -L --hidden'
  local preview = 'exa -aTR --color=always --group-directories-first --icons {}'

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      ('--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

function M.lsp_references_handler(_, _, results)
  local preview = 'fzf-preview {}'

  local files = vim.tbl_map(
    function (res)
      local filename = vim.fn.fnamemodify(string.sub(res.uri, 8), ":~:.")
      local line_nr = res.range.start.line + 1 -- res is 0-indexed, line numbers should be 1-indexed
      local column_nr = res.range.start.character + 1
      return filename .. ':' .. line_nr .. ':' .. column_nr
    end,
    vim.tbl_filter(
      function (res)
        -- TODO: Handle `.template` postfix
        return vim.fn.filereadable(string.sub(res.uri, 8)) ~= 0
      end,
      results
    )
  )

  coroutine.wrap(function ()
    local choices = fzf(
      files,
      ('--ansi --delimiter : --nth 3.. --prompt "Grep > " --delimiter : --preview-window "+{2}-/2" --expect=ctrl-s,ctrl-t,ctrl-v --multi --preview=%s'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

return M
