local g = vim.g

local tree_cb = require('nvim-tree.config').nvim_tree_callback

local map = require('j.utils').map

local M = {}

function M.setup()
  -- Settings
  g.nvim_tree_git_hl = 1
  g.nvim_tree_auto_close = 1
  g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
  }
  g.nvim_tree_icons = {
    default = '',
    symlink = '',
    folder = {
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
  }
  g.nvim_tree_ignore = {'.git', '.DS_Store'}

  -- Mappings
  map('n', '<c-n>', ':NvimTreeToggle<cr>', {silent = true})


  -- In the tree
  g.nvim_tree_bindings = {
    ['p'] = tree_cb('close_node'),
  }
end

return M
