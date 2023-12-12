local close_all_floating_windows = require('j.utils').close_all_floating_windows

return {
  'rmagatti/auto-session',
  opts = {
    -- Resize Neovim after it is started, otherwise the cmdheight might be
    -- super large when restoring the session
    -- https://github.com/rmagatti/auto-session/issues/64
    -- https://github.com/neovim/neovim/issues/11330
    post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' },
    pre_save_cmds = { close_all_floating_windows, 'cclose' },
    log_level = 'error',
    session_lens = {
      load_on_setup = false,
    },
  },
}
