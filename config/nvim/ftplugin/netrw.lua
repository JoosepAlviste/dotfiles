local Path = require 'plenary.path'
local shorten_path_absolute = require('j.utils').shorten_path_absolute
local shorten_path_relative = require('j.utils').shorten_path_relative

-- Settings

vim.opt_local.number = false
vim.opt_local.relativenumber = false

vim.opt_local.colorcolumn = nil

-- Mappings

vim.keymap.set('n', '<C-l>', function()
  require('smart-splits').move_cursor_right()
end, { buffer = true })

local function lcd(path)
  vim.cmd(string.format([[silent execute (haslocaldir() ? 'lcd' : 'cd') '%s']], path))
end

local function get_open_dir()
  return vim.fn.fnamemodify(vim.b.netrw_curdir, '%') or ''
end

local function get_selected_path()
  return get_open_dir() .. '/' .. vim.fn.expand '<cfile>'
end

local function reload()
  vim.cmd.e(get_open_dir())
end

---@param path string
---@param command ?string
local function edit(path, command)
  command = command or 'e'

  vim.cmd[command](path)
end

-- A smarter function to create a new file or folder
vim.keymap.set('n', 'N', function()
  -- Temporarily CD into the currently active directory so that completion
  -- works nicely
  local save_curdir = vim.fn.getcwd()
  local current_dir = get_open_dir()

  lcd(current_dir)
  vim.ui.input({ prompt = 'New file: ', completion = 'file' }, function(name)
    lcd(save_curdir)

    if name == '' or name == nil then
      return
    end

    local is_folder = string.match(name, '/$')

    local path = Path:new(current_dir .. '/' .. name)
    if is_folder then
      -- Create a new directory
      name = name:gsub('/$', '')
      path:mkdir {
        parents = true,
        mode = tonumber('700', 8),
        exists_ok = false,
      }

      reload()

      -- Jump to a line in the parent directory of the file you created.
      local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
      local first_folder_created = name:match '^[^/]+'
      local lnum = vim.fn.indexof(lines, function(_, item)
        P(item, first_folder_created .. '/')
        return item == first_folder_created .. '/'
      end)
      if lnum then
        vim.cmd(tostring(lnum + 1))
      end
    else
      -- Create a new file
      path:touch {
        parents = true,
        mode = tonumber('644', 8),
      }

      edit(path:expand())
    end
  end)
end, { buffer = true })

vim.keymap.set('n', 'l', '<cr>', { buffer = true, remap = true })

vim.keymap.set('n', 'h', function()
  local current_dir = get_open_dir()
  local parent_dir = vim.fn.fnamemodify(current_dir, ':h')

  edit(parent_dir)
end, { buffer = true })

vim.keymap.set('n', 'D', function()
  local path_to_delete = get_selected_path()
  local cmd = 'rm -rf ' .. path_to_delete

  local nice_path = shorten_path_relative(path_to_delete)

  local choice = vim.fn.confirm('Are you sure you want to delete ' .. nice_path .. '?', '&Yes\n&No', 'N', 'Warning')

  if choice == 1 then
    os.execute(cmd)
    reload()
  end
end, { buffer = true })

vim.keymap.set('n', '<c-v>', function()
  edit(get_selected_path(), 'vs')
end, { buffer = true })

vim.keymap.set('n', '<c-s>', function()
  edit(get_selected_path(), 'sp')
end, { buffer = true })

local marked_files = {}
_G.netrw_action_files = _G.netrw_action_files or {}
_G.netrw_action = _G.netrw_action or nil
vim.keymap.set('n', 'J', function()
  local line_nr = vim.fn.line '.' - 1
  local selected_path = get_selected_path()
  local selected_file = vim.fn.getline '.'

  -- Mark selected file
  vim.highlight.range(0, 1, 'Error', { line_nr, 0 }, { line_nr, #selected_file })
  vim.cmd.normal 'j'

  table.insert(marked_files, selected_path)
end, { buffer = true })
vim.keymap.set('n', 'X', function()
  _G.netrw_action = 'move'
  _G.netrw_action_files = marked_files
end, { buffer = true })
vim.keymap.set('n', 'P', function()
  if _G.netrw_action == 'move' then
    local folder = get_open_dir()

    local commands = vim.tbl_map(function(path)
      return string.format('mv %s %s', path, folder)
    end, _G.netrw_action_files)

    for _, command in ipairs(commands) do
      vim.fn.system(command)
    end

    reload()

    _G.netrw_action = nil
    _G.netrw_action_files = {}
  end
end, { buffer = true })

-- Winbar

local folder_name = shorten_path_relative(get_open_dir())

if #folder_name > 0 then
  vim.opt_local.winbar = folder_name .. '/'
else
  vim.opt_local.winbar = shorten_path_absolute(get_open_dir())
end
