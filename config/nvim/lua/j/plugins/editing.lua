return {
  {
    'kylechui/nvim-surround',
    keys = { 'ys', 'cs', 'ds' },
    opts = {},
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').set_default_keymaps()
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    ft = { 'typescriptreact', 'vue' },
    config = function()
      require('ts_context_commentstring').setup {
        enable_autocmd = false,
      }

      local get_option = vim.filetype.get_option
      vim.filetype.get_option = function(filetype, option)
        return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring()
          or get_option(filetype, option)
      end
    end,
  },
  {
    'axelvc/template-string.nvim',
    opts = {
      filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
      remove_template_string = true,
      restore_quotes = {
        normal = [[']],
        jsx = [["]],
      },
    },
    event = 'InsertEnter',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
  },
  { 'echasnovski/mini.pairs', version = false, opts = {} },
  {
    'echasnovski/mini.ai',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      local treesitter = require('mini.ai').gen_spec.treesitter

      require('mini.ai').setup {
        custom_textobjects = {
          -- Whole buffer
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line '$',
              col = math.max(vim.fn.getline('$'):len(), 1),
            }
            return { from = from, to = to }
          end,

          -- Current line
          j = function(args)
            local index_of_first_non_whitespace_character = string.find(vim.fn.getline '.', '%S')
            local col = args == 'i' and index_of_first_non_whitespace_character or 1

            return {
              from = { line = vim.fn.line '.', col = col },
              to = { line = vim.fn.line '.', col = math.max(vim.fn.getline('.'):len(), 1) },
            }
          end,

          -- Function definition (needs treesitter queries with these captures)
          m = treesitter { a = '@function.outer', i = '@function.inner' },

          o = treesitter {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }
    end,
  },
}
