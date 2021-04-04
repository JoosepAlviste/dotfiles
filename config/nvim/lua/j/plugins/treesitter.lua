require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  ensure_installed = {
    'query', 'javascript', 'jsdoc', 'typescript', 'tsx', 'json', 'php',
    'python', 'html', 'graphql', 'lua', 'vue', 'yaml', 'css', 'bash',
  },
}
