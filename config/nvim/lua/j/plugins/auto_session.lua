local function close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

require('auto-session').setup {
  -- Resize Neovim after it is started, otherwise the cmdheight might be
  -- super large when restoring the session
  -- https://github.com/rmagatti/auto-session/issues/64
  -- https://github.com/neovim/neovim/issues/11330
  post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' },
  pre_save_cmds = { close_all_floating_wins, 'cclose' },
  log_level = 'error',
}
