---Call `:GitOpen dev` to open the file on the `dev` branch
vim.api.nvim_create_user_command('GitOpen', function(opts)
  -- Current file
  local start_line = opts.line1
  local end_line = opts.line2
  local has_selection = opts.range == 2

  local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  local file = vim.fn.expand('%:p'):gsub(vim.pesc(git_root .. '/'), '')

  -- Git repo things
  local repo_url = vim.fn.system('git -C ' .. git_root .. ' config --get remote.origin.url')
  ---@type string | nil
  local forced_branch = #opts.args > 0 and opts.args or nil
  local branch = forced_branch or vim.fn.system('git rev-parse --abbrev-ref HEAD'):gsub('\n', '')
  local commit_hash = vim.fn.system('git rev-parse HEAD'):gsub('\n', '')
  local git_ref = branch == 'HEAD' and commit_hash or branch

  -- Parse GitHub URL parts
  local ssh_url_captures = { string.find(repo_url, '.*@(.*)[:/]([^/]*)/([^%s/]*)') }
  local _, _, host, user, repo = unpack(ssh_url_captures)
  repo = repo:gsub('.git$', '')

  local github_repo_url =
    string.format('https://%s/%s/%s', vim.uri_encode(host), vim.uri_encode(user), vim.uri_encode(repo))
  local start_line_arg = has_selection and string.format('L%s', start_line)
  local has_end_line = start_line ~= end_line
  local end_line_arg = has_selection and has_end_line and string.format('L%s', end_line)
  local args = vim.tbl_filter(function(item)
    return item
  end, { start_line_arg, end_line_arg })
  local line_arg = table.concat(args, '-')

  local github_file_url = string.format(
    '%s/blob/%s/%s#%s',
    vim.uri_encode(github_repo_url),
    vim.uri_encode(git_ref),
    vim.uri_encode(file),
    line_arg
  )

  vim.fn.system('open ' .. github_file_url)
end, {
  nargs = '?',
  range = true,
  complete = function()
    local branches_str = vim.fn.system 'git branch'
    ---@type string[]
    local branches = {}
    for branch in string.gmatch(vim.trim(branches_str), '%S+') do
      table.insert(branches, branch)
    end
    return branches
  end,
})
