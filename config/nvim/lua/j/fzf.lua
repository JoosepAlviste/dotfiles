local fzf = require('fzf').fzf

local map = require('j.utils').map

local M = {}

function M.setup()
  map('n', '<c-p>', [[<cmd>lua require('j.fzf').files()<cr>]])
end

function M.files()
  local command = 'fd --color always -t f -L --hidden'
  local preview = 'bat --line-range=:$($FZF_PREVIEW_LINES) --color always -- {}'

  coroutine.wrap(function ()
    local choices = fzf(
      command,
      ('--ansi --preview=%s --expect=ctrl-s,ctrl-t,ctrl-v --multi'):format(
        vim.fn.shellescape(preview)
      )
    )

    if not choices then return end

    local vimcmd
    if choices[1] == 'ctrl-t' then
      vimcmd = 'tabnew'
    elseif choices[1] == 'ctrl-v' then
      vimcmd = 'vnew'
    elseif choices[1] == 'ctrl-s' then
      vimcmd = 'new'
    else
      vimcmd = 'e'
    end

    for i=2,#choices do
      vim.cmd(vimcmd .. ' ' .. vim.fn.fnameescape(choices[i]))
    end
  end)()
end

return M
