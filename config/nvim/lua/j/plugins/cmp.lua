local cmp = require 'cmp'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

-- Codicons, download from
-- https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf and
-- using FontForge, move down by 60
local icons = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },

  sources = {
    { name = 'git' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  },

  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },

  window = {
    documentation = cmp.config.window.bordered {
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
    completion = {
      side_padding = 0,
      col_offset = -3,
    },
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)

      -- Move the icon to be on the left side
      local strings = vim.split(kind, '%s', { trimempty = true })
      vim_item.kind = ' ' .. strings[1] .. ' '

      local detail = entry:get_completion_item().detail
      local detail_path = detail and (string.match(detail, "Auto import from '([^']+)'"))
      if not vim_item.menu or #vim_item.menu == 0 then
        if detail and not detail_path then
          vim_item.menu = detail
        elseif detail_path then
          vim_item.menu = detail_path
        end
      end

      if vim_item.menu and #vim_item.menu > 25 then
        local first_slash = string.find(vim_item.menu, '/')
        local last_slash = string.find(vim_item.menu, '/[^/]*$')

        if not first_slash then
          return vim_item
        end

        vim_item.menu = string.sub(vim_item.menu, 1, first_slash) .. '…' .. string.sub(vim_item.menu, last_slash)
      end

      return vim_item
    end,
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under, but I don't think I need the plugin for this.
      -- I might add some more of my own.
      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find '^_+'
        local _, entry2_under = entry2.completion_item.label:find '^_+'
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

require('cmp_git').setup()

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
