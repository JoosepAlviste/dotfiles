local fzf = require('fzf').fzf

local default_preview = 'bat --color always -- {}'
local ripgrep_preview = 'fzf-preview {}'  -- fzf-preview is a script in my dotfiles

local M = {}

local function fzf_args(name)
  return '--ansi --multi --expect=ctrl-s,ctrl-t,ctrl-v --history=/tmp/fzf-' .. name .. ' '
end

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


function M.files()
  local command = 'fd --color always -t f -L --hidden'
  local preview = default_preview

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      (fzf_args('files') .. '--preview=%s'):format(
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
      (fzf_args('grep') .. '--delimiter : --nth 3.. --prompt "Grep > " --delimiter : --preview-window "+{2}-/2" --preview=%s'):format(
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
      (fzf_args('grep-folder') .. '--delimiter : --nth 3.. --prompt "%s > " --delimiter : --preview-window "+{2}-/2" --preview=%s'):format(
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
      (fzf_args('history') .. '--preview=%s'):format(
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
      (fzf_args('git-status') .. '--preview=%s'):format(preview)
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
      (fzf_args('directories') .. '--preview=%s'):format(
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
      (fzf_args('lsp-references') .. '--delimiter : --nth 3.. --prompt "Grep > " --delimiter : --preview-window "+{2}-/2" --preview=%s'):format(
        vim.fn.shellescape(preview)
      )
    )

    handle_selected_files(choices)
  end)()
end

local function readfilecb(path, callback)
  vim.loop.fs_open(path, "r", 438, function(err, fd)
    if err then
      callback(err)
      return
    end
    vim.loop.fs_fstat(fd, function(err, stat)
      if err then
        callback(err)
        return
      end
      vim.loop.fs_read(fd, stat.size, 0, function(err, data)
        if err then
          callback(err)
          return
        end
        vim.loop.fs_close(fd, function(err)
          if err then
            callback(err)
            return
          end
          return callback(nil, data)
        end)
      end)
    end)
  end)
end

local function readfile(name)
  local co = coroutine.running()
  readfilecb(name, function (err, data)
    coroutine.resume(co, err, data)
  end)
  local err, data = coroutine.yield()
  if err then error(err) end
  return data
end

local function deal_with_tags(tagfile, cb)
  local co = coroutine.running()
  coroutine.wrap(function ()
    local success, data = pcall(readfile, tagfile)
    if success then
      for i, line in ipairs(vim.split(data, '\n')) do
        local items = vim.split(line, '\t')
        -- escape codes for grey
        local tag = string.format('%s\t\27[0;37m%s\27[0m', items[1], items[2])
        local co = coroutine.running()
        cb(tag, function ()
          coroutine.resume(co)
        end)
        coroutine.yield()
      end
    end
    coroutine.resume(co)
  end)()
  coroutine.yield()
end

local function fzf_function(cb)
  local runtimepaths = vim.api.nvim_list_runtime_paths()

  local total_done = 0
  for i, rtp in ipairs(runtimepaths) do
    local tagfile = table.concat({rtp, 'doc', 'tags'}, '/')
    -- wrapping to make all the file reading concurrent
    coroutine.wrap(function ()
      deal_with_tags(tagfile, cb)
      total_done = total_done + 1
      if total_done == #runtimepaths then
        cb(nil)
      end
    end)()
  end
end

function M.help_tags()
  coroutine.wrap(function ()
    local result = fzf(fzf_function, fzf_args('help-tags') .. '--nth 1')
    if not result then
      return
    end
    local choice = vim.split(result[2], '\t')[1]
    local key = result[1]
    local windowcmd
    if key == '' or key == 'ctrl-s' then
      windowcmd = ''
    elseif key == 'ctrl-v' then
      windowcmd = 'vertical'
    elseif key == 'ctrl-t' then
      windowcmd = 'tab'
    else
      print('Not implemented!')
      error('Not implemented!')
    end

    vim.cmd(string.format('%s h %s', windowcmd, choice))
  end)()
end

return M
