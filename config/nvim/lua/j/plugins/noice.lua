require('noice').setup {
  cmdline = {
    format = {
      search_down = { kind = 'search', pattern = '^/', icon = '', lang = 'regex' },
      search_up = { kind = 'search', pattern = '^%?', icon = '', lang = 'regex' },
    },
  },
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
    signature = {
      enabled = false,
    },
  },
  presets = {
    command_palette = true,
    long_message_to_split = true,
    lsp_doc_border = true,
  },
  views = {
    mini = {
      win_options = {
        winblend = 0,
      },
    },
    cmdline_popup = {
      border = {
        style = 'none',
        padding = { 1, 3 },
      },
    },
  },
  routes = {
    {
      filter = {
        any = {
          {
            event = 'msg_show',
            kind = '',
            find = '%d+ change;',
          },
          {
            event = 'msg_show',
            kind = '',
            find = '%d+ line less;',
          },
          {
            event = 'msg_show',
            kind = '',
            find = '%d+ fewer lines;?',
          },
          {
            event = 'msg_show',
            kind = '',
            find = '%d+ more lines?;',
          },
          {
            event = 'msg_show',
            kind = '',
            find = '".+" %d+L, %d+B',
          },
        },
      },
      opts = { skip = true },
    },
    {
      view = 'notify',
      filter = {
        -- Hover when cursor not on anything
        find = 'No information available',
      },
      opts = { skip = true },
    },
    {
      filter = {
        any = {
          {
            event = 'lsp',
            kind = 'progress',
            find = 'diagnostics_on_open',
          },
          {
            event = 'lsp',
            kind = 'progress',
            find = 'diagnostics',
          },
          {
            event = 'lsp',
            kind = 'progress',
            find = 'Checking document',
          },
          {
            event = 'lsp',
            kind = 'progress',
            find = 'formatting',
          },
        },
      },
      skip = true,
    },
  },
}
