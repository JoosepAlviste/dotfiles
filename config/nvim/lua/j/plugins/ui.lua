return {
  {
    'mrjones2014/smart-splits.nvim',
    event = 'VeryLazy',
    build = './kitty/install-kittens.bash',
    config = function()
      local ss = require 'smart-splits'

      ss.setup()

      vim.keymap.set('n', '<c-h>', ss.move_cursor_left)
      vim.keymap.set('n', '<c-j>', ss.move_cursor_down)
      vim.keymap.set('n', '<c-k>', ss.move_cursor_up)
      vim.keymap.set('n', '<c-l>', ss.move_cursor_right)
    end,
  },
  {
    'lukas-reineke/virt-column.nvim',
    opts = { char = '│' },
  },
  {
    'stevearc/oil.nvim',
    enabled = true,
    dependencies = {
      {
        'nvim-tree/nvim-web-devicons',
        opts = {
          override = {
            ts = {
              icon = '',
              color = '#519aba',
              name = 'TypeScript',
            },
            ['d.ts'] = {
              icon = '',
              color = '#d59855',
              name = 'TypeScriptDeclaration',
            },
            tsx = {
              icon = '',
              color = '#519aba',
              name = 'TypeScript',
            },
            json = {
              icon = '',
              color = '#cbcb41',
              name = 'Json',
            },
            ['.eslintrc.js'] = {
              icon = '',
              color = '#4b32c3',
              name = 'Eslintrc',
            },
            ['md'] = {
              icon = '',
              color = '#dddddd',
              name = 'Md',
            },
          },
          override_by_filename = {
            ['package.json'] = {
              icon = '',
              color = '#e8274b',
              name = 'PackageJson',
            },
            ['package-lock.json'] = {
              icon = '',
              color = '#e8274b',
              name = 'PackageJson',
            },
            ['.gitignore'] = {
              icon = '󰊢',
              color = '#f54d27',
              name = 'Git',
            },
            ['.eslintignore'] = {
              icon = '',
              color = '#4b32c3',
              name = 'Eslintrc',
            },
            ['.eslintcache'] = {
              icon = '',
              color = '#4b32c3',
              name = 'Eslintrc',
            },
            ['.prettierrc'] = {
              icon = '',
              color = '#4285F4',
              name = 'PrettierConfig',
            },
            ['.yarnrc.yml'] = {
              icon = '',
              color = '#519aba',
              name = 'Yarn',
            },
            ['yarn.lock'] = {
              icon = '',
              color = '#519aba',
              name = 'Yarn',
            },
          },
        },
      },
    },
    config = function()
      require('oil').setup {
        skip_confirm_for_simple_edits = false,
        keymaps = {
          ['<C-h>'] = false,
          ['<C-l>'] = false,
          ['<C-p>'] = false,
          ['<C-q>'] = 'actions.add_to_qflist',
        },
        win_options = {
          -- Use the default status column with spacing after the line number
          statuscolumn = '',
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name)
            return (name == '..')
          end,
        },
        columns = {
          { 'icon', directory = '' },
        },
      }

      vim.keymap.set('n', '-', '<cmd>Oil<cr>')
    end,
  },
}
