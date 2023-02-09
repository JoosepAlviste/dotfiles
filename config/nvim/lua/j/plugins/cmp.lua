local cmp = require 'cmp'

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

  window = {
    documentation = cmp.config.window.bordered {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
    completion = {
      side_padding = 0,
      col_offset = -3,
    },
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(_, vim_item)
      local kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind)

      -- Move the icon to be on the left side
      local strings = vim.split(kind, '%s', { trimempty = true })
      vim_item.kind = ' ' .. strings[1] .. ' '

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
}

require('cmp_git').setup()
