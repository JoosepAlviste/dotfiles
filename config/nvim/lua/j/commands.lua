vim.api.nvim_create_user_command('GitOpen', function()
  -- Current file
  local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  local file = vim.fn.expand('%:p'):gsub(vim.pesc(git_root .. '/'), '')
  local line = vim.fn.line '.'

  -- Git repo things
  local repo_url = vim.fn.system('git -C ' .. git_root .. ' config --get remote.origin.url')
  local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD'):gsub('\n', '')
  local commit_hash = vim.fn.system('git rev-parse HEAD'):gsub('\n', '')
  local git_ref = branch == 'HEAD' and commit_hash or branch

  -- Parse GitHub URL parts
  local ssh_url_captures = { string.find(repo_url, '.*@(.*)[:/]([^/]*)/([^%s/]*)') }
  local _, _, host, user, repo = unpack(ssh_url_captures)
  repo = repo:gsub('.git$', '')

  local github_repo_url =
    string.format('https://%s/%s/%s', vim.uri_encode(host), vim.uri_encode(user), vim.uri_encode(repo))
  local github_file_url = string.format(
    '%s/blob/%s/%s#L%s',
    vim.uri_encode(github_repo_url),
    vim.uri_encode(git_ref),
    vim.uri_encode(file),
    line
  )

  vim.fn.system('open ' .. github_file_url)
end, {})
