-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1690573382

local M = {}

local telescope_utils = require 'telescope.utils'
local make_entry = require 'telescope.make_entry'
local entry_display = require 'telescope.pickers.entry_display'

---- Helper functions ----

---Gets the File Path and its Tail (the file name) as a Tuple
---@param file_name string
---@return string, string
function M.get_path_and_tail(file_name)
  local buffer_name_tail = telescope_utils.path_tail(file_name)

  local path_without_tail = require('plenary.strings').truncate(file_name, #file_name - #buffer_name_tail, '')

  local path_to_display = telescope_utils.transform_path({
    path_display = { 'truncate' },
  }, path_without_tail)

  return buffer_name_tail, path_to_display
end

---- Picker functions ----

-- Generates a Grep Search picker but beautified
-- ----------------------------------------------
-- This is a wrapping function used to modify the appearance of pickers that provide Grep Search
-- functionality, mainly because the default one doesn't look good. It does this by changing the 'display()'
-- function that Telescope uses to display each entry in the Picker.
--
-- @param (table) picker_and_options - A table with the following format:
--                                   {
--                                      picker = '<pickerName>',
--                                      (optional) options = { ... }
--                                   }
function M.pretty_grep_picker(picker_and_options)
  if type(picker_and_options) ~= 'table' or picker_and_options.picker == nil then
    print "Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }"
    return
  end

  local options = picker_and_options.options or {}

  -- Use Telescope's existing function to obtain a default 'entry_maker' function
  -- ----------------------------------------------------------------------------
  -- INSIGHT: Because calling this function effectively returns an 'entry_maker' function that is ready to
  --          handle entry creation, we can later call it to obtain the final entry table, which will
  --          ultimately be used by Telescope to display the entry by executing its 'display' key function.
  --          This reduces our work by only having to replace the 'display' function in said table instead
  --          of having to manipulate the rest of the data too.
  local original_entry_maker = make_entry.gen_from_vimgrep(options)

  -- INSIGHT: 'entry_maker' is the hardcoded name of the option Telescope reads to obtain the function that
  --          will generate each entry.
  -- INSIGHT: The paramenter 'line' is the actual data to be displayed by the picker, however, its form is
  --          raw (type 'any) and must be transformed into an entry table.
  options.entry_maker = function(line)
    -- Generate the Original Entry table
    local original_entry_table = original_entry_maker(line)

    -- INSIGHT: An "entry display" is an abstract concept that defines the "container" within which data
    --          will be displayed inside the picker, this means that we must define options that define
    --          its dimensions, like, for example, its width.
    local displayer = entry_display.create {
      separator = ' ', -- Telescope will use this separator between each entry item
      items = {
        { width = nil },
        { width = nil }, -- Maximum path size, keep it short
        { remaining = true },
      },
    }

    -- LIFECYCLE: At this point the "displayer" has been created by the create() method, which has in turn
    --            returned a function. This means that we can now call said function by using the
    --            'displayer' variable and pass it actual entry values so that it will, in turn, output
    --            the entry for display.
    --
    -- INSIGHT: We now have to replace the 'display' key in the original entry table to modify the way it
    --          is displayed.
    -- INSIGHT: The 'entry' is the same Original Entry Table but is is passed to the 'display()' function
    --          later on the program execution, most likely when the actual display is made, which could
    --          be deferred to allow lazy loading.
    --
    -- HELP: Read the 'make_entry.lua' file for more info on how all of this works
    original_entry_table.display = function(entry)
      ---- Get File columns data ----
      -------------------------------

      local tail, path_to_display = M.get_path_and_tail(entry.filename)

      ---- Format Text for display ----
      ---------------------------------

      -- Add coordinates if required by 'options'
      local coordinates = ''

      if not options.disable_coordinates then
        if entry.lnum then
          if entry.col then
            coordinates = string.format('%s:%s', entry.lnum, entry.col)
          else
            coordinates = string.format('%s', entry.lnum)
          end
        end
      end

      -- Encode text if necessary
      local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, 'utf8') or entry.text

      -- INSIGHT: This return value should be a tuple of 2, where the first value is the actual value
      --          and the second one is the highlight information, this will be done by the displayer
      --          internally and return in the correct format.
      return displayer {
        tail,
        { coordinates, 'TelescopeResultsComment' },
        { path_to_display, 'TelescopeResultsComment' },
        text,
      }
    end

    return original_entry_table
  end

  -- Finally, check which file picker was requested and open it with its associated options
  if picker_and_options.picker == 'live_grep' then
    require('telescope.builtin').live_grep(options)
  elseif picker_and_options.picker == 'grep_string' then
    require('telescope.builtin').grep_string(options)
  elseif picker_and_options.picker == '' then
    print 'Picker was not specified'
  else
    print 'Picker is not supported by Pretty Grep Picker'
  end
end

return M
