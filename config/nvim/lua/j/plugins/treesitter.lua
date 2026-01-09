local check_file_size = function(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 100000
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    init = function(plugin)
      require('lazy.core.loader').add_to_rtp(plugin)
      require 'nvim-treesitter.query_predicates'

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.vue = {
        install_info = {
          url = '~/Code/Projects/tree-sitter-vue',
          -- url = 'https://github.com/JoosepAlviste/tree-sitter-vue/',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'feature/component-name-with-dot',
        },
      }
    end,
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'lua',
        'query',
        'markdown',
        'markdown_inline',
        'javascript',
        'jsdoc',
        'typescript',
        'tsx',
        'json',
        'html',
        'graphql',
        'vue',
        'yaml',
        'css',
        'bash',
        'scss',
        'vim',
        'vimdoc',
        'sql',
        'regex',
      },
      highlight = {
        enable = true,
        disable = check_file_size,
      },
      indent = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    },
  },
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
}
