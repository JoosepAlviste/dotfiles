require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,
    persist_queries = false,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    'query', 'javascript', 'jsdoc', 'typescript', 'tsx', 'json', 'php', 
    'python', 'html', 'graphql', 'lua', 'yaml',
  },
}