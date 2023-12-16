local M = {}

local disabling_comments = {
  eslint_d = 'eslint-disable-next-line %s',
}

---Add a comment to disable checking a lint rule on the current line.
function M.disable_current_line_lint_rule()
  local line = vim.fn.line '.' - 1
  local indent = vim.api.nvim_get_current_line():match '^%s*'

  local diagnostics = vim.tbl_filter(function(diagnostic)
    return vim.tbl_contains(vim.tbl_keys(disabling_comments), diagnostic.source)
  end, vim.diagnostic.get(0, { lnum = line }))
  if #diagnostics == 0 then
    vim.notify 'No diagnostics to disable'
    return
  end

  vim.ui.select(diagnostics, {
    prompt = 'Which diagnostic to disable?',
    format_item = function(item)
      return string.format('Disable "%s"', item.code)
    end,
    ---@param diagnostic Diagnostic
  }, function(diagnostic)
    if not diagnostic then
      return
    end

    local tscc_exists, ts_context_commentstring = pcall(require, 'ts_context_commentstring')
    local commentstring = tscc_exists and ts_context_commentstring.calculate_commentstring() or vim.bo.commentstring
    local previous_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]
    local code = diagnostic.code
    local comment_for_source = disabling_comments[diagnostic.source]

    local comment_for_source_with_placeholder =
      vim.pesc(string.format(commentstring, comment_for_source)):gsub('%%%%s', '(.*)')
    local already_disabled_rules = previous_line and previous_line:match(comment_for_source_with_placeholder)

    if already_disabled_rules and #already_disabled_rules then
      local comment =
        string.format(commentstring, string.format(comment_for_source, already_disabled_rules .. ', ' .. code))
      vim.api.nvim_buf_set_lines(0, line - 1, line, false, { indent .. comment })
    else
      local comment = string.format(commentstring, string.format(comment_for_source, code))
      vim.api.nvim_buf_set_lines(0, line, line, false, { indent .. comment })
    end

    vim.cmd [[silent write]]
  end)
end

return M
