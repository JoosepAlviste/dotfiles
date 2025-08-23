return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ['<esc>'] = { 'close', mode = { 'n', 'i' } },
            ['<s-down>'] = { 'history_forward', mode = { 'i', 'n' } },
            ['<s-up>'] = { 'history_back', mode = { 'i', 'n' } },
            ['<c-u>'] = { '<c-s-u>', mode = { 'i' }, expr = true },
            ['<c-a>'] = { '<home>', mode = { 'i' }, expr = true },
            ['<c-e>'] = { '<end>', mode = { 'i' }, expr = true },
          },
        },
      },
    },
  },

  keys = {
    {
      '<c-p>',
      function()
        local current_file = vim.fn.expand '%'

        Snacks.picker.smart {
          multi = {
            { finder = 'buffers', current = false },
            { finder = 'files', exclude = { current_file } },
          },
        }
      end,
    },
    {
      '<leader>fr',
      function()
        local cwd = vim.loop.cwd()

        Snacks.picker.recent {
          filter = {
            paths = {
              [cwd] = true,
              [cwd .. '/node_modules'] = false,
            },
          },
        }
      end,
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.grep()
      end,
    },

    {
      '<leader>fx',
      function()
        Snacks.picker.git_status()
      end,
    },
    {
      '<leader>fc',
      function()
        Snacks.picker.git_log()
      end,
    },

    {
      '<leader>fh',
      function()
        Snacks.picker.help()
      end,
    },
  },
}
