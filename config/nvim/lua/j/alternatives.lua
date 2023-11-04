---@class AlternativeReplacement
---@field from string
---@field to string

---@alias AlternativeOpenTarget 'edit' | 'vsplit'
---How to open a file, in the same window or a split, etc.

---@class AlternativeTarget
---@field target string
---@field type? string

---@alias AlternativeConfig table<string, (string | AlternativeTarget)[]>

---@type AlternativeConfig
local alternatives_map = {
  ['*.ts'] = {
    { target = '{*}.test.ts', type = 'test' },
    { target = '{directory}/__tests__/{basename}.test.ts', type = 'test' },
  },
  ['*.tsx'] = {
    { target = '{*}.test.tsx', type = 'test' },
    { target = '{*}.test.ts', type = 'test' },
    { target = '{directory}/__tests__/{basename}.test.tsx', type = 'test' },
    { target = '{directory}/__tests__/{basename}.test.ts', type = 'test' },
    { target = '{*}.css.ts', type = 'style' },
  },
  ['*.vue'] = { { target = '{*}.test.ts' }, type = 'test' },
  ['*.test.ts'] = { { target = '{*}.vue', type = 'source' }, { target = '{*}.ts', type = 'source' } },
  ['*.test.tsx'] = { { target = '{*}.tsx', type = 'source' } },
  ['**/__tests__/*.test.ts'] = { { target = '{**}/{*}.ts', type = 'source' } },
  ['**/__tests__/*.test.tsx'] = { { target = '{**}/{*}.tsx', type = 'source' } },
  ['*.css.ts'] = { { target = '{*}.tsx', type = 'source' } },
}

---Open the file at the given path.
---@param path string
---@param open_target AlternativeOpenTarget?
local open_path = function(path, open_target)
  local cmd = open_target or 'edit'
  vim.fn.execute(cmd .. ' ' .. path)
end

---Select one file to open out of a list of paths.
---@param message string
---@param paths string[]
---@param open_target AlternativeOpenTarget
local select_file_to_open = function(message, paths, open_target)
  vim.ui.select(paths, {
    prompt = 'Select a file to create:',
  }, function(choice)
    open_path(choice, open_target)
  end)
end

---Execute multiple gsubs on the string.
---@param str string
---@param replacements AlternativeReplacement[]
local gsub_all = function(str, replacements)
  local replaced = str
  for _, replacement in ipairs(replacements) do
    replaced = replaced:gsub(replacement.from, replacement.to)
  end
  return replaced
end

---The number of capture groups allowed, each represented by a number of
---asterisk characters. For example, if this is set to 3, the capture groups
---will be `*`, `**`, and `***`.
local NUMBER_OF_CAPTURE_GROUPS = 2

---List of capture groups, asterisks.
---E.g., `{'*', '**', '***'}`
---@type string[]
local CAPTURE_GROUPS = {}
for i = 1, NUMBER_OF_CAPTURE_GROUPS, 1 do
  table.insert(CAPTURE_GROUPS, string.rep('*', i))
end

---Get the values for each capture group.
---@param file_path string E.g., "src/components/MyComponent.vue"
---@param extension_pattern string Key in the configuration, e.g., "*.ts"
---@return table<string, string> Key is the capture group (e.g., "***") and the value is the captured value (e.g., a part of a file path).
local get_all_captured_text_by_groups = function(file_path, extension_pattern)
  -- Replace all pattern placeholders with explicit capture group names so that
  -- they can be later extracted. If the groups are stars, then we can't extract
  -- the value for each group from the `file_path`.

  ---@type AlternativeReplacement[]
  local captures_replacements = {}
  for i = NUMBER_OF_CAPTURE_GROUPS, 1, -1 do
    table.insert(captures_replacements, {
      from = vim.pesc(string.rep('*', i)),
      to = '__CAPTURE' .. i .. '__',
    })
  end
  ---Each capture group (`*`) has been replaced by `__CAPTUREX__` where `X` is
  ---the number of the capture group.
  ---E.g., `*.ts` -> `__CAPTURE1__.ts`
  local extension_pattern_with_captures = gsub_all(extension_pattern, captures_replacements)

  ---@type table<string, string>
  local captured_values = {}
  for _, capture in ipairs(CAPTURE_GROUPS) do
    ---@types Replacement[]
    local replacements = vim.tbl_map(function(group)
      return {
        from = '__CAPTURE' .. #group .. '__',
        to = #capture == #group and '(.*)' or '.*',
      }
    end, CAPTURE_GROUPS)

    local expension_pattern_with_pattern = gsub_all(extension_pattern_with_captures, replacements)
    local captured_value = string.match(file_path, expension_pattern_with_pattern .. '$')

    captured_values[capture] = captured_value
  end

  return captured_values
