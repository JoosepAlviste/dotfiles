---Show project-local variables first in the completion menu.
---@param e1 cmp.Entry
---@param e2 cmp.Entry
---@return nil|boolean
local function compare_project_local_first(e1, e2)
  ---@param entry cmp.Entry
  ---@return boolean
  local function has_auto_import(entry)
    local entry_names = entry.completion_item.data and entry.completion_item.data.entryNames

    return entry_names and entry_names[1].data
  end

  ---@param entry cmp.Entry
  ---@return boolean
  local function is_local(entry)
    local entry_names = entry.completion_item.data.entryNames
    local auto_import_obj = entry_names and entry_names[1].data

    if not auto_import_obj or not auto_import_obj.moduleSpecifier then
      return false
    end

    return vim.startswith(auto_import_obj.moduleSpecifier, '.')
  end

  if not has_auto_import(e1) and not has_auto_import(e2) then
    return nil
  end

  if not has_auto_import(e1) and has_auto_import(e2) then
    return true
  end

  if has_auto_import(e1) and not has_auto_import(e2) then
    return false
  end

  if is_local(e1) and not is_local(e2) then
    return true
  end

  if not is_local(e1) and is_local(e2) then
    return false
  end

  return nil
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'petertriho/cmp-git',
  },
  opts = function()
    local cmp = require 'cmp'

    return {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert {
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
      },

      sources = cmp.config.sources({
        { name = 'git' },
        { name = 'nvim_lsp' },
      }, {
        { name = 'luasnip' },
      }, {
        { name = 'cmp-path' },
        { name = 'buffer', keyword_length = 5 },
      }),

      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
      },

      window = {
        documentation = cmp.config.window.bordered {
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
        },
      },

      sorting = {
        comparators = {
          cmp.config.compare.exact,
          compare_project_local_first,
          cmp.config.compare.scopes,
          cmp.config.compare.score,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    }
  end,
}
