local M = {}

function M.setup()
  -- vim.cmd [[let test#strategy = 'neoterm']]
  -- vim.cmd [[let test#javascript#jest#executable = 'TZ=UTC ./node_modules/.bin/jest']]

  if vim.fn.fnamemodify(vim.fn.getcwd(), ':t') then
    vim.cmd [[
    function! DockerTransform(cmd) abort
      return 'docker exec -it scoro_apache_php sh -c "cd scoro-base && ' .. a:cmd .. '"'
    endfunction

    let g:test#php#phpunit#executable = './vendor/bin/phpunit --configuration tests/scoro/integration/conf.xml'
    let g:test#custom_transformations = {'docker': function('DockerTransform')}
    let g:test#transformation = 'docker'
    ]]
  end

  vim.g.ultest_use_pty = 1
  vim.g.ultest_output_on_line = 0
end

return M
