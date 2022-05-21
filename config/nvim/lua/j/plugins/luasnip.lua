local ls = require 'luasnip'
local t = require('j.utils').termcode

ls.config.set_config {
  -- history = true,

  update_events = 'TextChanged,TextChangedI',

  -- enable_autosnippets = true,
}

-- Mappings

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if ls and ls.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  end
end

vim.keymap.set({ 'i', 's' }, '<tab>', 'v:lua.tab_complete()', { expr = true })

vim.keymap.set({ 'i', 's' }, '<s-tab>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- Reload snippets config
vim.keymap.set('n', '<leader>sl', '<cmd>source ~/.config/nvim/lua/j/plugins/luasnip.lua<cr>')

-- Snippets

require 'j.plugins.snippets.lua'
require 'j.plugins.snippets.javascript'
require 'j.plugins.snippets.typescript'
require 'j.plugins.snippets.typescriptreact'
require 'j.plugins.snippets.vue'
