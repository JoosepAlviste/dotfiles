local M = {}

function M.make(compiler, open_quickfix)
  if compiler then
    vim.cmd.compiler(compiler)
  end

  local lines = { '' }
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_win_get_buf(winnr)

  local makeprg = vim.api.nvim_buf_get_option(bufnr, 'makeprg')
  if not makeprg then
    return
  end

  local cmd = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == 'stdout' or event == 'stderr' then
      if data then
        vim.list_extend(lines, data)
      end
    end

    if event == 'exit' then
      local non_empty_lines = (vim.tbl_filter(function(line)
        return #line > 0
      end, lines))

      if #non_empty_lines > 0 then
        vim.fn.setqflist({}, ' ', {
          title = cmd,
          lines = lines,
          efm = vim.api.nvim_buf_get_option(bufnr, 'errorformat'),
        })
        vim.api.nvim_command 'doautocmd QuickFixCmdPost'
        if open_quickfix then
          vim.cmd.copen()
          vim.cmd.wincmd 'p'
        end
      else
        print 'No errors'
      end
    end
  end

  local job_id = vim.fn.jobstart(cmd, {
    on_stderr = on_event,
    on_stdout = on_event,
    on_exit = on_event,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

return M
