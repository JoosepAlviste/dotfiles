local Path = require 'plenary.path'
local action_set = require 'telescope.actions.set'
local action_state = require 'telescope.actions.state'
local transform_mod = require('telescope.actions.mt').transform_mod
local actions = require 'telescope.actions'
local conf = require('telescope.config').values
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local os_sep = Path.path.sep
local pickers = require 'telescope.pickers'
local scan = require 'plenary.scandir'
local entry_display = require 'telescope.pickers.entry_display'
local read_json_file = require('j.utils').read_json_file
local read_package_json = require('j.utils').read_package_json
local termcode = require('j.utils').termcode

local M = {}

---Keep track of the active extension and folders for `live_grep`
local live_grep_filters = {
  ---@type nil|string
  extension = nil,
  ---@type nil|string[]
  directories = nil,
}

---Run `live_grep` with the active filters (extension and folders)
local function run_live_grep(current_input)
  -- TODO: Resume old one with same options somehow
  require('telescope.builtin').live_grep {
    additional_args = live_grep_filters.extension and function()
      return { '-g', '*.' .. live_grep_filters.extension }
    end,
    search_dirs = live_grep_filters.directories,
    default_text = current_input,
  }
end

M.actions = transform_mod {
  ---Ask for a file extension and open a new `live_grep` filtering by it
  set_extension = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()

    vim.ui.input({ prompt = '*.' }, function(input)
      if input == nil then
        return
      end

      live_grep_filters.extension = input

      actions._close(prompt_bufnr, current_picker.initial_mode == 'insert')
      run_live_grep(current_input)
    end)
  end,
  ---Ask the user for a folder and olen a new `live_grep` filtering by it
  set_folders = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()

    local data = {}
    scan.scan_dir(vim.loop.cwd(), {
      hidden = true,
      only_dirs = true,
      respect_gitignore = true,
      on_insert = function(entry)
        table.insert(data, entry .. os_sep)
      end,
    })
    table.insert(data, 1, '.' .. os_sep)

    actions._close(prompt_bufnr, current_picker.initial_mode == 'insert')
    pickers.new({}, {
      prompt_title = 'Folders for Live Grep',
      finder = finders.new_table { results = data, entry_maker = make_entry.gen_from_file {} },
      previewer = conf.file_previewer {},
      sorter = conf.file_sorter {},
      attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)

          local dirs = {}
          local selections = current_picker:get_multi_selection()
          if vim.tbl_isempty(selections) then
            table.insert(dirs, action_state.get_selected_entry().value)
          else
            for _, selection in ipairs(selections) do
              table.insert(dirs, selection.value)
            end
          end
          live_grep_filters.directories = dirs

          actions.close(prompt_bufnr)
          run_live_grep(current_input)
        end)
        return true
      end,
    }):find()
  end,
}

---Small wrapper over `live_grep` to first reset our active filters
M.live_grep = function()
  live_grep_filters.extension = nil
  live_grep_filters.directories = nil

  require('telescope.builtin').live_grep()
end

M.scripts = function(opts)
  opts = opts or {}

  local use_pnpm = Path:new('../pnpm-lock.yaml'):exists()
  local use_npm = Path:new('package-lock.json'):exists()

  local package_json = read_package_json() or {}
  local npm_scripts = vim.tbl_keys(package_json.scripts or {})

  local make_scripts = {}
  local makefile_path = Path:new 'Makefile'
  if makefile_path:exists() then
    local makefile = makefile_path:read()
    local makefile_lines = vim.split(makefile, '\n')

    make_scripts = vim.tbl_map(
      function(line)
        return string.match(line, '^(%a.*):')
      end,
      vim.tbl_filter(function(line)
        return string.match(line, '^%a.*:')
      end, makefile_lines)
    )
  end

  local composer_json = read_json_file 'composer.json' or {}
  local composer_scripts = vim.tbl_keys(composer_json.scripts or {})

  if #npm_scripts == 0 and #make_scripts == 0 then
    return vim.notify 'No scripts found!'
  end

  local mapped_scripts = vim.list_extend(
    vim.tbl_map(function(script)
      return { script, 'make', nil }
    end, make_scripts or {}),
    vim.tbl_map(function(script)
      local executable = use_pnpm and 'pnpm' or use_npm and 'npm run' or ''

      return { script, executable, package_json.scripts[script] }
    end, npm_scripts or {})
  )
  mapped_scripts = vim.list_extend(
    mapped_scripts,
    vim.tbl_map(function(script)
      return { script, 'composer', composer_json.scripts[script] }
    end, composer_scripts or {})
  )

  local longest_executable_name = math.max(unpack(vim.tbl_map(function(script)
    return #script[2]
  end, mapped_scripts)))
  local longest_script_name = math.max(unpack(vim.tbl_map(function(script)
    return #script[1]
  end, mapped_scripts)))

  local displayer = entry_display.create {
    separator = '  ',
    items = {
      { width = longest_executable_name },
      { width = longest_script_name },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.executable, 'TelescopeResultsIdentifier' },
      { entry.value, 'TelescopeResultsIdentifier' },
      { entry.cmd or '', 'TelescopeResultsComment' },
    }
  end

  pickers.new(opts, {
    prompt_title = 'Scripts',

    finder = finders.new_table {
      results = mapped_scripts,
      entry_maker = function(entry)
        return {
          value = entry[1],
          display = make_display,
          ordinal = entry[3] and (entry[2] .. ' ' .. entry[1] .. ' ' .. entry[3]) or (entry[2] .. ' ' .. entry[1]),
          cmd = entry[3],
          executable = entry[2],
        }
      end,
    },

    sorter = conf.generic_sorter(opts),

    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        local script = selection.value

        vim.cmd.T(selection.executable .. ' ' .. script)
        vim.cmd.Topen()
      end)
      return true
    end,
  }):find()
end

return M