end

---@class AlternativeParams
---@field target? AlternativeOpenTarget?
---@field type? string
---@field config? AlternativeConfig

---Open an alternative file to the current one.
---@param params AlternativeParams
local open_alternative = function(params)
  params = params or {}
  local open_target = params.target or 'edit'
  local open_type = params.type
  local config = params.config
  if not config and vim.fn.filereadable '.alternatives.json' then
    -- local a = vim.uv_fs_open('.alternatives.json', 'r')
    -- P(a)
  end

  local current_file_path =
    vim.fn.expand('%'):gsub(vim.pesc(vim.loop.cwd() .. '/'), ''):gsub(vim.pesc(vim.fn.expand '$HOME'), '~')

  local current_file_basename = vim.fn.fnamemodify(current_file_path, ':t')
  local current_file_directory = vim.fn.fnamemodify(current_file_path, ':h')

  ---The extensions that match the current file (keys from the configuration).
  ---@type string[]
  local extensions_that_match = vim.tbl_filter(function(matching_extension)
    return current_file_path:match(string.gsub(matching_extension, vim.pesc '*', '.*') .. '$')
  end, vim.tbl_keys(alternatives_map))
  -- Sort extensions by length, to match more specific ones first
  table.sort(extensions_that_match, function(a, b)
    return #a > #b
  end)

  if #extensions_that_match == 0 then
    vim.notify 'No alternatives found.'
    return
  end

  local paths_to_match = vim.tbl_flatten(vim.tbl_map(function(matching_file_extension)
    local alternatives_to_check = vim.tbl_filter(function(alternative)
      if type(alternative) == 'string' or not alternative.type or not open_type then
        return true
      end

      return alternative.type == open_type
    end, alternatives_map[matching_file_extension])
    local extension_regex = matching_file_extension:gsub('.*/', ''):gsub('%**', '(.*)')
    local basename_without_extension = current_file_basename:match(extension_regex)

    local a = get_all_captured_text_by_groups(current_file_path, matching_file_extension)

    ---@param target string | AlternativeTarget
    return vim.tbl_map(function(target)
      local path = type(target) == 'string' and target or target.target

      local replacements = {
        { from = '{basename}', to = basename_without_extension },
        { from = '{directory}', to = current_file_directory },
      }
      for from, to in pairs(a) do
        table.insert(replacements, {
          from = vim.pesc('{' .. from .. '}'),
          to = to,
        })
      end

      return gsub_all(path, replacements)
    end, alternatives_to_check)
  end, extensions_that_match))

  local paths_that_exist = vim.tbl_filter(function(path)
    return vim.fn.filereadable(path) == 1
  end, paths_to_match)
  if #paths_that_exist == 1 then
    open_path(paths_that_exist[1], open_target)
    return
  elseif #paths_that_exist > 1 then
    select_file_to_open('Select a file to open:', paths_that_exist, open_target)
    return
  end

  local paths_that_dont_exist = vim.tbl_filter(function(path)
    return vim.fn.filereadable(path) == 0
  end, paths_to_match)
  if #paths_that_dont_exist > 0 then
    select_file_to_open('Select a file to create:', paths_that_dont_exist, open_target)
  end
end

vim.keymap.set('n', '<leader>ae', function()
  open_alternative { target = 'edit' }
end)

vim.keymap.set('n', '<leader>av', function()
  open_alternative { target = 'vsplit' }
end)

vim.keymap.set('n', '<leader>ace', function()
  open_alternative { target = 'edit', type = 'style' }
end)

vim.keymap.set('n', '<leader>acv', function()
  open_alternative { target = 'vsplit', type = 'style' }
end)
