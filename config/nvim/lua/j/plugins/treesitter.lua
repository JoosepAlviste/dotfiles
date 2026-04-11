---@param bufnr integer
---@return boolean
local is_large_file = function(bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 100000
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          require('nvim-treesitter.parsers').vue = {
            install_info = {
              revision = 'd3a6a9b8170d93e05436ad792833a8b1e9995f5b',
              url = 'https://github.com/JoosepAlviste/tree-sitter-vue',
            },
          }
        end,
      })

      require('nvim-treesitter').install {
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
      }

      local group = vim.api.nvim_create_augroup('MyTreesitterSetup', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = {
          'vue',
          'typescript',
          'typescriptreact',
          'query',
          'markdown',
          'javascript',
          'json',
          'html',
          'graphql',
          'yaml',
          'css',
          'bash',
          'scss',
        },
        callback = function(args)
          if not is_large_file(args.buf) then
            vim.treesitter.start()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.wo[0][0].foldmethod = 'expr'
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end
        end,
      })
    end,
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
