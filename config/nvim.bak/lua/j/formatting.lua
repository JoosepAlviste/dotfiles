local function eslint()
  return {
    exe = 'eslint_d',
    args = {'-f', 'unix', '--fix-to-stdout', '--stdin', '--stdin-filename', vim.api.nvim_buf_get_name(0)},
    stdin = true,
  }
end

local function prettier()
  return {
    exe = './node_modules/.bin/prettier',
    args = {'--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'},
    stdin = true,
  }
end

require'formatter'.setup{
  logging = false,
  filetype = {
    javascript = { eslint },
    typescript = { eslint },
    typescriptreact = { eslint },
    vue = { eslint },
  }
}

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.tsx,*.vue silent! FormatWrite
augroup END
]], true)
