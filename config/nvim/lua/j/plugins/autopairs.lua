local autopairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
local ts_conds = require 'nvim-autopairs.ts-conds'

local map = require('j.utils').map

local function confirm()
  return autopairs.check_break_line_char()
end

autopairs.setup {
  check_ts = true,
  enable_moveright = true,
}

-- Typing space when (|) -> ( | )
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
autopairs.add_rules {
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      brackets[1][1] .. brackets[1][2],
      brackets[2][1] .. brackets[2][2],
      brackets[3][1] .. brackets[3][2],
    }, pair)
  end),
}
for _, bracket in pairs(brackets) do
  autopairs.add_rules {
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match('.%' .. bracket[2]) ~= nil
      end)
      :use_key(bracket[2]),
  }
end

autopairs.add_rules {
  -- Typing { when {| -> {{ | }} in Vue files
  Rule('{{', '  }', 'vue'):set_end_pair_length(2):with_pair(ts_conds.is_ts_node 'text'),

  -- Typing = when () -> () => {|}
  Rule('%(.*%)%s*%=$', '> {}', { 'typescript', 'typescriptreact', 'javascript', 'vue' })
    :use_regex(true)
    :set_end_pair_length(1),

  -- Typing n when the| -> then|end
  Rule('then', 'end', 'lua'):end_wise(function(opts)
    return string.match(opts.line, '^%s*if') ~= nil
  end),
}

map('i', '<cr>', confirm, { expr = true, noremap = true })
