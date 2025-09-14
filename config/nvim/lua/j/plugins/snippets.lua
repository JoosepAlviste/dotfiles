return {
  'L3MON4D3/LuaSnip',
  event = 'InsertEnter',
  version = 'v2.*',
  build = 'make install_jsregexp',
  config = function()
    local ls = require 'luasnip'
    local types = require 'luasnip.util.types'

    ls.config.set_config {
      update_events = { 'TextChanged', 'TextChangedI' },
      delete_check_events = { 'InsertLeave' },
      region_check_events = { 'InsertEnter' },

      enable_autosnippets = true,

      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '●', 'LuasnipChoice' } },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { '●', 'LuasnipInsert' } },
          },
        },
      },
    }

    -- Mappings

    vim.keymap.set({ 'i', 's' }, '<tab>', function()
      if ls and ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        local termcode = require('j.utils').termcode
        vim.api.nvim_feedkeys(termcode '<Tab>', 'n', false)
      end
    end)
    vim.keymap.set({ 'i', 's' }, '<s-tab>', function()
      if ls.jumpable(-1) then
        return '<Plug>luasnip-jump-prev'
      else
        return '<s-tab>'
      end
    end, { expr = true })
    vim.keymap.set({ 'i', 's' }, '<c-k>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    -- Snippets

    require 'j.plugins.snippets.javascript'
    require 'j.plugins.snippets.lua'
    require 'j.plugins.snippets.typescript'
    require 'j.plugins.snippets.typescriptreact'
    require 'j.plugins.snippets.vue'

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LuasnipPreExpand',
      callback = function()
        local ensure_js_package_imported = require('j.treesitter_utils').ensure_js_package_imported
        local is_marketer_repo = require('j.modash').is_marketer_repo

        local snippet = require('luasnip').session.event_node
        local snippet_name = snippet.name

        -- TODO: This kinda sucks, it would be better if auto-import logic was
        -- next to snippet definition
        if snippet_name == 'factory' then
          return ensure_js_package_imported('Factory', 'fishery')()
        elseif snippet_name == 's' then
          return ensure_js_package_imported('useState', 'react')()
        elseif snippet_name == 'computed' then
          if not is_marketer_repo() then
            return ensure_js_package_imported('computed', 'vue')()
          end
        elseif snippet_name == 'style' then
          return ensure_js_package_imported('style', '@vanilla-extract/css')()
        elseif snippet_name == 'debug' then
          if not is_marketer_repo() then
            return ensure_js_package_imported('watchEffect', 'vue')()
          end
        elseif snippet_name == 'r' then
          if not is_marketer_repo() then
            return ensure_js_package_imported('ref', 'vue')()
          end
        end
      end,
    })
  end,
}
