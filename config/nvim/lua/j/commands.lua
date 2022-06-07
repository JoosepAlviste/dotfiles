-- Utility commands for reloading the configuration and restarting LSP
vim.api.nvim_create_user_command('Restart', function()
  require('j.utils').restart()
end, {})
vim.api.nvim_create_user_command('Reload', function()
  require('j.utils').reload()
end, {})

-- Compiler/linter commands
vim.api.nvim_create_user_command('Make', function()
  require('j.async_make').make()
end, {})
vim.api.nvim_create_user_command('TSC', function()
  require('j.async_make').make('tsc', true)
end, {})
vim.api.nvim_create_user_command('ESLint', function()
  require('j.async_make').make('eslint_d', true)
end, {})
