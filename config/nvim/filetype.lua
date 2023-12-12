-- Custom filetype detection logic with the new Lua filetype plugin
vim.filetype.add {
  extension = {
    es6 = 'javascript',
    mts = 'typescript',
    cts = 'typescript',
  },
  filename = {
    ['.eslintrc'] = 'json',
    ['.prettierrc'] = 'json',
    ['.babelrc'] = 'json',
    ['.stylelintrc'] = 'json',
  },
  pattern = {
    ['.*config/git/config'] = 'gitconfig',
    ['.env.*'] = 'sh',
  },
}
